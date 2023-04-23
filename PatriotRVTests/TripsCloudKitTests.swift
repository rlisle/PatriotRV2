//
//  TripsCloudKitTests.swift
//  PatriotRVTests
//
//  Created by Ron Lisle on 4/23/23.
//

import XCTest
@testable import PatriotRV

@MainActor
final class TripsCloudKitTests: XCTestCase {

    var model: ViewModel!
    
    override func setUpWithError() throws {
        model = ViewModel()
    }

    func test_loadTrips() async throws {
        try await model.trips.loadTrips()
        XCTAssert(model.trips.count > 0)
    }
    
}
