//
//  PostsRepositoryProtocol.swift
//  SocialFeed
//
//  Created by Alena Ivanova on 26.11.2025.
//


import Foundation

protocol PostsRepositoryProtocol {
    func getAll() async throws -> [PostModel]
    func save(_ models: [PostModel]) async throws
    func deleteAll() async throws
}
