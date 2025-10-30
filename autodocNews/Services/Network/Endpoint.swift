//
//  Endpoint.swift
//  autodocNews
//
//  Created by Alexander Abanshin on 29.10.2025.
//

import Foundation

enum Endpoint {
    case getNewsAt(page: Int, number: Int)
    
    var baseURL: String { "https://webapi.autodoc.ru" }
    
    var path: String {
        switch self {
        case .getNewsAt(let page, let number):
            return "/api/news/\(page)/\(number)"
        }
    }
}
