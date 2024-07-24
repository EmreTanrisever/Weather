//
//  EndPointProtocol.swift
//  Weather
//
//  Created by Emre Tanrısever on 11.07.2024.
//

import Foundation

protocol EndPointProtocol {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var httpMethod: HttpMethods { get }
    var header: [String: String]? { get }
    var parameters: [String: Any]? { get }
}

extension EndPointProtocol {
    
    func createURLRequest() -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
       
        guard let url = urlComponents.url else { fatalError("End point can not be created.")}
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        
        if let header = header {
            header.forEach { (key: String, value: String) in
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let parameters = parameters {
            switch httpMethod {
                
            case .get:
                urlComponents.queryItems = parameters.map({ (key: String, value: Any) in
                    URLQueryItem(name: key, value: "\(value)")
                })
                urlRequest.url = urlComponents.url
            case .post:
                print("")
            case .patch:
                print("")
            case .update:
                print("")
            case .delete:
                print("")
            }
        }
        
        return urlRequest
    }
}
