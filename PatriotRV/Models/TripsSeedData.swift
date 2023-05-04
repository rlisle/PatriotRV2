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
                identifier: "2022-07-26",
                date: "2022-07-26",
                destination: "Wildwood RV and Golf Resort",
                notes: "Summer location, near Windsor, ON",
                address: "11112 11th Concession Rd, McGregor, ON NOR 1JO",
                website: "https://www.wildwoodgolfandrvresort.com",
                phone: "519.726.6176",
                photo: nil),
            
            Trip(
                identifier: "2022-10-31",
                date: "2022-10-31",
                destination: "Halloween",
                notes: "Test trip for unit tests",
                address: "1234 Test Rd, Testville, TX",
                website: "https://www.wildwoodgolfandrvresort.com",
                phone: "519.726.6176",
                photo: nil),
            
            Trip(
                identifier: "2023-02-03",
                date: "2023-02-03",
                destination: "Hampton Inn, Rockport",
                notes: "Checking out HEB RV sites",
                address: "3677 IH35 Rockport, TX 78382",
                website: "https://www.hilton.com/en/hotels/rpttxhx-hampton-suites-rockport-fulton/",
                phone: "361.727.2228",
                photo: nil),
            
            Trip(
                identifier: "2023-06-24",
                date: "2023-06-24",
                destination: "Wildwood RV and Golf Resort",
                notes: "Summer location, near Windsor, ON. Leave after baby born. Arrive before 4th of July traffic.",
                address: "11112 11th Concession Rd, McGregor, ON NOR 1JO",
                website: "https://www.wildwoodgolfandrvresort.com",
                phone: "519.726.6176",
                photo: nil)
        ]
    }
}
