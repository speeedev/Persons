//
//  HomeViewModel.swift
//  Persons
//
//  Created by Emir Bolat on 18.11.2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var isLoading: Bool = true
    @Published var isError: Bool = false
    @Published var persons: [PersonModel] = []

    let personService = PersonService()

    func fetchPersons() {
        isLoading = true
        isError = false

        personService.fetchPersons { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let responseModel):
                    self.persons = responseModel.data
                    self.isLoading = false
                case .failure:
                    self.isLoading = false
                    self.isError = true
                }
            }
        }
    }
}
