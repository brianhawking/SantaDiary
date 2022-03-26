//
//  DiaryPrompt.swift
//  SantaDiary
//
//  Created by Brian Veitch on 1/20/22.
//

import Foundation

enum ReadOrWrite {
    case read
    case write
}

enum QuestionOrder {
    case initial
    case random
}

enum QuestionType: String {
    case initial = "How are you doing today?"
    case learning = "What is one thing you learned today?"
    case kindness = "What is one kind thing you did for someone?"
    case smile = "What is one thing that made you smile today?"
}

struct NiceListProgress {
    var kindness: Int
    var learning: Int
    var smile: Int
}

struct DiaryPrompt: Codable {
    var question: String
    var answer: String
    
    init(type: QuestionOrder) {
        
        // get day of month as int
        let dayOfMonth = Calendar.current.dateComponents([.day], from: Date())
        
        switch type {
        case .initial:
            self.question = QuestionType.initial.rawValue
            
        case .random:
         
            switch ( (dayOfMonth.day ?? 0) % 3) {
                
            case 0:
                self.question = QuestionType.kindness.rawValue
            case 1:
                self.question = QuestionType.learning.rawValue
            default:
                self.question = QuestionType.smile.rawValue
            }
            
        }
        
        self.answer = ""
    }
}

