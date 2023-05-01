//
//  TripRowView.swift
//  PatriotRV
//
//  Created by Ron Lisle on 2/17/23.
//

import SwiftUI

struct TripRowView: View {
    
    @EnvironmentObject var model: ViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(model.trips.selectedTrip.destination)
                Spacer()
                Text(model.trips.selectedTrip.date)
            }
        }
    }
}

struct TripRowView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            TripRowView()
                .environmentObject(ViewModel())
        }
        .modifier(PreviewDevices())
    }
}
