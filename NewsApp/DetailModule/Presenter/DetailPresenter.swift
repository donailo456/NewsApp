//
//  DetailPresenter.swift
//  NewsApp
//
//  Created by Danil Komarov on 31.08.2023.
//

import Foundation

protocol DetailViewProtocol: class {
    func setArticle(article: Article?)
//    func 
}

protocol DetailViewPresenterProtocol: class {
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, article: Article?)
    func setArticle()
    func tap()
}

class DetailPresenter: DetailViewPresenterProtocol {
    weak var view: DetailViewProtocol?
    let networkService: NetworkServiceProtocol!
    var router: RouterProtocol?
    var article: Article?
    
    required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, article: Article?) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.article = article
    }
    
    func tap() {
        router?.popToRoot()
    }
    
    func setArticle() {
        self.view?.setArticle(article: article)
    }
    
}
