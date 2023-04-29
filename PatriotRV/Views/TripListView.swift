//
//  TripListView.swift
//  PatriotRV
//
//  Created by Ron Lisle on 2/1/23.
//

import SwiftUI

struct TripListView: View {
    @EnvironmentObject var model: ViewModel
    @State private var showingAddTrip = false

    var body: some View {
        VStack {
            tripsListView
        }
        .blackNavigation
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showingAddTrip = true
                }) {
                    Image(systemName: "plus")
                }
                .foregroundColor(.white)
            }
        }
        .navigationDestination(isPresented: $showingAddTrip, destination: {
            TripView()
        })
    }
    
    var tripsListView: some View {
        List {
            if(model.trips.count == 0) {
                Text("No trips found")
            } else {
                ForEach(model.trips.trips, id: \.self) { trip in

                  NavigationLink(destination: TripView(trip: trip)) {
                      TripRowView(trip: trip)
                  }
                }
            }
        }
    }
}

struct TripListView_Previews: PreviewProvider {
    static var previews: some View {
        TripListView()
        .environmentObject(ViewModel())
        .modifier(PreviewDevices())
    }
}
