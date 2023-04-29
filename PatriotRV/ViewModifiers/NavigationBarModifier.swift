//
//  NavigationBarModifier.swift
//  RvChecklist
//
//  Created by Ron Lisle on 7/25/21.
//
// TODO: This is a hack, and doesn't really work correctly anyways.

import SwiftUI

struct NavigationBarModifier: ViewModifier {
  var backgroundColor: UIColor
  var textColor: UIColor

  init(backgroundColor: UIColor, textColor: UIColor) {
    self.backgroundColor = backgroundColor
    self.textColor = textColor  //TODO: this doesn't appear to work. Have to use .foregroundColor on items
    let coloredAppearance = UINavigationBarAppearance()
    coloredAppearance.configureWithTransparentBackground()
//    coloredAppearance.configureWithOpaqueBackground()
    coloredAppearance.backgroundColor = .clear
//    coloredAppearance.backgroundColor = backgroundColor
    coloredAppearance.titleTextAttributes = [.foregroundColor: textColor]
    coloredAppearance.largeTitleTextAttributes = [.foregroundColor: textColor]

    UINavigationBar.appearance().standardAppearance = coloredAppearance
    UINavigationBar.appearance().compactAppearance = coloredAppearance
    UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    UINavigationBar.appearance().tintColor = textColor
  }

  func body(content: Content) -> some View {
    ZStack{
       content
        VStack {
          GeometryReader { geometry in
             Color(self.backgroundColor)
                .frame(height: geometry.safeAreaInsets.top)
                .edgesIgnoringSafeArea(.top)
              Spacer()
          }
        }
     }
  }
}

extension View {
  func navigationBarColor(_ backgroundColor: UIColor, textColor: UIColor) -> some View {
    self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, textColor: textColor))
  }
}

extension View {
  var blackNavigation: some View {
    self.navigationBarColor(UIColor.black, textColor: UIColor.white)
  }
}
