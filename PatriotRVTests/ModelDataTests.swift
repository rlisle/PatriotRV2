//
//  ViewModelTests.swift
//  PatriotRVTests
//
//  Created by Ron Lisle on 2/4/23.
//

import XCTest
@testable import PatriotRV

@MainActor
final class ModelDataTests: XCTestCase {

    var model: ViewModel!
    var mockMQTT: MQTTManagerProtocol!
    
    override func setUpWithError() throws {
        mockMQTT = MockMQTTManager()
        model = ViewModel(mqttManager: mockMQTT)
    }
    
    // CATEGORY
//    func test_currentPhase_parked() {
//        let expected = TripMode.parked
//        let date = Date("01/01/19")
//        let result = model.currentPhase(date: date)
//        XCTAssertEqual(result, expected)
//    }
//
//    //TODO: add other category cases
//    
//    func test_checklist_nextItem() {
//        let expectedId = "iceMachine"
//        setAllItemsBefore(order: 2020)
//        let result = model.nextItem()
//        XCTAssertEqual(result?.key, expectedId)
//    }
    
}
