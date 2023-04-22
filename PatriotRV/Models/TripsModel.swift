//
//  TripsModel.swift
//  PatriotRV
//
//  Created by Ron Lisle on 4/22/23.
//

import Foundation

class TripsModel: ObservableObject {
    
    @Published var trips: [Trip] = []
    @Published var selectedTripIndex: Int = 0

    var count: Int {
        get {
            return trips.count
        }
    }
    
    init(useMockData: Bool = false) {
        if useMockData {
            seedTripData()  // Should I always do this?
        } else {
//            setLoadingTrip()
//            Task {
//                try await loadTrips()
//                //TODO: set selectedTripIndex
//            }
        }
    }
    
    func next(date: Date? = nil) -> Trip? {
        let today = date ?? Date()
        let tripsAfterDate = trips.filter { $0.date >= today }
        return tripsAfterDate.first
    }

    // Share trips to UserDefaults for use by widgets, etc.
    func persist() {
        if let trip = next(date: Date()) {
            UserDefaults(suiteName: "group.net.lisles.patriotrv")!.setValue(trip.destination, forKey: "NextTrip")
        }
    }
    
    func add(_ trip: Trip) {
        trips.append(trip)
    }
    
    func update(_ trip: Trip) {
        
    }
    
}
