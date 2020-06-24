//
//  Model.swift
//  iOS-Proficiency-Excercise-Vimal
//
//  Created by Vimal on 24/06/20.
//  Copyright © 2020 Vimal. All rights reserved.
//

import Foundation

struct ItemData:Codable {
    let title:String?
    var rows:[Item]
}

struct Item:Codable {
    let title, description, imageHref : String?

}
