//
//  DiaryEntryViewModel.swift
//  SantaDiary
//
//  Created by Brian Veitch on 1/20/22.
//

import Foundation

struct DiaryEntryViewModel {
    
    let entry: DiaryEntry
    
    init(entry: DiaryEntry) {
        self.entry = entry
    }
    
    var preview: String {
        return entry.prompts[1].answer
    }
    
    var month: Int {
        let calendar = Calendar.current
        return calendar.component(.month, from: entry.date)
    }
    
    var year: Int {
        let calendar = Calendar.current
        return calendar.component(.year, from: entry.date)
    }
    
    var prompts: [DiaryPrompt] {
        return entry.prompts
    }
    
    var text: String {
        
        var txt = ""
        for i in 0..<entry.prompts.count {
            txt += entry.prompts[i].question + "\n\n" + entry.prompts[i].answer + "\n\n"
        }
        
        return txt
    }
    
    var image: String {
        return entry.image
    }
    
    var date: Date {
        return entry.date
    }

    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: self.date)
    }
}
