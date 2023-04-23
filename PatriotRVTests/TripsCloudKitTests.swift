//
//  TripsCloudKitTests.swift
//  PatriotRVTests
//
//  Created by Ron Lisle on 4/23/23.
//

import XCTest
import CloudKit
@testable import PatriotRV

@MainActor
final class TripsCloudKitTests: XCTestCase {

    var model: ViewModel!
    
    override func setUpWithError() throws {
        model = ViewModel()
    }

    func test_loadTrips() async throws {
        // Assert 4 mock data loaded initially
        XCTAssertEqual(model.trips.count, 4)
        // Start with empty array of trips
        model.trips.trips = []
        XCTAssertEqual(model.trips.count, 0)
        try await model.trips.loadTrips()
        XCTAssert(model.trips.count > 0)
    }
    
    func test_recordID() {
        let date = Date("02/02/23")
        let trip = Trip(date: date,
                        destination: "Test Destination")
        let result = model.trips.tripRecordID(trip)
        let expected = CKRecord.ID(recordName: "2/2/23")
        XCTAssertEqual(result,expected)
    }
    
    func test_saveTrip() {
        
    }
    
    
}
