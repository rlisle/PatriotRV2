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
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self = dateFormatter.date(from: string) ?? Date()
    }
    
    // 2/14/23
    func mmddyyForDisplay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: self)
    }
    
    // 2023-02-14
    func yyyymmddKey() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }

    // 20230214
    func asFileName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.string(from: self)
    }
}
