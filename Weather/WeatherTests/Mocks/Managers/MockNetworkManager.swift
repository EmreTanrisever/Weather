//
//  MockNetworkManager.swift
//  WeatherTests
//
//  Created by Emre Tanrısever on 16.07.2024.
//

import Foundation
@testable import Weather

final class MockNetworkManager: NetworkManagerProtocol {
    
    func execute<T>(urlRequest: any EndPointProtocol, completion: @escaping (Result<T, NetworkErrors>) -> Void) where T : Decodable {
        let bundle = Bundle(for: MockNetworkManager.self)
        let url = bundle.url(forResource: "WeatherForecast", withExtension: "json")!
        do {
            let data = try Data(contentsOf: url)
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            completion(.success(decodedData))
        } catch {
            completion(.failure(.decodeError))
        }
    }
}
