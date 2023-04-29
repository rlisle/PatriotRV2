//
//  MenuRowView.swift
//  RvChecklist
//
//  Created by Ron Lisle on 7/20/21.
//

import SwiftUI

struct MenuRowView: View {
    
    @State var title: String
    @State var iconName: String
    @State var action: () -> Void
    
    var body: some View {
        
        Button(action: {
            action()
        }) {
            HStack {
                Image(systemName: iconName)
                    .imageScale(.large)
                Text(title)
                    .font(.headline)
            }
//            .background(Color(red: 32/255, green: 32/255, blue: 32/255))
//            .foregroundColor(Color(red: 192/255, green: 192/255, blue: 192/255))
            .padding(.leading, 8)
        }
    }
}

struct MenuRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            MenuRowView(title: "Menu Item", iconName: "person", action: {
                print("Action tapped")
            })
        }
        .modifier(PreviewDevices())
    }
}
