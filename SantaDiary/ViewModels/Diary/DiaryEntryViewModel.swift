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
    
    var text: String {
        
        var txt = ""
        for i in 0..<entry.prompts.count {
            txt += entry.prompts[i].question + "\n\n" + entry.prompts[i].answer + "\n\n"
        }
        
        return txt
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
