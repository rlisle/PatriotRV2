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
            listOfTripsView
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
    
    // This is a somewhat different way of refactoring views
    // Using a var instead of a totally separate struct and/or file
    var listOfTripsView: some View {
        List {
            if(model.trips.count == 0) {
                Text("No trips found")
            } else {
                ForEach(model.trips.trips, id: \.self) { trip in

                  NavigationLink(destination: TripView(trip: trip)) {
                      TripRowView()
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
