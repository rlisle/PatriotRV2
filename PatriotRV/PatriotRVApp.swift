//
//  PatriotRVApp.swift
//  PatriotRV
//
//  Created by Ron Lisle on 4/22/23.
//

import SwiftUI

@main
struct PatriotRVApp: App {

    let performSeedData = false  // CAUTION: replaces all trip data
    
    // This is being run even during tests
    @StateObject private var viewModel = ViewModel()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(viewModel)
                .onAppear() {
                    viewModel.startCloud()
                    
                    if performSeedData {
                        viewModel.trips.seedTripData()
                        Task {
                            try? await viewModel.trips.saveTrips()
                        }
                    }
                    viewModel.startMQTT(mqttManager: MQTTManager())
                }
        }
    }
}
