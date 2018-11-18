//
//  Constants.swift
//  PostsList
//
//  Created by Kostiantyn Bilyk on 18.11.18.
//  Copyright © 2018 Kostiantyn Bilyk. All rights reserved.
//

import Foundation

enum JSONKeys {
    static let identifier = "id"
    static let name = "name"
    static let username = "username"
    static let email = "email"
    static let address = "address"
    static let street = "street"
    static let suit = "suit"
    static let city = "city"
    static let zipcode = "zipcode"
    static let title = "title"
    static let body = "body"
}

enum SegueIdentifiers {
    static let usersToPosts = "UsersToPostsSegue"
}
