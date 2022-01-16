//
//  SettingListViewModel.swift
//  SantaDiary
//
//  Created by Brian Veitch on 1/9/22.
//

import Foundation

class SettingListViewModel {
    
    var items: [Setting] = []
    
    init() {
//        self.items = ProfileManager.shared.getProfiles()
        self.items = [
            Setting(image: "Lock", name: "For Parents", segue: App.Segue.settingsToParentsLock),
            Setting(image: "UserImage", name: "Edit Profile", segue: App.Segue.settingsToEditProfile)
        ]
    }
    
    var count: Int {
        return self.items.count
    }
    
    func reloadProfiles() {
//        self.items = ProfileManager.shared.getProfiles()
    }
    
    func getSettingViewModel( at indexPath: IndexPath ) -> SettingViewModel {
        return SettingViewModel(setting: items[indexPath.row])
    }
    
}
