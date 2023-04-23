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
        // Load model using mock (default) data
        model = ViewModel()
    }

    func test_mock_trips_count_is_4() throws {
        XCTAssertEqual(model.trips.count,4)
    }

    func test_loadingTrip() {
        let trip = model.trips.loadingTrip()
        XCTAssertEqual(trip.destination, "TBD")
        XCTAssertEqual(trip.notes, "Loading trips...")
    }
    
    // NEXT
    func test_next_oldest() throws {
        let oldDate = model.formatter.date(from: "2020-01-01")
        guard let nextTrip = model.trips.next(date: oldDate) else {
            XCTFail("Trip.next not returned")
            return
        }
        let resultString = model.formatter.string(from: nextTrip.date)
        XCTAssertEqual(resultString, "2022-07-26")
    }

    func test_next_middle() throws {
        let oldDate = model.formatter.date(from: "2022-09-23")
        guard let nextTrip = model.trips.next(date: oldDate) else {
            XCTFail("Trip.next not returned")
            return
        }
        let resultString = model.formatter.string(from: nextTrip.date)
        XCTAssertEqual(resultString, "2022-10-31")
    }

    func test_next_most_recent() throws {
        let oldDate = model.formatter.date(from: "2023-02-04")
        guard let nextTrip = model.trips.next(date: oldDate) else {
            XCTFail("Trip.next not returned")
            return
        }
        let resultString = model.formatter.string(from: nextTrip.date)
        XCTAssertEqual(resultString, "2023-06-24")
    }

}
