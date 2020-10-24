//
//  NetworkManager.swift
//  CodeChallenge
//
//  Created by Mounika Jakkampudi on 10/9/20.
//  Copyright © 2020 MVVM. All rights reserved.
//

import Foundation
import Reachability

// Custom enum to handle HTTPErrors
public enum HTTPError: Error {
     case invalidURL
     case invalidResponse
     case networkError
 }

// Localized Error Description for custom enum
extension HTTPError: LocalizedError {
     public var errorDescription: String? {
         switch self {
         case .invalidURL:
             return NSLocalizedString("Invalid URL", comment: "invalidURL")
         case .invalidResponse:
             return NSLocalizedString("Invalid Response", comment: "invalidResponse")
         case .networkError:
             return NSLocalizedString("Network Error", comment: "networkError")
         }
     }
 }

class NetworkManager {
    static let shared: NetworkManager = NetworkManager()
        // GET request to URLSession
    public func get(urlString: String, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        // Check Reachability to check network connection before making API calls.
        var reachability: Reachability?
        do {
         reachability = try Reachability()
        } catch {
        }
        guard reachability?.connection != .unavailable else {
            completionBlock(.failure(HTTPError.networkError))
            return
        }
        // check if URL is valid
        guard let url = URL(string: urlString) else {
            completionBlock(.failure(HTTPError.invalidURL))
            return
        }
        // Define URLSession dataTask and resume
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completionBlock(.failure(error!))
                return
            }
            guard
                let responseData = data,
                let httpResponse = response as? HTTPURLResponse,
                200 ..< 300 ~= httpResponse.statusCode else {
                    completionBlock(.failure(HTTPError.invalidResponse))
                    return
            }
            completionBlock(.success(responseData))
        }
        task.resume()
    }
}
