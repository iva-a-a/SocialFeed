//
//  APIClientProtocol.swift
//  SocialFeed
//
//  Created by Alena Ivanova on 26.11.2025.
//

import Alamofire

protocol APIClientProtocol {
    func request<T: Decodable>(_ endpoint: URLRequestConvertible) async throws -> T
}
