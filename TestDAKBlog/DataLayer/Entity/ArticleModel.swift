//
//  articleModel.swift
//  TestDAKBlog
//
//  Created by Tio Hardadi Somantri on 11/3/23.
//

import Foundation

// MARK: - Article
struct ArticleResponse: Codable {
    let success: Bool
    let message: String
    let data: [DataArticle]?
}

struct AddArticleResponse: Codable {
    let success: Bool
    let message: String
    let data: DataArticle
}

// MARK: - DataClass
struct DataArticle: Codable {
    let id: Int
    let title: String
    let description: String
    let created_at: String
    let updated_at: String
}
