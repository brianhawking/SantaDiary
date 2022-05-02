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
    
    static let avatars = ["activity_guitar", "activity_music-notes", "activity_piano", "activity_run", "activity_tennis-racket", "activity_american-football", "activity_art", "activity_baseball", "activity_basketball", "activity_soccer-player", "animal_anglerfish", "animal_butterfly", "animal_chameleon", "animal_dog", "animal_Dog-1", "animal_dolphin", "animal_eagle", "animal_frog", "animal_giraffe", "animal_horse", "animal_hummingbird", "animal_koala", "animal_ladybug-1", "animal_owl", "animal_seahorse", "animal_shark", "animal_sloth", "animal_wolf", "animal_dragon",  "dino_TRex", "animal_Bee", "dino_Ankylosaurus","dino_Styracosaurus", "dino_ampelosaurus", "dino_beipiaosaurus", "dino_edmontosaurus", "dino_parasaurolophus", "dino_scelidosaurus", "dino_styracosaurus-1", "dino_triceratops", "dino_volcano", "Footprint", "Pick", "SportsCar", "outdoor_Sunflower", "flower", "outdoor_rainbow", "outdoor_sunflower-1", "outdoor_tree", "food_HotDog", "food_ice-cream", "food_pizza"]
    
    static let holidayImages = ["santa-claus", "christmas-tree", "Sleigh", "ornament", "Reindeer", "Snowman"]
    
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
