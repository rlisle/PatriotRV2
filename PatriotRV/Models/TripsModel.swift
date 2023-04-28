//
//  TripsModel.swift
//  PatriotRV
//
//  Created by Ron Lisle on 4/22/23.
//

import Foundation

@MainActor
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
        date: "2023-01-01",
        destination: "TBD",
        notes: "Loading trips...",
        address: nil,
        website: nil,
        photo: nil)
    }

    func next(date: Date? = nil) -> Trip? {
        let today = date ?? Date()
        let tripsAfterDate = trips.filter {
            Date($0.date) >= today
        }
        return tripsAfterDate.first
    }

    func contains(trip: Trip) -> Bool {
        print("contains trip: \(trip)")
        let result = trips.contains(trip)
        print(" is \(result)")
        if result == false {
            print("trips = \(trips)")
        }
        //return trips.contains(trip)
        return result
    }
}
