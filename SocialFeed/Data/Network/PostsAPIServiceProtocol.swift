//
//  PostsAPIServiceProtocol.swift
//  SocialFeed
//
//  Created by Alena Ivanova on 26.11.2025.
//


protocol PostsAPIServiceProtocol {
    func fetchPosts() async throws -> [PostDTO]
}
