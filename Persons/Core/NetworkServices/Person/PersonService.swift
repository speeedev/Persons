//
//  NetworkService.swift
//  Persons
//
//  Created by Emir Bolat on 18.11.2024.
//

import Alamofire
import Foundation

/// Network operations related to persons. Using Alamofire package for API connection.
class PersonService: PersonServiceProtocol {
    private let baseURL = NetworkConstants.baseURL

    /// Fetches Persons and translates them into PersonModel`.
    func fetchPersons(completion: @escaping (Result<ResponseModel, Error>) -> Void) {
        AF.request(NetworkConstants.APIEndpoints.users, method: .get)
            .validate()
            .responseDecodable(of: [PersonModel].self) { response in
                switch response.result {
                case .success(let personModels):
                    let responseModel = ResponseModel(success: true, data: personModels)
                    print(response)
                    completion(.success(responseModel))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
