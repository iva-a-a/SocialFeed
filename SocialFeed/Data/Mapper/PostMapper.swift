//
//  PostMapper.swift
//  SocialFeed
//
//  Created by Alena Ivanova on 26.11.2025.
//

import CoreData


struct PostMapper {
    static func toDomain(_ entity: PostEntity) -> PostModel {
        return PostModel(
            id: entity.id,
            title: entity.title ?? "",
            body: entity.body ?? "",
            avatarURL: URL(string: entity.avatarURL ?? "")
        )
    }
    
    static func toEntity(_ domain: PostModel, context: NSManagedObjectContext) -> PostEntity {
        let entity = PostEntity(context: context)
        entity.id = domain.id
        entity.title = domain.title
        entity.body = domain.body
        entity.avatarURL = domain.avatarURL?.absoluteString ?? ""
        return entity
    }
    
    static func toDomain(_ dto: PostDTO) -> PostModel {
        let url = URL(string: "https://picsum.photos/seed/post\(dto.id)/200/200")
        return PostModel(
            id: Int64(dto.id),
            title: dto.title,
            body: dto.body,
            avatarURL: url
        )
        
    }
}
