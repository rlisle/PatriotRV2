//
//  PreviewDevices.swift
//  PatriotRV
//
//  Simplify creating Previews
//
//  Created by Ron Lisle on 4/7/23.
//

/* Preview Snippet
  struct <ViewName>_Previews: PreviewProvider {
     static var previews: some View {
         <ViewName>(<arg>: <value>)
             // Note that .environmentObject not needed, included in PreviewDevices
             .modifier(PreviewDevices())
     }
 }
 */

import SwiftUI

struct PreviewDevices: ViewModifier {
    func body(content: Content) -> some View {
        ForEach(["iPhone 14 Pro", "iPad (10th generation)"], id: \.self) { deviceName in
            content
            .environmentObject(ViewModel())
            .previewDevice(PreviewDevice(rawValue: deviceName))
            .previewDisplayName(deviceName)
        }
    }
}
