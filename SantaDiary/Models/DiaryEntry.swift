//
//  DiaryEntry.swift
//  SantaDiary
//
//  Created by Brian Veitch on 1/20/22.
//

import Foundation

struct DiaryEntry: Codable {
    var author: String
    var date: Date
    var image: String
    var prompts: [DiaryPrompt]
    
    init(author: String, image: String, prompts: [DiaryPrompt]) {
        self.author = author
        self.date = Date()
        self.image = image
        self.prompts = prompts
    }
}

struct DiaryEntries: Codable {
    var entries: [DiaryEntry]
}
