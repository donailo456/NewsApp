//
//  DetailViewController.swift
//  NewsApp
//
//  Created by Danil Komarov on 31.08.2023.
//

import UIKit

class DetailViewController: UIViewController {
    var presenter: DetailViewPresenterProtocol!
    
    var titlelabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var descrlabel: UITextView = {
        var label = UITextView()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var publishlabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .secondarySystemBackground
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setArticle()
        addView()
        addFrame()
    }
    
    func addView() {
        view.addSubview(titlelabel)
        view.addSubview(descrlabel)
        view.addSubview(publishlabel)
        view.addSubview(imageView)
    }
    
    func addFrame(){
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageView.bottomAnchor.constraint(equalTo: titlelabel.topAnchor),
            
            titlelabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            titlelabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titlelabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titlelabel.bottomAnchor.constraint(equalTo: descrlabel.topAnchor),
            
            descrlabel.widthAnchor.constraint(equalToConstant: view.bounds.width),
            descrlabel.heightAnchor.constraint(equalToConstant: 350),
            
            descrlabel.topAnchor.constraint(equalTo: titlelabel.bottomAnchor),
            descrlabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            descrlabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descrlabel.bottomAnchor.constraint(equalTo: publishlabel.topAnchor),
            
            publishlabel.topAnchor.constraint(equalTo: descrlabel.bottomAnchor),
            publishlabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            publishlabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            publishlabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            
        ])
    }

}

extension DetailViewController: DetailViewProtocol {
    func setArticle(article: Article?) {
        titlelabel.text = article?.title
        descrlabel.text = article?.description
        publishlabel.text = convertDateString(article?.publishedAt ?? "")
        downloadImage(from: (URL(string: article?.urlToImage ?? "") ?? URL(string: "0"))!)
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.imageView.image = UIImage(data: data)
            }
        }
    }
    
    func convertDateString(_ dateString: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd MMMM, yyyy"
            let formattedDate = outputFormatter.string(from: date)
            return formattedDate
        }
        
        return nil
    }
}
