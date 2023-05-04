//
//  HomeDestinations.swift
//  PatriotRV
//
//  Created by Ron Lisle on 4/15/23.
//
import SwiftUI

//struct HomeDestinations: ViewModifier {
//
//    var model: ViewModel
//    
//    func body(content: Content) -> some View {
//      content
//      .navigationDestination(for: String.self) { dest in
//          switch dest {
//          case "triplist":
//              let _ = print("triplist")
//              TripListView()
//          case "addtrip":
//              let _ = print("tripview")
//              TripView()
//          case "edittrip":
//              let _ = print("edittrip")
//              TripView(trip: model.trips.next())
//          case "deletetrip":
//              TripDelete(trip: model.trips.next())
////          case "itemlist":
////              ChecklistView()
////          case "additem":
////              AddChecklistView()
////          case "edititem":
////              AddChecklistView(item: model.nextItem())
////          case "deleteitem":
////              ItemDelete(item: model.nextItem())
////          case "power":
////              PowerView()
////          case "log":
////              LogRowView()
//          default:    // Log
//              UnknownDestination()
//          }
//      }
//  }
//}
