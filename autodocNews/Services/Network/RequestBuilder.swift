//
//  RequestBuilder.swift
//  autodocNews
//
//  Created by Alexander Abanshin on 29.10.2025.
//

import Foundation

enum RequestBuilder {
    static func createURLRequest(_ endpoint: Endpoint) -> URLRequest? {
        let baseURL = endpoint.baseURL
        
        return URLComponents(string: baseURL)
            .flatMap {
                var components = $0
                components.path = endpoint.path
                return components.url
            }
            .map {
                return URLRequest(url: $0)
            }
    }
}
