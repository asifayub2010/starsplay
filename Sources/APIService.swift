//
//  APIService.swift
//  NetworkFramework
//
//  Created by Asif Ayub on 17/02/2025.
//


import Foundation
import Alamofire
import SwiftyJSON

open class APIService {
    private let apiKey: String
    private let baseURL: String

    open init(apiKey: String, baseURL: String) {
        self.apiKey = apiKey
        self.baseURL = baseURL
    }

    open func fetchTVShowDetails(showId: Int) async throws -> JSON {
        let url = "\(baseURL)/tv/\(showId)?api_key=\(apiKey)"
        return try await performRequest(url: url)
    }

    open func fetchTVShowsList() async throws -> JSON {
        let url = "\(baseURL)/tv/popular?api_key=\(apiKey)"
        return try await performRequest(url: url)
    }

    open func fetchSeasonDetails(showId: Int, seasonNumber: Int) async throws -> JSON {
        let url = "\(baseURL)/tv/\(showId)/season/\(seasonNumber)?api_key=\(apiKey)"
        let seasonDetail = try await performRequest(url: url)
        return seasonDetail
    }

    private func performRequest(url: String) async throws -> JSON {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url).responseData { response in
                switch response.result {
                case .success(let data):
                    let decodedData = JSON(data)
                    continuation.resume(returning: decodedData)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
