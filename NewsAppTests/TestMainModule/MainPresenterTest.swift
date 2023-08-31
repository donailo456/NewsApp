//
//  MainPresenterTest.swift
//  NewsAppTests
//
//  Created by Danil Komarov on 31.08.2023.
//

import XCTest
@testable import NewsApp

class MockView: MainViewProtocol {
    func success() {
    }
    
    func failure(error: Error) {
    }

}

class MockNetworkService: NetworkServiceProtocol {
    var article: [Article]!
    
    init() {}
    
    convenience init(article: [Article]?) {
        self.init()
        self.article = article
    }
    
    func getNews(complition: @escaping (Result<[NewsApp.Article]?, Error>) -> Void) {
        if let article = article {
            complition(.success(article))
        }
        else {
            let error = NSError(domain: "", code: 0)
            complition(.failure(error))
        }
    }
    
}

class MainPresenterTest: XCTestCase {
    
    var view: MockView!
    var presenter: MainPresenter!
    var networkSerivce: NetworkServiceProtocol!
    var router: RouterProtocol!
    var articles = [Article]()
    
    override func setUpWithError() throws {
       let nav = UINavigationController()
        let assembly = AsselderModuleBuilder()
        router = Router(navigationController: nav, assemblyBuilder: assembly)
    }

    override func tearDownWithError() throws {
        view = nil
        networkSerivce = nil
        presenter = nil
    }
    
    func testGetSuccesComments() {
        let article = Article(author: "baz", title: "bar", description: "fo", url: "foo", urlToImage: "baz1", publishedAt: "bar1", content: "fooo")
        articles.append(article)
        
        view = MockView()
        networkSerivce = MockNetworkService(article: articles)
        presenter = MainPresenter(view: view, networkService: networkSerivce, router: router)
        
        var catchArticles: [Article]?
        
        networkSerivce.getNews { result in
            switch result{
            case .success(let article):
                catchArticles = article
            case .failure(let error):
                print(error)
            }
        }
        XCTAssertNotEqual(catchArticles?.count, 0)
        XCTAssertEqual(catchArticles?.count, articles.count)
    }
    
    func testGetFailureComments() {
        let article = Article(author: "baz", title: "bar", description: "fo", url: "foo", urlToImage: "baz1", publishedAt: "bar1", content: "fooo")
        articles.append(article)
        
        view = MockView()
        networkSerivce = MockNetworkService()
        presenter = MainPresenter(view: view, networkService: networkSerivce, router: router)
        
        var catchError: Error?
        
        networkSerivce.getNews { result in
            switch result{
            case .success( _):
                break
            case .failure(let error):
                catchError = error
            }
        }
        XCTAssertNotNil(catchError)
    }
}

