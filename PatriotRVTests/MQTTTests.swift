//
//  MQTTTests.swift
//  PatriotRVTests
//
//  Created by Ron Lisle on 4/22/23.
//

import XCTest
@testable import PatriotRV

@MainActor
final class MQTTTests: XCTestCase {

    var model: ViewModel!
    var mqtt: MockMQTTManager!
    
    override func setUpWithError() throws {
        model = ViewModel()
        mqtt = MockMQTTManager()
        model.startMQTT(mqttManager: mqtt)
    }

    func test_sets_mqttManager() {
        XCTAssertNotNil(model.mqtt)
        XCTAssertTrue(model.mqtt is MockMQTTManager)
    }
    
    func test_mqttMessageHandler_test_state_message() {
        mqtt.sendTestMessage(topic: "patriot/state/all/x/test", message: "55")
        XCTAssertEqual(model.lastMQTTTopicReceived, "patriot/state/all/x/test")
        XCTAssertEqual(model.lastMQTTMessageReceived,"55")
    }
    

}
