//
//  AddressModel.swift
//  Persons
//
//  Created by Emir Bolat on 19.11.2024.
//

import Foundation

struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
}
