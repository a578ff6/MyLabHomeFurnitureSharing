//
//  Room.swift
//  MyLabHomeFurnitureSharing
//
//  Created by 曹家瑋 on 2023/10/12.
//

import Foundation


class Room {
    let name: String
    let furniture: [Furniture]
    
    init(name: String, furniture: [Furniture]) {
        self.name = name
        self.furniture = furniture
    }
}
