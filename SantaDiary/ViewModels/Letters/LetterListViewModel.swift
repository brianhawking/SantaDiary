//
//  LetterListViewModel.swift
//  SantaDiary
//
//  Created by Brian Veitch on 1/6/22.
//

import Foundation
import UIKit

class LetterListViewModel {
    
    var items: [Letter] = []
    
    init() {
        self.items = []
    }
    
    var count: Int {
        return items.count
    }
    
    func reload(for name: String, type: LetterType) {
        self.items = LetterManager.shared.getLetters(for: name, type: type)
    }
    
    func getLetterViewModel(at indexPath: IndexPath) -> LetterViewModel {
        return LetterViewModel(letter: items[indexPath.row])
    }
}
