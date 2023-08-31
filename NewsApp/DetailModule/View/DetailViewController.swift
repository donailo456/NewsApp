//
//  DetailViewController.swift
//  NewsApp
//
//  Created by Danil Komarov on 31.08.2023.
//

import UIKit

class DetailViewController: UIViewController {
    var presenter: DetailViewPresenterProtocol!
    
    var label: UILabel = {
        var label = UILabel(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17, weight: .medium)
        return label
    }()
    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setArticle()
        cre()
    }
    func cre() {
        view.addSubview(label)
    }

}

extension DetailViewController: DetailViewProtocol {
    func setArticle(article: Article?) {
        label.text = article?.title
    }
    
    
}
