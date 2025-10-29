//
//  NewsViewModel.swift
//  autodocNews
//
//  Created by Alexander Abanshin on 27.10.2025.
//

import Foundation
import Combine


@MainActor
final class NewsViewModel {
    @Published private(set) var news: [News] = []
    @Published var selectedNews: News? = nil
    
    private let networkService = NetworkService()
    private var currentPage = 1
    private let pageSize = 15
    private var canLoadMore = true
    private var isLoading = false
    
    func loadNextPage() {
        guard canLoadMore, !isLoading else { return }
        isLoading = true
        
        Task {
            do {
                let result = try await networkService.fetchData(Endpoint.getNewsAt(page: currentPage, number: pageSize))
                
                if result.isEmpty {
                    canLoadMore = false
                } else {
                    news.append(contentsOf: result)
                    currentPage += 1
                }
                
                isLoading = false
                
            } catch {
                print("Ошибка загрузки новостей: \(error)")
                isLoading = false
            }
        }
    }
    
    func selectNews(at index: Int) {
        guard news.indices.contains(index) else { return }
        selectedNews = news[index]
    }
}
