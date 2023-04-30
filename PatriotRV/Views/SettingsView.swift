//
//  SettingsView.swift
//  PatriotRV
//
//  Left side menu
//
//  Created by Ron Lisle on 1/23/23.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var modelData: ViewModel
    
    @State var showCompleted = false
    
    private let enableDangerZone = true

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Actions
                Settings
                if enableDangerZone {
                    DangerZone
                }
                Spacer()
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
        .foregroundColor(.gray)
    }

    var Actions: some View {
        Section(header: Text("Actions")) {
//            MenuRowView(title: "Uncheck All", iconName: "square", action: {
//                modelData.uncheckAll()
//                withAnimation {
//                    presentationMode.wrappedValue.dismiss()
//                }
//            })
            // This may help debugging etc. Save s/b automatic though
            MenuRowView(title: "Save", iconName: "square.and.arrow.down.on.square", action: {
                Task {
                    try await modelData.trips.saveTrips()
                    withAnimation {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            })
        }
        .padding(.top, 8)
    }
    
    var Settings: some View {
        //TODO: move show/hide done to checklist view
        Section(header: Text("Settings")) {
            
            MenuRowView(title: showCompleted ? "Hide Done" : "Show Done", iconName: showCompleted ? "eye.slash" : "eye", action: {
                showCompleted.toggle()
                withAnimation {
                    presentationMode.wrappedValue.dismiss()
                }
            })
        }
        .padding(.top, 8)
    }
    
    var DangerZone: some View {
        Section(header: Text("Danger Zone")) {
            
//            MenuRowView(title: "Eliminate Duplicates", iconName: "rectangle.on.rectangle.slash", action: {
//                modelData.eliminateDuplicates()
//                withAnimation {
//                    presentationMode.wrappedValue.dismiss()
//                }
//            })
//
//            MenuRowView(title: "Delete Checklist", iconName: "exclamationmark.icloud", action: {
//            //TODO: confirm destructive delete action
//                Task {
//                    try await modelData.deleteChecklist()
//                }
//                withAnimation {
//                    presentationMode.wrappedValue.dismiss()
//                }
//            })
//
//            MenuRowView(title: "Seed Checklist", iconName: "square.and.arrow.up.trianglebadge.exclamationmark", action: {
//            //TODO: confirm destructive seed action
//                modelData.seedChecklist()
//                withAnimation {
//                    presentationMode.wrappedValue.dismiss()
//                }
//            })
            
            MenuRowView(title: "Delete Trips", iconName: "exclamationmark.icloud", action: {
                //TODO: confirm destructive delete-all action
                Task {
                    try await modelData.trips.deleteAll()
                }
                withAnimation {
                    presentationMode.wrappedValue.dismiss()
                }
            })
            
            MenuRowView(title: "Seed Trips", iconName: "square.and.arrow.up.trianglebadge.exclamationmark", action: {
                //TODO: confirm destructive seed action
                modelData.trips.seedTripData()
                withAnimation {
                    presentationMode.wrappedValue.dismiss()
                }
            })
        }
        .padding(.top, 8)
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .modifier(PreviewDevices())
    }
}
