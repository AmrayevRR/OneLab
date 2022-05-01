//
//  NewsViewModel.swift
//  HW-3
//
//  Created by Ramir Amrayev on 4/26/22.
//

import Foundation

class NewsViewModel {
    private let newsService: NewsService
    private var currentPage = 1
    private var news: [New] = []
    private var isLoading = false
    
    var didLoadNews: (() -> Void)?
    init(newsService: NewsService) {
        self.newsService = newsService
    }
    
    func fetchTopHeadLines() {
        if isLoading {
            return
        }
        isLoading = true
        newsService.getTopHeadLines(
            page: currentPage,
            success: { [weak self] fetchedNews in
                self?.news.append(contentsOf: fetchedNews)
                self?.currentPage += 1
                self?.isLoading = false
                self?.didLoadNews?()
            },
            failure: { [weak self] error in
                print(error.localizedDescription.description)
                self?.isLoading = false
            }
        )
    }
    
    func getNews() -> [New] {
        return news
    }
    
    func getService() -> NewsService {
        return newsService
    }

}
