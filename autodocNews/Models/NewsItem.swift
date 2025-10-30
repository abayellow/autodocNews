//
//  NewsItem.swift
//  autodocNews
//
//  Created by Alexander Abanshin on 27.10.2025.
//

import Foundation

struct APIModel: Codable  {
    let news: [News]
}

nonisolated
struct News: Codable, Hashable {
    let title: String
    let titleImageUrl: URL?
    let fullUrl: URL
}
