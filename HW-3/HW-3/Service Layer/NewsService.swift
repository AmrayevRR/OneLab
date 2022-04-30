//
//  NewsService.swift
//  HW-3
//
//  Created by Ramir Amrayev on 4/26/22.
//

import Foundation
import Alamofire
import AlamofireImage

protocol NewsService {
    func getTopHeadLines(page: Int, success: @escaping ([New]) -> Void, failure: @escaping (Error) -> Void)
    func getNews(with searchText: String, success: @escaping ([New]) -> Void, failure: @escaping (Error) -> Void)

}

class NewsServiceImpl: NewsService {
    func getTopHeadLines(page: Int, success: @escaping ([New]) -> Void, failure: @escaping (Error) -> Void) {
        let urlString = String(format: "%@top-headlines", EndPoint.baseUrl)
        guard let url = URL(string: urlString) else { return }
        
        let queryParams: Parameters = ["apiKey": EndPoint.apiKey, "country": EndPoint.country, "page": page]
        
        AF.request(url, method: .get, parameters: queryParams).responseDecodable { (response: DataResponse<NewsWrapper, AFError>) in
            switch response.result {
            case .success(let newsData):
                success(newsData.articles)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func getNews(with searchText: String, success: @escaping ([New]) -> Void, failure: @escaping (Error) -> Void) {
        let urlString = String(format: "%@everything", EndPoint.baseUrl)
        guard let url = URL(string: urlString) else { return }
        
        let queryParams: Parameters = ["apiKey": EndPoint.apiKey, "q": searchText]
        
        AF.request(url, method: .get, parameters: queryParams).responseDecodable { (response: DataResponse<NewsWrapper, AFError>) in
            switch response.result {
            case .success(let newsData):
                success(newsData.articles)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    // service Detail News
    
    // search
}
