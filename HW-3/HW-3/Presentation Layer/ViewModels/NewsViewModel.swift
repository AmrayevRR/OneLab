//
//  NewsViewModel.swift
//  HW-3
//
//  Created by Ramir Amrayev on 4/26/22.
//

import Foundation

class NewsViewModel {
    private let newsService: NewsService
    
    var didLoadNews: (([New]) -> Void)?
    init(newsService: NewsService) {
        self.newsService = newsService
    }
    
    func getTopHeadLines() {
        newsService.getTopHeadLines(
            success: { [weak self] news in
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
