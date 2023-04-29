//
//  TripSection.swift
//  PatriotRV
//
//  Created by Ron Lisle on 4/15/23.
//

import SwiftUI

struct TripSection: View {
    
    @EnvironmentObject var model: ViewModel
    @Binding var selection: [String]
    

    var body: some View {
        Section {
            NavigationLink(value: "edittrip") {
                TripRowView(trip: model.trips.next())
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            //TODO: .confirmationDialog and action
                            print("TODO: delete")
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
            }
        } header: {
            HStack {
                Text("Next Trip")
                Spacer()
                Button("+") {
                    selection.append("addtrip")
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                selection.append("triplist")
            }
        }
    }
}

struct TripSection_Previews: PreviewProvider {
    static var selection = [""]
    static var previews: some View {
        List {
            TripSection(selection: .constant(selection))
                .environmentObject(ViewModel())
        }
        .previewLayout(.fixed(width: 640, height: 60))
    }
}
