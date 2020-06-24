//
//  ViewModel.swift
//  iOS-Proficiency-Excercise-Vimal
//
//  Created by Vimal on 24/06/20.
//  Copyright © 2020 Vimal. All rights reserved.
//

import Foundation
import UIKit

protocol ViewModelDelegate: class {
    func dataUpdated()
}

final class ViewModel {
    public weak var delegate: ViewModelDelegate?
    
    var title:String = ""
    var items: [Item] = [] {
        didSet {
            delegate?.dataUpdated()
        }
    }
    var cache:NSCache<NSString, UIImage> = NSCache()
    
    func getData() {
        DispatchQueue.main.async {
            Service.shared.fetchDataForFacts { (data) in
                guard let dataReceived = data, let title = data?.title else {
                    return
                }
                self.title = title
                self.items = dataReceived.rows
            }
        }
    }
    
    func obtainImageWithPath(imagePath: String, completionHandler: @escaping (UIImage?) -> Void) {
        if let image = self.cache.object(forKey: imagePath as NSString) {
            DispatchQueue.main.async {
                completionHandler(image)
            }
        } else {
            Service.shared.obtainImageDataWithPath(imagePath: imagePath, completionHandler: {(data) in
                guard let imageData = data else {
                    return
                }
                if let image = UIImage(data: imageData) {
                    self.cache.setObject(image, forKey: imagePath as NSString)
                    DispatchQueue.main.async {
                        completionHandler(image)
                    }
                }
            })
        }
    }
}
