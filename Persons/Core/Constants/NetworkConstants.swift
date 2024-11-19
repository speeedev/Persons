//
//  NetworkConstants.swift
//  Persons
//
//  Created by Emir Bolat on 18.11.2024.
//

import Foundation

struct NetworkConstants {
    static let baseURL = "https://jsonplaceholder.typicode.com"
    
    struct APIEndpoints {
        static let users = "\(NetworkConstants.baseURL)/users"
    }
}
