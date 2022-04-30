//
//  NewsViewModel.swift
//  HW-3
//
//  Created by Ramir Amrayev on 4/26/22.
//

import Foundation

class NewsViewModel {
    private let newsService: NewsService
    private var currentPage = 0
    private var news: [New] = []
    
    var didLoadNews: (([New]) -> Void)?
    init(newsService: NewsService) {
        self.newsService = newsService
    }
    
    func getTopHeadLines() {
        newsService.getTopHeadLines(
            page: currentPage,
            success: { [weak self] fetchedNews in
                self?.news.append(contentsOf: fetchedNews)
                guard let news = self?.news else { return }
                self?.currentPage += 1
                self?.didLoadNews?(news)
            },
            failure: { error in
                print(error.localizedDescription.description)
            }
        )
    }
    
    func getService() -> NewsService {
        return newsService
    }

}
