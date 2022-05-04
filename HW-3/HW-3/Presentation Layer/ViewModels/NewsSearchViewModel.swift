//
//  NewsSearchViewModel.swift
//  HW-3
//
//  Created by Ramir Amrayev on 4/28/22.
//

import Foundation

class NewsSearchViewModel {
    private let newsService: NewsService
    private var news: [New] = []
    private var currentPage = 1
    private var isLoading = false
    
    var didLoadNews: (() -> Void)?
    init(newsService: NewsService) {
        self.newsService = newsService
    }
    
    func fetchNews(with searchText: String, isMore: Bool = false) {
        if isMore {
            if isLoading {
                return
            }
        } else {
            currentPage = 1
        }
        isLoading = true
        newsService.getNews(
            with: searchText,
            page: currentPage,
            success: { [weak self] news in
                if isMore {
                    self?.news.append(contentsOf: news)
                } else {
                    self?.news = news
                }
                self?.currentPage += 1
                self?.isLoading = false
                self?.didLoadNews?()
            },
            failure: { [weak self] error in
                self?.isLoading = false
                print(error.localizedDescription.description)
            }
        )
    }
    
    func getNews() -> [New] {
        return news
    }
}
