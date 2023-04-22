//
//  MockMQTTManager.swift
//  PatriotRV
//
//  Created by Ron Lisle on 2/18/23.
//

import Foundation

class MockMQTTManager: MQTTManagerProtocol {
    
    var messageHandler: ((String, String) -> Void)?

    var didConnect = false
    var publishedTopic = ""
    var publishedMessage = ""

    func connect() {
        didConnect = true
    }
    
    func publish(topic: String, message: String) {
        publishedTopic = topic
        publishedMessage = message
    }
    
    func sendTestMessage(topic: String, message: String) {
        messageHandler?(topic,message)
    }
}
