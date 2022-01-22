//
//  ProfileViewModel.swift
//  SantaDiary
//
//  Created by Brian Veitch on 12/25/21.
//

import Foundation
import UIKit

struct ProfileViewModel {
    
    let profile: Profile
    
    init(profile: Profile) {
        self.profile = profile
    }
    
    var name: String {
        return profile.name
    }
    
    var customImage: Bool {
        return profile.customImage
    }
    
    var date: Date {
        return profile.birthday
    }
    
    var image: UIImage {
        let imagePath = ProfileManager.shared.profileImageURL(name: profile.name).path
        guard let image = UIImage(contentsOfFile: imagePath) else {
            return UIImage(systemName: "person.fill.badge.plus")!
        }
        
        return image
    }
    
    var age: String {
        let date = Date()
        let year = Calendar.current.dateComponents([.year], from: profile.birthday, to: date).year
        return String(year!)
    }
    
    func deleteProfile() -> Bool {
        if ProfileManager.shared.deleteProfile(profile: profile) {return true}
        return false
    }
    
}
