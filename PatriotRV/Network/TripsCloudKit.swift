//
//  TripsCloudKit.swift
//  PatriotRV
//
//  database: iCloud.net.lisles.PatriotRV
//  Trip records:
//     Name: YYYY-MM-DD
//     Address: String
//     Date: String YYYY-MM-DD
//     Destination: String
//     Notes: String
//     Photo: Asset (Binary jpeg)
//     PhotoData
//     Website: String
//
//  Note that date is used to create RecordID
//
//  Created by Ron Lisle on 4/5/23.
//

import CloudKit

@MainActor
extension TripsModel {
    
    func loadTrips() async throws {
        print("load")
        do {
            let records = try await fetchTrips()
            trips = records
        } catch {
            print("Error fetching trips")
            throw error
        }
        print("loaded")
    }

    private nonisolated func fetchTrips() async throws -> [Trip] {
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
    
    nonisolated func save(_ trip: Trip) async throws {
        print("save")
        guard let photo = trip.photo,
              let imageData = photo.jpegData(compressionQuality: 1.0) else {
            print("Unable to convert photo to data for saving")
            return
        }
        let database = CKContainer.default().publicCloudDatabase
        let record = await CKRecord(recordType: "Trip", recordID: tripRecordID(trip))
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
    func deleteAll() async throws {
        //TODO: perform this in parallel
        for trip in trips {
            do {
                try await deleteFromCloud(trip)
            } catch {
                print("Error deleting trip \(trip)")
            }
        }
        trips = []
    }
    
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
    
    
    
    
    // ChatGPT code - uses completion instead of async
//    func deleteRecord(withRecordType recordType: String,
//                      predicate: NSPredicate,
//                      completion: @escaping (Result<Void, Error>) -> Void) {
//        let container = CKContainer.default()
//        let publicDatabase = container.publicCloudDatabase
//        
//        let query = CKQuery(recordType: recordType, predicate: predicate)
//        
//        publicDatabase.perform(query, inZoneWith: nil) { (records, error) in
//            if let error = error {
//                DispatchQueue.main.async {
//                    completion(.failure(error))
//                }
//                return
//            }
//            
//            guard let records = records, !records.isEmpty else {
//                DispatchQueue.main.async {
//                    completion(.failure(NSError(domain: "No records found", code: -1, userInfo: nil)))
//                }
//                return
//            }
//            
//            let recordIDsToDelete = records.map { $0.recordID }
//            let deleteOperation = CKModifyRecordsOperation(recordsToSave: nil, recordIDsToDelete: recordIDsToDelete)
//            
//            deleteOperation.modifyRecordsCompletionBlock = { (_, deletedRecordIDs, error) in
//                DispatchQueue.main.async {
//                    if let error = error {
//                        completion(.failure(error))
//                    } else {
//                        completion(.success(()))
//                    }
//                }
//            }
//            
//            publicDatabase.add(deleteOperation)
//        }
//    }

}
