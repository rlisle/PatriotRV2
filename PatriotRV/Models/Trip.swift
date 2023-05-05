//
//  Trip.swift
//  PatriotRV
//
//  This model represents a planned or previous trip
//  The CKRecord.ID is = date+destination
//
//  Created by Ron Lisle on 2/1/23.
//

import SwiftUI
import CloudKit
import PhotosUI

struct Trip  {
    let identifier: String
    let date: String        // MM-dd-yy
    let destination: String
    let notes: String?
    let address: String?
    let website: String?
    let phone: String?
    var photo: UIImage?
    
    static let recordType = "Trip"
    
    init(identifier: String,
        date: String,
        destination: String,
        notes: String? = nil,
        address: String? = nil,
        website: String? = nil,
         phone: String? = nil,
        photo: UIImage? = nil
    ) {
        self.identifier = identifier
        self.date = date
        self.destination = destination
        self.notes = notes
        self.address = address
        self.website = website
        self.phone = phone
        self.photo = photo ?? UIImage(systemName: "photo")
    }
    
    init?(from record: CKRecord) {
        var photo: UIImage? = nil
        guard
            record.recordType == Trip.recordType,
            let date = record["date"] as? String,
            let destination = record["destination"] as? String
        else {
            print("Error init Trip from CKRecord")
            return nil
        }
        let identifier = record.recordID.recordName
        let notes = record["notes"] as? String
        let address = record["address"] as? String
        let website = record["website"] as? String
        let phone = record["phone"] as? String
        if let asset = record["photo"] as? CKAsset,
           let url = asset.fileURL,
           let imageData = try? Data(contentsOf: url) {
            photo = UIImage(data: imageData)
        } else {
            photo = UIImage(systemName: "photo")
        }
        self = .init(
            identifier: identifier,
            date: date,
            destination: destination,
            notes: notes,
            address: address,
            website: website,
            phone: phone,
            photo: photo
        )
    }
    
    func toCKRecord() -> CKRecord {
        let recordID = CKRecord.ID(recordName: identifier)
        let record = CKRecord(recordType: Trip.recordType, recordID: recordID)
        record["date"] = date as CKRecordValue
        record["destination"] = destination as CKRecordValue
        record["notes"] = notes as? CKRecordValue
        record["address"] = address as? CKRecordValue
        record["website"] = website as? CKRecordValue
        record["phone"] = phone as? CKRecordValue
        return record
    }
    
    // eg. trip02-14-23.jpeg
    func fileName() -> String {
        return "trip" + date + ".jpeg"
    }
}

// I assume only 1 trip per day, so only comparee date
extension Trip: Equatable {
    static func ==(lhs: Trip, rhs: Trip) -> Bool {
        return lhs.date == rhs.date
    }
}

extension Trip: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(date)
    }
}
