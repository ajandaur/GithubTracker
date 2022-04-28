//
//  Date+Ext.swift
//  GithubTracker
//
//  Created by Anmol  Jandaur on 4/27/22.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }

}

