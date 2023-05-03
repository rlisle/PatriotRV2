//
//  TripsModel.swift
//  PatriotRV
//
//  Created by Ron Lisle on 4/22/23.
//

import Foundation

@MainActor
class TripsModel: ObservableObject {
    
    @Published var tripsState: Bool = false

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
                try await loadTrips()
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
        return trips.contains(trip)
    }
}
