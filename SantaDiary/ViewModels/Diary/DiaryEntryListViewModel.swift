//
//  DiaryEntryListViewModel.swift
//  SantaDiary
//
//  Created by Brian Veitch on 1/20/22.
//

import Foundation

class DiaryEntryListViewModel {
    
    var items: [DiaryEntry] = []
    
    init() {
        self.items = []
    }
    
    var count: Int {
        return items.count
    }
    
    func reload(for name: String) {
        self.items = DiaryManager.shared.getDiaryEntries(for: name)
    }
    
    func filter(monthYear: MonthYear) {
        
        var filteredItems: [DiaryEntry] = []
        
        for entry in items {
            let diaryViewModel = DiaryEntryViewModel(entry: entry)
            if diaryViewModel.month == monthYear.month && diaryViewModel.year == monthYear.year {
                filteredItems.append(entry)
            }
        }
        
        items = filteredItems
        print(items)
    }
    
    func getDiaryEntryViewModel(at indexPath: IndexPath) -> DiaryEntryViewModel {
        return DiaryEntryViewModel(entry: items[indexPath.row])
    }
    
}
