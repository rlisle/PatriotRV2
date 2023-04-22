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
    
    override func setUpWithError() throws {
        model = ViewModel()
    }

    func test_creates_mqttManager() {
        XCTAssertNotNil(model.mqtt)
    }
    
    func test_mockMqttManager() {
        XCTAssertTrue(model.mqtt is MockMQTTManager)
    }

    func test_mqttMessageHandler_test_state_message() {
        if let mqtt = model.mqtt as? MockMQTTManager {
            mqtt.sendTestMessage(topic: "patriot/state/all/x/test", message: "55")
        } else {
            XCTFail("Error: model.mqtt is not MockMQTTManager")
        }
        XCTAssertEqual(model.lastMQTTTopicReceived, "patriot/state/all/x/test")
        XCTAssertEqual(model.lastMQTTMessageReceived,"55")
    }
    

}
