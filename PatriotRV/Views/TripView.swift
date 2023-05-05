//
//  TripView.swift
//  PatriotRV
//
//  Add, Edit, or Display trip
//
//  Created by Ron Lisle on 1/28/23.
//

import SwiftUI
import PhotosUI

struct TripView: View {
    
    @EnvironmentObject var model: ViewModel
    @Environment(\.presentationMode) var presentationMode

    //TODO: switch to model.trips.selectedTrip
    @State private var date: Date = Date()
    @State private var destination: String = ""
    @State private var notes: String = ""
    @State private var address: String = ""
    @State private var website: String = ""
    @State private var photo: UIImage? = nil

    @MainActor @State private var isLoading = false
    @State private var photosPickerItem: PhotosPickerItem?

    init(trip: Trip? = nil) {
        guard let trip = trip else {
            print("TripView: init trip nil")
            return
        }
        print("TripView init: \(trip.date) \(trip.destination) \(trip.address ?? "No address") \(String(describing: trip.notes)) \(String(describing: trip.website ?? "No website"))")
        _date = .init(initialValue: Date(trip.date))
        _destination = .init(initialValue: trip.destination)
        _notes = .init(initialValue: trip.notes ?? "")
        _address = .init(initialValue: trip.address ?? "")
        _website = .init(initialValue: trip.website ?? "")
        _photo = .init(initialValue: trip.photo)
    }
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Spacer()
                    PhotoView(image: photo)
                    Spacer()
                }
                .overlay(alignment: .topTrailing) {
                    PhotosPicker(selection: $photosPickerItem,
                                 matching: .images) {
                        Image(systemName: "pencil.circle.fill")
                            .symbolRenderingMode(.multicolor)
                            .font(.system(size: 30))
                            .foregroundColor(.accentColor)
                    }
                }
            }
            Section {
                DatePicker("Date of trip:", selection: $date, in: Date.now..., displayedComponents: .date)
                TextField("Destination", text: $destination)
                TextField("Address", text: $address)
                TextField("Website", text: $website)
            }
            Section {
                TextField("Notes", text: $notes)
            }
            Section {
                //TODO: display only if something has changed
                Button("Save") {
                    let newTrip = Trip(
                        identifier: date.yyyymmddKey(),
                        date: date.yyyymmddKey(),
                        destination: destination,
                        notes: notes,
                        address: address,
                        website: website,
                        photo: photo)
                    Task {
                        do {
                            try await model.trips.add(newTrip)
                        } catch {
                            print("Error adding trip")
                        }
                    }
                    withAnimation {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .onChange(of: photosPickerItem) { selectedPhotosPickerItem in
              guard let selectedPhotosPickerItem else { return }
              Task {
                  print("Photo selected")
                isLoading = true
                await updatePhotosPickerItem(with: selectedPhotosPickerItem)
                isLoading = false
              }
            }
        }
    }
    
    private func updatePhotosPickerItem(with item: PhotosPickerItem) async {
        photosPickerItem = item
        if let data = try? await item.loadTransferable(type: Data.self) {
            photo = UIImage(data: data)
        }
    }
}

struct TripView_Previews: PreviewProvider {
    static var previews: some View {
        TripView(trip: TripsModel.loadingTrip)
            .modifier(PreviewDevices())
    }
}
