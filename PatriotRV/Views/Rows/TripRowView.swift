//
//  TripRowView.swift
//  PatriotRV
//
//  Created by Ron Lisle on 2/17/23.
//

import SwiftUI

struct TripRowView: View {
    
    @EnvironmentObject var model: ViewModel
    let trip: Trip?
    
    var body: some View {
        if let trip = trip {
            VStack(alignment: .leading) {
                HStack {
                    Text(trip.destination)
                    Spacer()
                    Text(trip.date)
                }
            }
        } else {
            Text("Add a New Trip")
                .font(.headline)
        }
    }
}

struct TripRowView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            TripRowView(trip: Mock.trip)
                .environmentObject(ViewModel())
        }
        .modifier(PreviewDevices())
    }
}
