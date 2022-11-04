//
//  NetworkManager.swift
//  Star Wars with UIKit
//
//  Created by Denis Bokov on 31.10.2022.
//

import Foundation

enum NetworkError: Error {
    case noData
    case decodingError
    case invalidURL
}


class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetch<T: Decodable>(_ type: T.Type, from url: String?, complition: @escaping(Result<T, NetworkError>) -> Void) {
        
        guard let stringURL = url, let url = URL(string: stringURL) else {
            complition(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                complition(.failure(.noData))
                return
            }
            
            do {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let type = try decoder.decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    complition(.success(type))
                }
                
            } catch {
                complition(.failure(.decodingError))
            }
        }.resume()
    }
}
