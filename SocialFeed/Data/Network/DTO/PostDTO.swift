//
//  PostDTO.swift
//  SocialFeed
//
//  Created by Alena Ivanova on 26.11.2025.
//

import Foundation

struct PostDTO: Codable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
