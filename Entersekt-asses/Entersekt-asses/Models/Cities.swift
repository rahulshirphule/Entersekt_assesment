//
//  Cities.swift
//  Entersekt-asses
//
//  Created by Rahul Shirphule on 2019/09/13.
//  Copyright © 2019 Entersekt. All rights reserved.
//

import Foundation

public struct Root: Decodable {
    var cities: [Cities]?;
}

public struct Cities: Decodable {
    var id: Int?
    var name: String?
    var malls: [Malls]?
}

public struct Citys: Decodable {
    public init() {}
    public var id: Int?
    public var name: String?
}

public struct Malls: Decodable {
    public init() {}
    public var id: Int?
    public var name: String?
    public var shops: [Shops]?
}

public struct Shops: Decodable {
    public init() {}
    public var id: Int?
    public var name: String?
}
