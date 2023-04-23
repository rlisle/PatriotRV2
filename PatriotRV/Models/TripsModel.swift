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
        seedTripData()
        if !useMockData {
            Task {
                try await loadTrips()
            }
        }
    }
    
    func next(date: Date? = nil) -> Trip? {
        let today = date ?? Date()
        let tripsAfterDate = trips.filter { $0.date >= today }
        return tripsAfterDate.first
    }

    func add(_ trip: Trip) {
        trips.append(trip)
    }
    
    func update(_ trip: Trip) {
        
    }

    func delete(_ trip: Trip) {
        
    }
}
