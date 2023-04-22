//
//  DateExtension.swift
//  PatriotRV
//
//  Created by Ron Lisle on 2/1/23.
//

import Foundation

extension Date {
    init(_ string: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        self = dateFormatter.date(from: string) ?? Date()
    }
    
    func mmddyy() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: self)
    }
}
