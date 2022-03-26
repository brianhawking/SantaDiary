//
//  FeedbackViewModel.swift
//  SantaDiary
//
//  Created by Brian Veitch on 1/25/22.
//

import Foundation
import UIKit

struct FeedbackViewModel {
    
    let entry: Feedback
    
    init(feedback: Feedback) {
        self.entry = feedback
    }
    
    var name: String {
        return entry.name
    }
    
    var imageType: FeedbackImageType {
        switch self.image {
        case "Happy":
            return .happy
        default:
            return .angry
        }
    }
    
    var image: String {
        return entry.image
    }
    
    var feedback: String {
        return entry.feedback
    }
    
}

