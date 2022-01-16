//
//  ProgressBarViewModel.swift
//  SantaDiary
//
//  Created by Brian Veitch on 1/10/22.
//

import Foundation
import UIKit

class ProgressBarViewModel {
    
    let progressBar: ProgressBar
    
    init(progressBar: ProgressBar) {
        self.progressBar = progressBar
    }
    
    var name: String {
        return progressBar.name
    }
    
    var overallCount: String {
        return String(progressBar.overallCount)
    }
    
    private var currentCount: Int {
        return progressBar.overallCount%4
    }
    
    var barProgress: CGFloat {
        return CGFloat(currentCount/4)
    }
    
}
