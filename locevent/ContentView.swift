//
//  ContentView.swift
//  locevent
//
//  Created by MacBook Air on 07/05/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = "Something"
    
    var body: some View {
            TabView(selection: $selectedTab) {
                ProspectView(filter: .home)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                
                ProspectView(filter: .wishlist)
                    .tabItem {
                        Label("Wishlist", systemImage: "heart")
                    }
                
                ProfileView()
                    .tabItem {
                        Label("Home", systemImage: "person.crop.circle")
                    }
            }
        
        
    }
}

#Preview {
    ContentView()
}
