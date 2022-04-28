//
//  NewsSearchViewModel.swift
//  HW-3
//
//  Created by Ramir Amrayev on 4/28/22.
//

import Foundation

class NewsSearchViewModel {
    private let newsService: NewsService
    
    var didLoadNews: (([New]) -> Void)?
    init(newsService: NewsService) {
        self.newsService = newsService
    }
    
    func getNews(with searchText: String) {
        newsService.getNews(
            with: searchText,
            success: { [weak self] news in
                self?.didLoadNews?(news)
            },
            failure: { error in
                print(error.localizedDescription.description)
            }
        )
    }
}
