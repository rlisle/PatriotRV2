//
//  LoginView.swift
//  PatriotRV
//
//  Created by Ron Lisle on 4/2/23.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        Text("Not logged into iCloud")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
        .modifier(PreviewDevices())
    }
}
