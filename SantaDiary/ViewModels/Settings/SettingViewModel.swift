//
//  SettingViewModel.swift
//  SantaDiary
//
//  Created by Brian Veitch on 1/9/22.
//

import Foundation
import UIKit

struct SettingViewModel {
    
    let setting: Setting
    
    init(setting: Setting) {
        self.setting = setting
    }
    
    var name: String {
        return setting.name
    }
    
    var segue: String {
        return setting.segue
    }
    
    var customImage: Bool {
        return setting.customImage
    }
    
    var image: UIImage {
        
        if setting.image != "UserImage" {
            return UIImage(named: setting.image)!
        }
        else {
            let profileName = UserDefaults.standard.string(forKey: "SelectedProfile")
            let profile = ProfileManager.shared.getProfile(name: profileName!)
            let imagePath = ProfileManager.shared.profileImageURL(name: profile.name).path
            guard let image = UIImage(contentsOfFile: imagePath) else {
                return UIImage(systemName: "person.fill.badge.plus")!
            }
            
            return image
        }
        
        
    }
    
}
