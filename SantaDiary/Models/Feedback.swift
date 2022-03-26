//
//  Feedback.swift
//  SantaDiary
//
//  Created by Brian Veitch on 1/25/22.
//

import Foundation

struct Feedback: Codable {
    let name: String
    let image: String
    let feedback: String
}

enum FeedbackImageType: String {
    case happy = "Happy"
    case angry = "Angry"
}
