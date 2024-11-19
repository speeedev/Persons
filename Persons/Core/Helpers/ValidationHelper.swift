//
//  URLHelper.swift
//  Persons
//
//  Created by Emir Bolat on 19.11.2024.
//

import Foundation
import UIKit

struct ValidationHelper {
    /// Opens the email app. If it cannot be opened, an error is thrown.
    static func openEmail(_ email: String) throws {
        let emailURL = "mailto:\(email)"
        try openURL(urlString: emailURL, errorType: .invalidEmailURL)
    }
    
    /// Opens the phone number in the contact app. If it cannot be opened, an error is thrown.
    static func openPhone(_ phone: String) throws {
        let cleanPhone = phone.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let phoneURL = "tel:\(cleanPhone)"
        try openURL(urlString: phoneURL, errorType: .invalidPhoneURL)
    }
    
    /// Opens the website address in the browser. If it cannot be opened, an error is thrown.
    static func openWebsite(_ website: String) throws {
        var websiteURL = website
        if !website.lowercased().hasPrefix("http") {
            websiteURL = "https://\(website)"
        }
        try openURL(urlString: websiteURL, errorType: .invalidWebsiteURL)
    }
    
    // MARK: - Private Helpers
    private static func openURL(urlString: String, errorType: ValidationError) throws {
        guard let url = URL(string: urlString) else {
            throw errorType
        }
        
        guard UIApplication.shared.canOpenURL(url) else {
            throw ValidationError.cannotOpenURL
        }
        
        UIApplication.shared.open(url)
    }
}
