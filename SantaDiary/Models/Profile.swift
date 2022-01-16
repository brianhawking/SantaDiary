//
//  Profile.swift
//  SantaDiary
//
//  Created by Brian Veitch on 12/24/21.
//

import Foundation

struct Profile: Codable {
    
    var userID: Int
    var name: String
    var image: String
    var birthday: Date
    var customImage: Bool
}

struct Profiles: Codable {
    var profiles: [Profile]
}
