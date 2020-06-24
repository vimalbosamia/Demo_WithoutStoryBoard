//
//  TableViewCell.swift
//  iOS-Proficiency-Excercise-Vimal
//
//  Created by Vimal on 24/06/20.
//  Copyright © 2020 Vimal. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    let img:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.clipsToBounds = true
        return img
    }()
    
    let title:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let desc:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor =  UIColor.lightGray
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(img)
        containerView.addSubview(title)
        containerView.addSubview(desc)
        self.contentView.addSubview(containerView)
        
        self.preservesSuperviewLayoutMargins = true
        self.contentView.preservesSuperviewLayoutMargins = true
        
        img.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        img.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        img.widthAnchor.constraint(equalToConstant:70).isActive = true
        img.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.img.trailingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.heightAnchor.constraint(equalTo:self.contentView.heightAnchor, constant:-20).isActive = true
        
        title.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        title.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        
        desc.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        desc.topAnchor.constraint(equalTo:self.title.bottomAnchor).isActive = true
        desc.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        
        let containerViewHeightConstant = containerView.heightAnchor.constraint(equalToConstant: 1)
        containerViewHeightConstant.priority = UILayoutPriority.init(999)
        containerViewHeightConstant.isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
