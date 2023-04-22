//
//  Trips.swift
//  PatriotRV
//
//  Created by Ron Lisle on 2/3/23.
//

import Foundation

extension TripsModel {
        
    func seedTripData() {
        trips = [
            Trip(
                date: Date("07/26/22"),
                destination: "Wildwood RV and Golf Resort",
                notes: "Summer location, near Windsor, ON",
                address: "11112 11th Concession Rd, McGregor, ON NOR 1JO",
                website: "https://www.wildwoodgolfandrvresort.com",
                photo: nil),
            
            Trip(
                date: Date("10/31/22"),
                destination: "Halloween",
                notes: "Test trip for unit tests",
                address: "1234 Test Rd, Testville, TX",
                website: "https://www.wildwoodgolfandrvresort.com",
                photo: nil),
            
            Trip(
                date: Date("02/03/23"),
                destination: "Hampton Inn, Rockport",
                notes: "Checking out HEB RV sites",
                address: "3677 IH35 Rockport, TX 78382",
                website: "https://www.hilton.com/en/hotels/rpttxhx-hampton-suites-rockport-fulton/",
                photo: nil),
            
            Trip(
                date: Date("06/24/23"),
                destination: "Wildwood RV and Golf Resort",
                notes: "Summer location, near Windsor, ON. Leave after baby born. Arrive before 4th of July traffic.",
                address: "11112 11th Concession Rd, McGregor, ON NOR 1JO",
                website: "https://www.wildwoodgolfandrvresort.com",
                photo: nil)
        ]
    }
}
