//
//  CanvasView.swift
//  Canvas
//
//  Created by Alex Nagy on 26.11.2021.
//

import SwiftUI

struct CanvasView: View {
    
    var body: some View {
        TabView {
            Text("Hello")
                .tabItem {
                    Image(systemName: "house")
                }
            
            NavigationView {
                ProjectsView()
                    .navigationBarTitleDisplayMode(.inline)
            }
            .navigationViewStyle(.stack)
            .tabItem {
                Image(systemName: "doc")
            }
        }
        
    }
}

struct CanvasView_Previews: PreviewProvider {
    static var previews: some View {
        CanvasView()
    }
}
