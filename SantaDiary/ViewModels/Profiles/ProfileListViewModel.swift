//
//  ProfileViewModel.swift
//  SantaDiary
//
//  Created by Brian Veitch on 12/24/21.
//

import Foundation
import UIKit

class ProfileListViewModel {
    
    var items: [Profile] = []
    
    init() {
        self.items = ProfileManager.shared.getProfiles()
    }
    
    var numberOfProfiles: Int {
        return self.items.count
    }
    
    func reloadProfiles() {
        self.items = ProfileManager.shared.getProfiles()
    }
    
    func getProfileViewModel( at indexPath: IndexPath ) -> ProfileViewModel {
        return ProfileViewModel(profile: items[indexPath.row])
    }
    
    func deleteProfileViewModel( at indexPath: IndexPath) {
        if ProfileViewModel(profile: items[indexPath.row]).deleteProfile() {
            reloadProfiles()
        }
    }
}

