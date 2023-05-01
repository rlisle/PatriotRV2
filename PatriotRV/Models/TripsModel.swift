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
    @Published var selectedTrip: Trip
    var usingMockData = false

    static var loadingTrip = Trip(
        date: "2023-01-01",
        destination: "TBD",
        notes: "Loading trips...",
        address: nil,
        website: nil,
        photo: nil
    )

    var count: Int {
        get {
            return trips.count
        }
    }
    
    init(useMockData: Bool = false) {
        usingMockData = useMockData
        selectedTrip = TripsModel.loadingTrip
        trips = [selectedTrip]
        if useMockData {
            seedTripData()
        } else {
            Task {
                print("loading Trips")
                try await loadTrips()
                print("trips loaded")
            }
        }
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
