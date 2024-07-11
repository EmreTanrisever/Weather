//
//  NetworkErrors.swift
//  Weather
//
//  Created by Emre Tanrısever on 11.07.2024.
//

import Foundation

enum NetworkErrors: Error {
    case badRequest
    case noData
    case decodeError
}
