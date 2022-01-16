//
//  LetterViewModel.swift
//  SantaDiary
//
//  Created by Brian Veitch on 1/4/22.
//

import Foundation

struct LetterViewModel {
    
    let letter: Letter
    
    init(letter: Letter) {
        self.letter = letter
    }
    
    var author: String {
        
        if letter.authorType == "Elf" {
            return letter.author + " the Elf"
        }
        else {
            return letter.author
        }
        
        
    }
    
    var recipient: String {
        return letter.recipient
    }
    
    var authorType: String {
        return letter.authorType
    }
    
    var content: String {
        return letter.content
    }
    
    var unread: Bool {
        return letter.unread
    }
    
    var date: Date {
        return letter.date
    }
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: self.date)
    }
    
    var image: String {
        
        if self.unread == true {
            return App.envelope.new
        }
        
        switch authorType {
        case "User":
            return App.envelope.opened["FromUser"]!
        default:
            if authorType == "Santa" {
                return App.envelope.opened["FromSanta"]!
            }
            else {
                return App.envelope.opened["FromElf"]!
            }
        }
    }
    
    // READ
    func printAll() {
        print("------------------------")
        print("From: \(letter.author)")
        print("To: \(letter.recipient)")
        print("Unread: \(letter.unread)")
        print("-------------------------")
    }
    
    // UPDATE
    func updateReadStatus() {
        LetterManager.shared.updateLetterStatus(for: letter)
    }
    
}
