//
//  NetworkError.swift
//  NetworkFramework
//
//  Created by Asif Ayub on 17/02/2025.
//


import Foundation

public enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case unknownError
}
