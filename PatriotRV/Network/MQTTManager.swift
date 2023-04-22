//
//  MQTTManager.swift
//  RvChecklist
//
//  Currently using CocoaMQTT because it supports MQTT 5
//  Was using SwiftMQTT but it doesn't support MQTT5
//  Was using Swift Package install, but it broke previews
//  so reverted back to CocoaPods installation
//
//  Created by Ron Lisle on 10/23/21.
//

import Foundation
import CocoaMQTT

public enum MQTTError: Error {
    case connectionError
    case publishError
    case subscribeError
}

protocol MQTTManagerProtocol {
    func connect()
    func publish(topic: String, message: String)
    var messageHandler: ((String, String) -> Void)? { get set }
}

class MQTTManager: MQTTManagerProtocol {
    
    let host = "192.168.50.33"      // "localhost" for testing, else 192.168.50.33
    let port: UInt16 = 1883
    let subscribeTopic = "#"
    var clientID: String = ""

    var mqtt: CocoaMQTT!            // For some reason CocoaMQTT5 not found
    
    var messageHandler: ((String, String) -> Void)?
    
    var isSubscribed = false
    
    var isConnected: Bool {
        get {
            return mqtt != nil
        }
    }

// Call connect when ready to receive MQTT messages
//    init() {
//        connect()
//    }
    
    func connect() {
        print("MQTT connect")
        clientID = getClientID()
        mqtt = CocoaMQTT(clientID: clientID, host: host, port: port)
        mqtt.delegate = self
        mqtt.connect()
    }

    private func subscribe() {
        print("MQTT subscribe")
        mqtt.subscribe(subscribeTopic)
        isSubscribed = true
        requestUpdates()
    }

    private func requestUpdates() {
        print("MQTT requestUpdates")
        // This requests every patriot controller to send its current devices states
        publish(topic: "patriot/query", message: "All")
    }

    func publish(topic: String, message: String) {
        print("MQTT publish \(topic), \(message)")
        mqtt.publish(topic, withString: message)
    }

    private func getClientID() -> String {
        let userDefaults = UserDefaults.standard
        let clientIDPersistenceKey = "clientID"
        let clientID: String

        if let savedClientID = userDefaults.object(forKey: clientIDPersistenceKey) as? String {
            clientID = savedClientID
        } else {
            clientID = randomString(length: 5)
            userDefaults.set(clientID, forKey: clientIDPersistenceKey)
            userDefaults.synchronize()
        }
        return clientID
    }
    
    // http://stackoverflow.com/questions/26845307/generate-random-alphanumeric-string-in-swift
    private func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
}

extension MQTTManager: CocoaMQTTDelegate {

    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
        print("MQTT didDisconnect")
    }
    
    
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        print("MQTT didConnectAck")
        subscribe()
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        //print("MQTT didPublishMessage: \(message.topic): \(String(describing: message.string))")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        //print("MQTT didPublishAck")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16 ) {
        //print("MQTT didReceiveMessage")
        if let handler = messageHandler {
            handler(message.topic, message.string ?? "")
        }
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopics success: NSDictionary, failed: [String]) {
        print("MQTT didSubscribeTopics")
    }
    

//    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopic topic: String) {
//        print("MQTT didUnsubscribe topic")
//    }
    
    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopics topics: [String]) {
        print("MQTT didUnsubscribe topics")
    }

    func mqttDidPing(_ mqtt: CocoaMQTT) {
        //print("MQTT ping)")
    }
    
    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
        //print("MQTT pong")
    }
    
}
