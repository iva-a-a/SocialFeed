//
//  PostsServiceProtocol.swift
//  SocialFeed
//
//  Created by Alena Ivanova on 26.11.2025.
//


protocol PostsServiceProtocol {
    func fetchAndCachePosts() async throws -> [PostModel]
    func loadCachedPosts() async throws -> [PostModel]
}
