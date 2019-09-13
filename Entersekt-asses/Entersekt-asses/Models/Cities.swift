//
//  Cities.swift
//  Entersekt-asses
//
//  Created by Rahul Shirphule on 2019/09/13.
//  Copyright © 2019 Entersekt. All rights reserved.
//

import Foundation

public struct Cities: Decodable {
    var id: String
    var name: String
    var malls: Malls
}

public struct Malls: Decodable {
    var id: String
    var name: String
    var shops: Shops
}

public struct Shops: Decodable {
    var id: String
    var name: String
}
