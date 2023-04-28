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
        print("setUpWithError")
        model = ViewModel()
        print("setted up")
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
        let date = "02-02-23"
        let trip = Trip(date: date,
                        destination: "Test Destination")
        let result = model.trips.tripRecordID(trip)
        let expected = CKRecord.ID(recordName: date)
        XCTAssertEqual(result,expected)
    }
    
    // Somehow this is NOT executing sequentially.
    // Adding or deleting a trip doesn't complete before .contains
    func test_saveAndLoadTrip() async throws {
        continueAfterFailure = false
        print("test_saveAndLoadTrip")

        // Create a new test trip
        let date = "11-28-21"
        let trip = Trip(date: date,
                        destination: "Unit Test Destination")

        // Ensure it doesn't already exist in the cloud
        try await model.trips.loadTrips()
        if model.trips.contains(trip: trip) {
            print("Test trip wasn't deleted correctly previously")
            try await model.trips.delete(trip)
            sleep(1)
            try await model.trips.loadTrips()
            sleep(1)
            if model.trips.contains(trip: trip) {
                XCTFail("Failed to delete pre-existing test trip")
            }
        }

        // Add and save it to the cloud
        print("About to add trip")
        try await model.trips.add(trip)
        print("Trip added")

        sleep(1)

        // Load it from the cloud
        print("About to load from cloud")
        try await model.trips.loadTrips()
        print("Loaded from cloud")

        sleep(1)

        print("About to asset contains")
        XCTAssert(model.trips.contains(trip: trip))
        print("Asserted")

        // Delete now that we're done
        print("About to cleanup/delete trip")
        try await model.trips.delete(trip)
        print("test done")
    }
    
    
}
