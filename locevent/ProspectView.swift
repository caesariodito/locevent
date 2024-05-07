//
//  HomeView.swift
//  locevent
//
//  Created by MacBook Air on 07/05/24.
//

import SwiftUI

struct Message: Identifiable, Codable {
    let id: Int
    var user: String
    var text: String
}

enum SearchScope: String, CaseIterable {
    case inbox, favorites
}

struct ProspectView: View {
    @State private var messages = [Message]()
    
    @State private var searchText = ""
    @State private var searchScope = SearchScope.inbox
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
                ForEach(filteredMessages) { message in
                    VStack(alignment: .leading) {
                        Text(message.user)
                            .font(.headline)
                        Text(message.text)
                    }
                }
            }
            .navigationTitle("\(searchIsActive ? "Results" : title)")
            .navigationBarTitleDisplayMode(.inline)
        }
        .searchable(text: $searchText, isPresented: $searchIsActive, prompt: "find events!")
        .searchScopes($searchScope) {
            ForEach(SearchScope.allCases, id: \.self) { scope in
                Text(scope.rawValue.capitalized)
            }
        }
        .onAppear(perform: runSearch)
        .onSubmit(of: .search, runSearch)
        .onChange(of: searchScope) { runSearch() }
    }
    
    var filteredMessages: [Message] {
        if searchText.isEmpty {
            return messages
        } else {
            return messages.filter { $0.text.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func runSearch() {
        Task {
            guard let url = URL(string: "https://hws.dev/\(searchScope.rawValue).json") else { return }
            
            let (data, _) = try await URLSession.shared.data(from: url)
            messages = try JSONDecoder().decode([Message].self, from: data)
        }
    }
}

#Preview {
    ProspectView(filter: .home)
}
