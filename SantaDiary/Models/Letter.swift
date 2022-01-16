//
//  Letter.swift
//  SantaDiary
//
//  Created by Brian Veitch on 1/4/22.
//

import Foundation

class Letter: Codable {
    
    var author: String
    var authorType: String
    var recipient: String
    var content: String
    var date: Date
    var unread: Bool = true
    
    init(author: String, recipient: String, content: String, authorType: Author) {
        
//        switch authorType {
//        case .user:
//            self.authorType = "User"
//        case .elf:
//            self.authorType = "Elf"
//        case .santa:
//            self.authorType = "Santa"
//        }
        
        self.authorType = authorType.rawValue
        self.recipient = recipient
        self.author = author
        self.content = content
        self.date = Date()
        
        if authorType == .user {
            self.unread = false
        }
    }
}

struct Letters: Codable {
    var letters: [Letter]
}

enum Author: String {
    case user = "User"
    case santa = "Santa"
    case elf = "Elf"
}

enum LetterType {
    case sent
    case received
    case showAll
    case unread
}
