//
//  MockTrip.swift
//  PatriotRV
//
//  Created by Ron Lisle on 4/3/23.
//

import Foundation

class Mock {
    static let trip = Trip(
        date: Date("10/31/22"),
        destination: "Halloween",
        notes: "Test trip for unit tests",
        address: "1234 Test Rd, Testville, TX",
        website: "https://www.wildwoodgolfandrvresort.com",
        photo: nil)
}
