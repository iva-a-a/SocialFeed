//
//  PostsAPIService.swift
//  SocialFeed
//
//  Created by Alena Ivanova on 26.11.2025.
//


final class PostsAPIService: PostsAPIServiceProtocol {
    
    private let client: APIClientProtocol
    
    init(client: APIClientProtocol) {
        self.client = client
    }

    func fetchPosts() async throws -> [PostDTO] {
        try await client.request(PostsEndpoint.getPosts)
    }
}
