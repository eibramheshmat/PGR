//
//  ReposModel.swift
//  PGR
//
//  Created by Ibram on 26/11/2020.
//  Copyright © 2020 Ibram. All rights reserved.
//

import Foundation

struct ReposModel: Codable {
    var id: Int?
    var name: String?
    var full_name: String?
    var description: String?
    var owner = ownerObj()
}

struct ownerObj: Codable {
    var login: String?
    var avatar_url: String?
    var repos_url: String?
    var html_url: String?
}

struct Response<T> {
    var data: T?
    var error: String?
}


struct PhotoRequestParams: Codable{
    var text: String
}
