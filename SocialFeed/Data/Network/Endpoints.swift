//
//  Endpoints.swift
//  SocialFeed
//
//  Created by Alena Ivanova on 26.11.2025.
//

import Foundation
import Alamofire

enum PostsEndpoint: URLRequestConvertible {
    case getPosts
    
    var method: HTTPMethod {
        switch self {
        case .getPosts: return .get
        }
    }
    
    var path: String {
        switch self {
        case .getPosts: return "/posts"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let baseURL = URL(string: "https://jsonplaceholder.typicode.com")!
        let url = baseURL.appendingPathComponent(path)
        
        var request = URLRequest(url: url)
        request.method = method
        return request
    }
}

