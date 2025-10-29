//
//  NetworkService.swift
//  autodocNews
//
//  Created by Alexander Abanshin on 27.10.2025.
//

import Foundation

class NetworkService  {
    private let session: URLSession

      init() {
          let configuration = URLSessionConfiguration.default
          configuration.timeoutIntervalForRequest = 30
          configuration.timeoutIntervalForResource = 60 
          self.session = URLSession(configuration: configuration)
      }
    
    func fetchData(_ endpoint: Endpoint) async throws -> [News] {
        guard let request = RequestBuilder.createURLRequest(endpoint) else {
            throw NetworkError.invalidRequest
        }
        
        
        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse(statusCode: 0)
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse(statusCode: httpResponse.statusCode)
        }
        
        do {
            let result = try JSONDecoder().decode(APIModel.self, from: data)
            return result.news
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }
}
