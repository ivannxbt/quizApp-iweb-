//
//  MyAsyncImage.swift
//  prac4
//
//  Created by b016 DIT UPM on 21/11/22.
//

import SwiftUI

struct MyAsyncImage: View {
    var url: URL?
    var body: some View {
        AsyncImage(url: url) { phase in
            if url == nil {
                Color.white
            } else if let image = phase.image {
                image.resizable()
            } else if phase.error != nil {
                Color.red
            } else {
                ProgressView()
            }
        }
    }
    
}

struct MyAsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        MyAsyncImage()
    }
}
