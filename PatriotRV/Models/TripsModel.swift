//
//  TripsModel.swift
//  PatriotRV
//
//  Created by Ron Lisle on 4/22/23.
//

import Foundation

class TripsModel: ObservableObject {
    
    @Published var trips: [Trip] = []

    var count: Int {
        get {
            return trips.count
        }
    }
    
    init(useMockData: Bool = false) {
        if useMockData {
            seedTripData()
        } else {
            trips = [loadingTrip()]
            Task {
                try await loadTrips()
            }
        }
    }

    func loadingTrip() -> Trip {
        Trip(
        date: Date("01/01/23"),
        destination: "TBD",
        notes: "Loading trips...",
        address: nil,
        website: nil,
        photo: nil)
    }

    func next(date: Date? = nil) -> Trip? {
        let today = date ?? Date()
        let tripsAfterDate = trips.filter { $0.date >= today }
        return tripsAfterDate.first
    }

    //Note: this does not save trips to cloud
    func add(_ trip: Trip) {
        trips.append(trip)
    }
    
    func contains(trip: Trip) -> Bool {
        return trips.contains(trip)
    }
    
    func update(_ trip: Trip) {
        
    }

    func delete(_ trip: Trip) {
        
    }
}
