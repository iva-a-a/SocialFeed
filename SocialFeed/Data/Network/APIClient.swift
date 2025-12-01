//
//  APIClient.swift
//  SocialFeed
//
//  Created by Alena Ivanova on 26.11.2025.
//

import Alamofire

final class APIClient: APIClientProtocol {

    func request<T: Decodable>(
        _ endpoint: URLRequestConvertible
    ) async throws -> T {

        return try await withCheckedThrowingContinuation { continuation in
            AF.request(endpoint)
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let dto):
                        continuation.resume(returning: dto)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}


