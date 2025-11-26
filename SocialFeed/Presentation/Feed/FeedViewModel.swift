//
//  FeedViewModel.swift
//  SocialFeed
//
//  Created by Alena Ivanova on 26.11.2025.
//

import UIKit
import Combine

@MainActor
final class FeedViewModel {

    private let postsService: PostsServiceProtocol
    
    @Published private(set) var posts: [PostModel] = []
    @Published private(set) var isLoading = false
    @Published var errorMessage: String?

    init(postsService: PostsServiceProtocol) {
        self.postsService = postsService
    }
    
    func loadCached() {
        Task {
            do {
                posts = try await postsService.loadCachedPosts()
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func refresh() {
        Task {
            isLoading = true
            do {
                posts = try await postsService.fetchAndCachePosts()
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
}
