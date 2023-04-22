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
    let date: Date
    let destination: String
    let notes: String?
    let address: String?
    let website: String?
    var photo: UIImage?    // JPEG data
    
    init(date: Date,
        destination: String,
        notes: String?,
        address: String?,
        website: String?,
        photo: UIImage? = nil
    ) {
        self.date = date
        self.destination = destination
        self.notes = notes
        self.address = address
        self.website = website
        self.photo = photo
    }
    
    init?(from record: CKRecord) {
        var photo: UIImage? = nil
        guard
            let date = record["date"] as? Date,
            let destination = record["destination"] as? String
        else { return nil }
        let notes = record["notes"] as? String
        let address = record["address"] as? String
        let website = record["website"] as? String
        if let asset = record["photo"] as? CKAsset,
           let url = asset.fileURL,
           let imageData = try? Data(contentsOf: url) {
            photo = UIImage(data: imageData)
        }
        self = .init(
            date: date,
            destination: destination,
            notes: notes,
            address: address,
            website: website,
            photo: photo
        )
    }
    
    //TODO: may want to remove slashes, dashes, etc.
    func dateString() -> String {
        return DateFormatter().string(from: self.date)
    }
    
//    func isWithin2weeks(today: Date) -> Bool {
//        guard let twoWeeksFromToday = Calendar.current.date(byAdding: .weekOfYear, value: 2, to: today) else {
//            return false
//        }
//        return date <= twoWeeksFromToday
//    }
}

extension Trip: Equatable {
    static func ==(lhs: Trip, rhs: Trip) -> Bool {
        return lhs.destination == rhs.destination
        && lhs.date == rhs.date
    }
}

extension Trip: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(destination)
        hasher.combine(date)
    }
}
