//
//  PersonServiceProtocol.swift
//  Persons
//
//  Created by Emir Bolat on 19.11.2024.
//

import Foundation

protocol PersonServiceProtocol {
    func fetchPersons(completion: @escaping (Result<ResponseModel, Error>) -> Void)
}
