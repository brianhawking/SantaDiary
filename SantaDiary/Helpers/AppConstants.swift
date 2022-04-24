//
//  AppConstants.swift
//  SantaDiary
//
//  Created by Brian Veitch on 12/23/21.
//

import Foundation

class App {
    
    static let appTitle = "Santa Diary"
    
    // segues
    class Segue {
        
        static let setParentalPasswordSegue: String = "setParentalPasswordSegue"
        
        static let ListToProfile: String = "ListToProfileSegue"
        static let ListToAddProfile: String = "toAddProfileSegue"
        static let toProfileImageSegue: String = "toProfileImageSegue"
        static let profileToDiarySegue: String = "profileToDiarySegue"
        static let profileToNiceListSegue: String = "profileToNiceListSegue"
        static let profileToWriteLetterSegue: String = "profileToWriteLetterSegue"
        static let profileToMailboxSegue: String = "profileToMailboxSegue"
        static let mailboxToShowLetterSegue: String = "mailboxToShowLetterSegue"
        static let profileToSettingsSegue: String = "profileToSettingsSegue"
        
        static let settingsToParentsLock: String = "settingsToParentsLock"
        static let settingsToEditProfile: String = "settingsToEditProfile"
        static let parentsLockToLetters: String = "parentsLockToLetters"
        static let parentsToWriteLetter: String = "parentsToWriteLetter"
        static let parentsToFeedback: String = "parentsToFeedback"
        static let parentsToProfile: String = "parentsToProfile"
        
        static let diaryToWriteEntry: String = "diaryToWriteEntry"
        static let diaryToReadEntry: String = "diaryToReadEntry"
        
        static let ListToCredits: String = "ListToCredits"
    }
    
    static let goals = [
        "Do your homework without being asked.",
        "Tell someone a joke to make them laugh.",
        "Make your bed.",
        "Donate a toy or book you do not play or read anymore.",
        "Help someone with their chores for the week.",
        "Give someone you care about a big hug.",
        "Make a drawing or piece of art for someone.",
        "Fold your own clothes",
        "Introduce yourself to someone new in your class. Invite them to play with you."
    ]
    
    static let elves = ["Bubbles", "Tickles"]
    
    static let avatars = ["TRex", "Bee-1", "HotDog", "Ankylosaurus","Styracosaurus", "Dog-1", "Footprint", "Pick", "SportsCar", "Sunflower"]
    
    static let holidayImages = ["OrnamentSanta", "OrnamentSnowman", "Sleigh", "Reindeer", "Snowman"]
    
    static let emojis:[String] = ["Happy", "Angry"]
    
    class envelope {
        static let opened = [
            "FromUser": "fromUser",
            "FromSanta": "fromSanta",
            "FromElf": "fromElf"
        ]
        static let new = "ClosedEnvelope"
    }
    
    
}
