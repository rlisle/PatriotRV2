//
//  PatriotRVApp.swift
//  PatriotRV
//
//  Created by Ron Lisle on 4/22/23.
//

import SwiftUI

@main
struct PatriotRVApp: App {

    @StateObject private var viewModel = ViewModel(mqttManager: MQTTManager())


    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
