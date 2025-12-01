//
//  PostsRepository.swift
//  SocialFeed
//
//  Created by Alena Ivanova on 26.11.2025.
//

import CoreData

final class PostsRepository: PostsRepositoryProtocol {

    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func getAll() async throws -> [PostModel] {
        return try await context.perform {
            let request: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
            let entities = try self.context.fetch(request)
            return entities.map { PostMapper.toDomain($0) }
        }
    }
    
    func save(_ models: [PostModel]) async throws {
        let context = self.context
        try await context.perform {
            for model in models {
                let _ = PostMapper.toEntity(model, context: context)
            }
            try context.save()
        }
    }
    
    func deleteAll() async throws {
        return try await context.perform {
            let fetchReq: NSFetchRequest<NSFetchRequestResult> = PostEntity.fetchRequest()
            let deleteReq = NSBatchDeleteRequest(fetchRequest: fetchReq)
            try self.context.execute(deleteReq)
            try self.context.save()
        }
    }
    
    private func saveModel(_ model: PostModel) async throws {
        let context = self.context
        return try await context.perform {
            let _ = PostMapper.toEntity(model, context: context)
            try context.save()
        }
    }
}
