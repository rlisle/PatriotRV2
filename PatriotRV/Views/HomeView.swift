//
//  HomeView.swift
//  PatriotRV
//
//  Created by Ron Lisle on 1/22/23.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject var model: ViewModel
    
    @State private var showSettings = false
    @State private var showLogin = false

    enum Screen {
        case settings
        case power
        case checklists
        case trips
    }
    @State private var selection: [String] = []
    
    var body: some View {
        NavigationStack(path: $selection) {
            VStack {
                ImageHeader(imageName: "truck-rv")
                List {
                    TripSection(selection: $selection)
//                    ChecklistSection(selection: $selection)
//                    PowerSection()
//                    LogSection()
                }
                .listStyle(.grouped)
                .padding(.top, -8)
            }
            .modifier(HomeDestinations(model: model))
            .navigationTitle("Patriot RV")
            .blackNavigation
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        withAnimation {
                            self.showSettings.toggle()
                        }
                    }) {
                        Image(systemName: "gearshape")
                            .imageScale(.large)
                    }
                    .foregroundColor(.white)
                }
            }
            .navigationDestination(isPresented: $showSettings,
                                   destination: {
                SettingsView()
            })
        }
        .sheet(isPresented: $showLogin) {
            LoginView()
        }
        .onOpenURL(perform: { (url) in
            switch url {
            case URL(string: "patriot:///trip"):
                selection.append("trip")
            case URL(string: "patriot:///list"):
                selection.append("list")
            case URL(string: "patriot:///nextitem"):
                selection.append("list")
            case URL(string: "patriot:///power"):
                selection.append("power")
            default:
                print("unknown link url: \(url)")
            }
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ViewModel())
            .modifier(PreviewDevices())
    }
}
