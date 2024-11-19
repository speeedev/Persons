//
//  HomeView.swift
//  Persons
//
//  Created by Emir Bolat on 18.11.2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            contentView
                .navigationTitle("personsTitle")
                .searchable(text: $searchText, prompt: Text("Search"))
                .onAppear(perform: loadDataIfNeeded)
        }
    }

    // MARK: - Content Views
    private var contentView: some View {
        Group {
            if viewModel.isLoading {
                loadingView
            } else if viewModel.isError {
                errorView
            } else if filteredPersons.isEmpty {
                emptyView
            } else {
                personListView
            }
        }
    }

    // MARK: - Filtered Persons
    private var filteredPersons: [PersonModel] {
        if searchText.isEmpty {
            return viewModel.persons
        } else {
            return viewModel.persons.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    // MARK: - Loading View
    private var loadingView: some View {
        ProgressView(LocalizedStringKey("loading"))
            .progressViewStyle(CircularProgressViewStyle())
    }

    // MARK: - Error View
    private var errorView: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 50))
                .foregroundColor(.red)
            
            Text("anErrorOccurred")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("checkInternetConnectionText")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button(action: {
                viewModel.persons.removeAll()
                viewModel.fetchPersons()
            }) {
                HStack {
                    Image(systemName: "arrow.clockwise")
                    Text("tryAgainText")
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }
        .padding()
    }

    // MARK: - Empty View
    private var emptyView: some View {
        Text("noPersonsFoundText")
            .padding()
    }

    // MARK: - Persons List Component
    private var personListView: some View {
        List(filteredPersons, id: \.id) { person in
            PersonRowView(person: person)
                .listRowSeparator(.hidden)
                .listRowInsets(
                    EdgeInsets(top: 0, leading: 16, bottom: 10, trailing: 16))
        }
        .listStyle(.plain)
    }

    // MARK: - Supporting Views
    private struct PersonRowView: View {
        let person: PersonModel

        var body: some View {
            ZStack {
                PersonCardView(person: person)
                NavigationLink(
                    destination: PersonDetailView(person: person)
                ) {
                    EmptyView()
                }
                .opacity(0)
                .accentColor(Color.black)
            }
        }
    }

    // MARK: - Helper Methods
    private func loadDataIfNeeded() {
        if viewModel.persons.isEmpty {
            viewModel.fetchPersons()
        }
    }
}
