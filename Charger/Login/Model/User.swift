//
//  User.swift
//  Charger
//
//  Created by Hakan Pekşen on 6.07.2022.
//

import Foundation

struct User: Decodable {
    var email: String?
    var token: String?
    var userId: Int?
  
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case token = "token"
        case userId = "userID"
    }
}
