//
//  NetworkManager.swift
//  Weather
//
//  Created by Emre Tanrısever on 11.07.2024.
//

import Foundation

protocol NetworkManagerProtocol {
    func execute<T: Decodable>(urlRequest: EndPointProtocol, completion: @escaping(Result<T, NetworkErrors>) -> Void)
}

public class NetworkManager {
    
    private init() {  }
    static let shared = NetworkManager()
    
    private let urlSession = URLSession.shared
    private let jsonDecoder = JSONDecoder()
}

extension NetworkManager: NetworkManagerProtocol {
    
    func execute<T>(
        urlRequest: EndPointProtocol,
        completion: @escaping (Result<T, NetworkErrors>) -> Void
    ) where T : Decodable {
        urlSession.dataTask(with: urlRequest.createURLRequest()) { data, response, error in
            if error != nil {
                completion(.failure(.badRequest))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            guard let decodedData = self.convertData(type: T.self, data: data) else {
                completion(.failure(.decodeError))
                return
            }
            completion(.success(decodedData))
        }.resume()
    }
    
    private func convertData<T: Decodable>(type: T.Type, data: Data) -> T? {
        do {
            return try jsonDecoder.decode(type.self, from: data)
        } catch {
            return nil
        }
    }
}
