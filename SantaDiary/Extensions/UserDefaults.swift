//
//  UserDefaults.swift
//  SantaDiary
//
//  Created by Brian Veitch on 3/26/22.
//

import Foundation
import UIKit

extension UserDefaults {
    private enum UserDefaultKeys: String {
        case hasOnboarded
        case parentHasOnboarded
    }
    
    var hasOnboarded: Bool {
        get {
            bool(forKey: UserDefaultKeys.hasOnboarded.rawValue)
        }
        set {
            setValue(newValue, forKey: UserDefaultKeys.hasOnboarded.rawValue)
        }
    }
    
    var parentHasOnboarded: Bool {
        get {
            bool(forKey: UserDefaultKeys.parentHasOnboarded.rawValue)
        }
        set {
            setValue(newValue, forKey: UserDefaultKeys.parentHasOnboarded.rawValue)
        }
    }
}
