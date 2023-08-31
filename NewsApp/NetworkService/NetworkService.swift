//
//  NetworkService.swift
//  NewsApp
//
//  Created by Danil Komarov on 31.08.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func getNews(complition: @escaping (Result<[Article]?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func getNews(complition: @escaping (Result<[Article]?, Error>) -> Void) {
        let topHeadlinesURL = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2023-07-31&sortBy=publishedAt&apiKey=656b4de3edd045eeac81f3e49c3af14e")
        guard let url = topHeadlinesURL else { return }
        
        let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
        
        URLSession.shared.dataTask(with: request) { (data, _, error ) in
            if let error = error {
                complition(.failure(error))
                return
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(NewsModel.self, from: data)
                    print(result.articles.count)
                    complition(.success(result.articles))
                } catch {
                    complition(.failure(error))
                }
            }
            
        }.resume()
    }
    
}
