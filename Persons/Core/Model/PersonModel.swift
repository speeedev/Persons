//
//  PersonModel.swift
//  Persons
//
//  Created by Emir Bolat on 18.11.2024.
//

import Foundation

struct PersonModel: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
}
