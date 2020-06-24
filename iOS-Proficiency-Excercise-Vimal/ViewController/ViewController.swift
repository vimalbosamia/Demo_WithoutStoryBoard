//
//  ViewController.swift
//  iOS-Proficiency-Excercise-Vimal
//
//  Created by Vimal on 24/06/20.
//  Copyright © 2020 Vimal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var viewModel:ViewModel!
    private var refreshControl = UIRefreshControl()
    
    let indicator:UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: CGRect(x:0, y:0, width:60, height:60))
        indicator.style = UIActivityIndicatorView.Style.medium
        return indicator
    }()
    
    let tableView:UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
    }()
    
    init(viewModel: ViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.viewModel.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = UIColor.white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(ViewController.refresh(sender:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        setupLayout()
        setLayoutConstraints()
        
        // Load content
        self.viewModel.getData()
    }
    
    @objc func refresh(sender:AnyObject) {
        self.viewModel.getData()
    }
    
    func setupLayout(){
        tableView.frame = view.bounds
        view.addSubview(tableView)
        
        indicator.center = self.tableView.center
        self.view.addSubview(indicator)
    }
    
    func setLayoutConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableViewCell
        let item = viewModel.items[indexPath.row]
        cell?.title.text = item.title
        cell?.desc.text = item.description
        cell?.img.image = UIImage(named: "placeholder.png")
        if let imagePath = item.imageHref {
            viewModel.obtainImageWithPath(imagePath: imagePath) { image in
                if let imageReceived = image, let updateCell = tableView.cellForRow(at: indexPath) as? TableViewCell {
                    updateCell.img.image = imageReceived
                }
            }
        }
        return cell!
    }
}

extension ViewController:ViewModelDelegate {
    func dataUpdated() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.navigationItem.title = self?.viewModel.title
            
            self?.indicator.stopAnimating()
            self?.indicator.hidesWhenStopped = true
            self?.refreshControl.endRefreshing()
        }
    }
}


