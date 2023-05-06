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
        let date = "02-02-23"
        let trip = Trip(identifier: date,
                        date: date,
                        destination: "Test Destination")
        let result = model.trips.tripRecordID(trip)
        let expected = CKRecord.ID(recordName: date)
        XCTAssertEqual(result,expected)
    }
    
    // Note: may need to run app and log into iCloud first
    func test_saveAndLoadTrip() async throws {
        continueAfterFailure = false

        // Create a new test trip
        let date = "11-28-21"
        let trip = Trip(identifier: date,
                        date: date,
                        destination: "Unit Test Destination")

        // Ensure it doesn't already exist in the cloud
        try await model.trips.loadTrips()
        if model.trips.contains(trip: trip) {
            print("Test trip wasn't previously deleted. Deleting now.")
            try await model.trips.delete(trip)
            try await model.trips.loadTrips()
            if model.trips.contains(trip: trip) {
                XCTFail("Failed to delete pre-existing test trip")
            }
        }

        // Add and save it to the cloud
        try await model.trips.add(trip)

        // Load it from the cloud
        // TODO: why does this require retries?
        var loops = 0
        repeat {
            try await model.trips.loadTrips()
            loops += 1
            print("loadTrips loop \(loops)")
        } while !model.trips.contains(trip: trip) && loops <= 10

        // This may take awhile, so might need ?
        XCTAssert(model.trips.contains(trip: trip))

        // Delete now that we're done
        try await model.trips.delete(trip)
    }
}
