//
//  Furniture.swift
//  MyLabHomeFurnitureSharing
//
//  Created by 曹家瑋 on 2023/10/12.
//

import Foundation

class Furniture {
    let name: String
    let description: String
    var imageData: Data?
    
    init(name: String, description: String, imageData: Data? = nil) {
        self.name = name
        self.description = description
        self.imageData = imageData
    }
    
}


