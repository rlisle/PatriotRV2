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

    // LOADINGTRIP
    func test_loadingTrip() {
        let trip = TripsModel.loadingTrip
        XCTAssertEqual(trip.date, "2023-01-01")
        XCTAssertEqual(trip.destination, "TBD")
        XCTAssertEqual(trip.notes, "Loading trips...")
    }
    
    // COUNT
    func test_mock_trips_count_is_4() throws {
        XCTAssertEqual(model.trips.count,4)
    }

    // INIT
    func test_usingMockData_set_byDefault() {
        XCTAssertTrue(model.trips.usingMockData)
    }

    func test_selectedTrip_initially_loadingTrip() {
        XCTAssertEqual(model.trips.selectedTrip, TripsModel.loadingTrip)
    }
    
    // NEXT
    func test_next_oldest() throws {
        let oldDate = Date("2020-01-01")
        guard let nextTrip = model.trips.next(date: oldDate) else {
            XCTFail("Trip.next not returned")
            return
        }
        XCTAssertEqual(nextTrip.date, "2022-07-26")
    }

    func test_next_middle() throws {
        let oldDate = Date("2022-09-23")
        guard let nextTrip = model.trips.next(date: oldDate) else {
            XCTFail("Trip.next not returned")
            return
        }
        XCTAssertEqual(nextTrip.date, "2022-10-31")
    }

    func test_next_most_recent() throws {
        let oldDate = Date("2023-02-04")
        guard let nextTrip = model.trips.next(date: oldDate) else {
            XCTFail("Trip.next not returned")
            return
        }
        XCTAssertEqual(nextTrip.date, "2023-06-24")
    }

}
