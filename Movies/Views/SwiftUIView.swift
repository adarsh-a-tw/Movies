//
//  SwiftUIView.swift
//  Movies
//
//  Created by Adarsh A on 12/09/22.
//

import SwiftUI

struct SwiftUIView: View {

        var body: some View {
            NavigationView {
                NavigationLink(destination: Text("Second View")) {
                    Image(systemName: "star.fill").foregroundColor(.red)
                }
                .navigationTitle("Navigation")
            }
        }
    
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
