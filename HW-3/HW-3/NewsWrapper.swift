//
//  NewsWrapper.swift
//  HW-3
//
//  Created by Ramir Amrayev on 4/26/22.
//

import Foundation

struct NewsWrapper: Codable {
    let status: String
    let totalResults: Int
    let articles: [New]
}

// MARK: - Article
struct New: Codable {
    let source: Source
    let author: String?
    let title: String
    let articleDescription: String?
    let url: String
    let urlToImage: String?
//    let publishedAt: Date
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, content
    }
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}
