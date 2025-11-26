//
//  PostsService.swift
//  SocialFeed
//
//  Created by Alena Ivanova on 26.11.2025.
//


final class PostsService: PostsServiceProtocol {
    
    private let apiService: PostsAPIServiceProtocol
    private let localRepository: PostsRepositoryProtocol
    
    init(apiService: PostsAPIServiceProtocol,
         localRepository: PostsRepositoryProtocol) {
        self.apiService = apiService
        self.localRepository = localRepository
    }
    
    func fetchAndCachePosts() async throws -> [PostModel] {
        let dtos = try await apiService.fetchPosts()
        
        let models = dtos.map { dto in PostMapper.toDomain(dto) }
        try await localRepository.save(models)
        return models
    }
    
    func loadCachedPosts() async throws -> [PostModel] {
        try await localRepository.getAll()
    }
}
