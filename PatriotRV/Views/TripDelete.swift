//
//  TripDelete.swift
//  PatriotRV
//
//  Created by Ron Lisle on 4/16/23.
//

import SwiftUI

struct TripDelete: View {
    
    var trip: Trip?
    
    var body: some View {
        Text("TODO: Delete trip: \(trip?.destination ?? "None")")
    }
}

struct TripDelete_Previews: PreviewProvider {
    static var model = ViewModel()
    static var previews: some View {
        if model.trips.count > 0 {
            TripDelete(trip: model.trips.trips.last!)
                .environmentObject(model)
        } else {
            Text("Can't preview: no trips")
        }
    }
}
