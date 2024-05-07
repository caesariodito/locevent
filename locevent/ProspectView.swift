//
//  HomeView.swift
//  locevent
//
//  Created by MacBook Air on 07/05/24.
//

import SwiftUI

struct ProspectView: View {
    let dummies = ["Fak", "Yea", "iloveyou", "Ted"]
    
    @State private var searchText = ""
    @State private var searchIsActive = false
    
    enum FilterType {
        case home, wishlist
    }
    
    let filter: FilterType
    
    var title: String {
        switch filter {
            case .home:
                "Find events near you!"
            case .wishlist:
                "Your lovely future events <3"
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults, id: \.self) { dummy in
                    NavigationLink {
                        Text(dummy)
                    } label: {
                        Text(dummy)
                    }
                }
            }
            .navigationTitle("\(searchIsActive ? "Results" : title)")
            .navigationBarTitleDisplayMode(.inline)
        }
        .searchable(text: $searchText, isPresented: $searchIsActive, prompt: "find events!")
    }
    
    var searchResults: [String] {
        if searchText.isEmpty {
            return dummies
        } else {
            return dummies.filter { $0.contains(searchText) }
        }
    }
}

#Preview {
    ProspectView(filter: .home)
}
