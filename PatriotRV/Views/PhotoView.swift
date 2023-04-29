//
//  PhotoView.swift
//  PatriotRV
//
//  Created by Ron Lisle on 4/14/23.
//

import SwiftUI
import PhotosUI

struct PhotoView: View {
    var image: UIImage?
    
    var body: some View {
        if let image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                //.cornerRadius(10)
                //.foregroundColor(.accentColor)
        } else {
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                //.cornerRadius(10)
                //.foregroundColor(.accentColor)
        }
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PhotoView()
        }
    }
}
