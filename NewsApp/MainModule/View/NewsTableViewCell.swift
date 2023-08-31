//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Danil Komarov on 31.08.2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    static let identifier = "NewsTableViewCell"
    
    private let newsTitleLable: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    private let subtitleLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 13, weight: .light)
        return label
    }()
    
    private let newsImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = .secondarySystemBackground
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newsTitleLable)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(newsImageView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        newsTitleLable.frame = CGRect(x: 10, y: 0, width: 200, height: 70)
        subtitleLabel.frame = CGRect(x: 10, y: 70, width: 200, height: 30)
        newsImageView.frame = CGRect(x: contentView.frame.size.width - 170, y: 10, width: 160, height: contentView.frame.size.height - 20)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsTitleLable.text = "0"
        subtitleLabel.text = "0"
        newsImageView.image = nil
    }
    
    func configure(with viewModel: Article?){
        
        newsTitleLable.text = viewModel?.title
        subtitleLabel.text = viewModel?.description
        downloadImage(from: (URL(string: viewModel?.urlToImage ?? "") ?? URL(string: "0"))!)
        
    }
    
    //MARK: - downloadImage
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.newsImageView.image = UIImage(data: data)
            }
        }
    }

}
