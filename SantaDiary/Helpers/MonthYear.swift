//
//  MonthYear.swift
//  SantaDiary
//
//  Created by Brian Veitch on 1/23/22.
//

import Foundation

class MonthYear {
    var month: Int = 0
    var year: Int = 0
    
    init() {
        let calendar = Calendar.current
        self.month = calendar.component(.month, from: Date())
        self.year = calendar.component(.year, from: Date())
        
        print(month, year)
    }
    
    func asString() -> String {
        
        var date: String = ""
        
        switch month {
        case 1:
            date += "January"
        case 2:
            date += "February"
        case 3:
            date += "March"
        case 4:
            date += "April"
        case 5:
            date += "May"
        case 6:
            date += "June"
        case 7:
            date += "July"
        case 8:
            date += "August"
        case 9:
            date += "September"
        case 10:
            date += "October"
        case 11:
            date += "November"
        case 12:
            date += "December"
        default:
            date += " ERROR "
        }
        
        date += " \(year)"
        
        return date
    }
    
    func back() {
        
        month -= 1
        if month == 0 {
            month = 12
            year -= 1
        }
    }
    
    func forward() {
        
        let calendar = Calendar.current
        let m = calendar.component(.month, from: Date())
        let y = calendar.component(.year, from: Date())
        
        if m-1 < month && year >= y {
            return
        }
        
        month += 1
        
        if month == 13 {
            month = 1
            year += 1
        }
    }
    
    
}
