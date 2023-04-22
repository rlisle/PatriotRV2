//
//  TripsTests.swift
//  PatriotRVTests
//
//  Created by Ron Lisle on 4/22/23.
//

import XCTest
@testable import PatriotRV

@MainActor
final class TripsTests: XCTestCase {

    var model: ViewModel!
    
    override func setUpWithError() throws {
        model = ViewModel()
    }

    func test_init() throws {
        XCTAssertNotNil(model.trips)
    }

    func test_seedData_count() throws {
        XCTAssertEqual(model.trips.count,4)
    }

}
