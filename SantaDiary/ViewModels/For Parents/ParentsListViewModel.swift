//
//  ParentsListViewModel.swift
//  SantaDiary
//
//  Created by Brian Veitch on 1/9/22.
//

import Foundation

class ParentsListViewModel {
    
    var items: [Setting] = []
    
    init() {
        self.items = [
            Setting(image: "fromSanta", name: "From Santa", segue: App.Segue.parentsToWriteLetter),
            Setting(image: "fromElf", name: "From Elf", segue: App.Segue.parentsToWriteLetter),
            Setting(image: "SantaClaus3", name: "Nice List Feedback", segue: App.Segue.parentsToFeedback),
            Setting(image: "UserImage", name: "Back to Profile", segue: App.Segue.parentsToProfile)
        ]
    }
    
    var count: Int {
        return self.items.count
    }
    
    func reloadProfiles() {
//        self.items = ProfileManager.shared.getProfiles()
    }
    
    func getSettingViewModel( at indexPath: IndexPath ) -> ParentsViewModel {
        return ParentsViewModel(setting: items[indexPath.row])
    }
    
}
