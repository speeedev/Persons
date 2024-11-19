//
//  PersonsResponseModel.swift
//  Persons
//
//  Created by Emir Bolat on 18.11.2024.
//

import Foundation

struct ResponseModel: Codable {
    let success: Bool
    let data: [PersonModel]
}
