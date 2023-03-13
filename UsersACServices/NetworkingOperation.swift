//
//  NetworkingOperation.swift
//  UsersACServices
//
//  Created by Amanda Rosa on 2023-03-09.
//

import Foundation

public class NetworkingOperation {
    
    public static let shared = NetworkingOperation()
    
    public enum APIError: Error {
        case invalidUrl
        case invalidData
    }
    
    public func request<T: Codable> (
        url: URL?,
        expecting: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = url else {
            completion(.failure(APIError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(APIError.invalidData))
                }
                return
            }
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
