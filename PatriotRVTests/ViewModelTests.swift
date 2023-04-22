//
//  ViewModelTests.swift
//  PatriotRVTests
//
//  Created by Ron Lisle on 2/4/23.
//

import XCTest
@testable import PatriotRV

@MainActor
final class ViewModelTests: XCTestCase {

    var model: ViewModel!
    
    override func setUpWithError() throws {
        model = ViewModel()
    }
    
    func test_init() throws {
        XCTAssertNotNil(model)
    }
    
    func test_formatter() throws {
        let dateString = "1999-12-31"
        let date = model.formatter.date(from: dateString)!
        let result = model.formatter.string(from: date)
        XCTAssertEqual(result, "1999-12-31")
    }
    
    func test_creates_mqttManager() {
        XCTAssertNotNil(model.mqtt)
    }
    
    func test_usesMockData() {
        XCTAssertTrue(model.usingMockData)
    }

    func test_mockMqttManager() {
        XCTAssertTrue(model.mqtt is MockMQTTManager)
    }

}
