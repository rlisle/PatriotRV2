//
//  Publishing.swift
//  PatriotRV
//
//  Created by Ron Lisle on 2/11/23.
//

import Foundation

protocol Publishing: AnyObject {
    func publish(key: String, isDone: Bool)
}
