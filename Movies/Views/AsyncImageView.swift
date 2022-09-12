//
//  AsyncImageView.swift
//  Movies
//
//  Created by Adarsh A on 12/09/22.
//

import SwiftUI

struct AsyncImageView: View {
    var url: String
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            if let image = phase.image {
                image
            } else if phase.error != nil {
                Color.red
            } else {
                Image(systemName: "photo.fill.on.rectangle.fill")
            }
        }
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView(url:"https://example.com/icon.png")
    }
}
