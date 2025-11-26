//
//  DIContainer.swift
//  SocialFeed
//
//  Created by Alena Ivanova on 26.11.2025.
//

import CoreData
import UIKit

final class DIContainer {
    static let shared = DIContainer()
    private init() {}
    
    /// CoreData
    private lazy var coreDataManager: CoreDataManager = CoreDataManager()
    lazy var context = coreDataManager.context
    
    /// Network
    lazy var apiClient: APIClientProtocol = APIClient()
    lazy var postsAPIService: PostsAPIServiceProtocol =
        PostsAPIService(client: apiClient)
    
    /// Repositories
    lazy var postsRepository: PostsRepositoryProtocol =
        PostsRepository(context: context)
    
    /// Services
    lazy var postsService: PostsServiceProtocol =
        PostsService(
            apiService: postsAPIService,
            localRepository: postsRepository
        )
    
    /// ViewModels
    func makeFeedViewModel() -> FeedViewModel {
        return FeedViewModel(postsService: postsService)
    }
    
    /// ViewControllers
    func makeFeedViewController() -> UIViewController {
        return FeedViewController(viewModel: makeFeedViewModel())
    }
}
