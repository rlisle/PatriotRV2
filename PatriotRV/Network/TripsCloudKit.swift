//
//  TripsCloudKit.swift
//  PatriotRV
//
//  Created by Ron Lisle on 4/5/23.
//

import CloudKit

//TODO: Convert Trip to CKRecord?

extension TripsModel {
    
    func loadTrips() async throws {
        print("load")
        do {
            let records = try await fetchTrips()
//            await MainActor.run {
                trips = records
//            }
            
        } catch {
            print("Error fetching trips")
            throw error
        }
        print("loaded")
    }

    private func fetchTrips() async throws -> [Trip] {
        print("fetch")
        let pred = NSPredicate(value: true)     // All records
        let sort = NSSortDescriptor(key: "date", ascending: false)
        let query = CKQuery(recordType: "Trip", predicate: pred)
        query.sortDescriptors = [sort]
        
        let response = try await CKContainer.default().publicCloudDatabase.records(matching: query, inZoneWith: nil, desiredKeys: nil, resultsLimit: 500)
        let records = response.matchResults.compactMap { try? $0.1.get() }
        print("fetched")
        return records.compactMap(Trip.init)
    }

    func saveTrips() async throws {
        for trip in trips {
            try await save(trip)
        }
    }
    
    func tripRecordID(_ trip: Trip) -> CKRecord.ID {
        return CKRecord.ID(recordName: trip.date)
    }
    
    func save(_ trip: Trip) async throws {
        print("save")
        guard let photo = trip.photo,
              let imageData = photo.jpegData(compressionQuality: 1.0) else {
            print("Unable to convert photo to data for saving")
            return
        }
        let database = CKContainer.default().publicCloudDatabase
        let record = CKRecord(recordType: "Trip") //, recordID: tripRecordID(trip))
        let url = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(trip.fileName(), conformingTo: .jpeg)
        do {
            try imageData.write(to: url)
        } catch {
            print("Error writing file to \(url.absoluteString): \(error)")
        }
        do {
            let asset = CKAsset(fileURL: url)
            record.setValuesForKeys([
                "date": trip.date,
                "destination": trip.destination,
                "notes": trip.notes ?? "",
                "address": trip.address ?? "?",
                "website": trip.website ?? "none",
                "photo": asset
            ])
            try await database.save(record)
        } catch {
            print("Error saving trip \(record.recordID.recordName): \(error)")
        }
        print("saved")
    }
    
    // Warning - deletes all trips
//    func deleteTripsFromCloud() async throws {
//        //TODO: perform this in parallel
//        for trip in trips {
//            try await deleteFromCloud(trip)
//        }
//        trips = []
//    }
    
    func add(_ trip: Trip) async throws {
        print("add")
        trips.append(trip)
        try await save(trip)
        print("added")
    }

    func delete(_ trip: Trip) async throws {
        print("delete")
        trips.removeAll(where: { $0 == trip })
        try await deleteFromCloud(trip)
        print("deleted")
    }

    private func deleteFromCloud(_ trip: Trip) async throws {
        print("deleteFromCloud")
        let database = CKContainer.default().publicCloudDatabase
        let recordID = tripRecordID(trip)
        do {
            print("Deleting record with id: \(recordID.recordName)")
            _ = try await database.deleteRecord(withID: recordID)
        } catch {
            print("Error deleting trip \(recordID.recordName): \(error)")
        }
        print("deleted from cloud")
    }
}
