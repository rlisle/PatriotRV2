//
//  ImageHeader.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/22/21.
//

import SwiftUI

struct ImageHeader: View {
    
    var imageName: String
    
    var body: some View {
        ZStack(alignment: .topLeading, content: {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
        })
    }
}

struct ImageHeader_Previews: PreviewProvider {
    static var previews: some View {
        ImageHeader(imageName: "truck-rv")
            .previewLayout(.fixed(width: 300, height: 210))
            .modifier(PreviewDevices())
    }
}
