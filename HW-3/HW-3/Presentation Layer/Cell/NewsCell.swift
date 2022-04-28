//
//  NewsCell.swift
//  HW-3
//
//  Created by Ramir Amrayev on 4/27/22.
//

import UIKit
import SnapKit

typealias NewsCellConfigurator = TableCellConfigurator<NewsCell, New>

class NewsCell: UITableViewCell, ConfigurableCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = false
        textView.backgroundColor = UIColor.systemBackground.withAlphaComponent(0)
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: New) {
        titleLabel.text = data.title
        if let imageUrlString = data.urlToImage {
            if let url = URL(string: imageUrlString) {
                newsImageView.af.setImage(withURL: url)
            }
        }
        descriptionTextView.text = data.articleDescription
    }
    
    private func layoutUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(newsImageView)
        contentView.addSubview(descriptionTextView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        newsImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(titleLabel)
            $0.width.equalTo(titleLabel)
            $0.height.equalTo(200)
        }
        
        descriptionTextView.snp.makeConstraints {
            $0.top.equalTo(newsImageView.snp.bottom).offset(10)
            $0.leading.equalTo(titleLabel)
            $0.width.equalTo(titleLabel)
        }
    }
}
