//
//  UnknownDestination.swift
//  PatriotRV
//
//  Created by Ron Lisle on 4/16/23.
//

import SwiftUI

struct UnknownDestination: View {
    var body: some View {
        Text("Error: Unknown Destination")
    }
}

struct UnknownDestination_Previews: PreviewProvider {
    static var previews: some View {
        UnknownDestination()
            .modifier(PreviewDevices())
    }
}
