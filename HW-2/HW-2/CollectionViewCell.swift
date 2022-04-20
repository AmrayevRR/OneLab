//
//  CollectionViewCell.swift
//  HW-2
//
//  Created by Ramir Amrayev on 4/18/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CollectionViewCell"
    
    private let margin = 10
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "house")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let fullNameLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.leftInset = 4
        return label
    }()
    
    private let statusView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let professionLabel: UILabel = {
        let label = UILabel()
        label.text = "Profession"
        label.font = label.font.withSize(12)
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        
        contentView.addSubview(imageView)
        contentView.addSubview(fullNameLabel)
        contentView.addSubview(statusView)
        contentView.addSubview(professionLabel)
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutImageView()
        layoutFullNameLabel()
        layoutStatusView()
        layoutProfessionLabel()
    }
    
    public func configure(user: CollectionUser) {
        fullNameLabel.text = user.fullName
        professionLabel.text = user.profession
        imageView.image = user.image
        
        if (user.status == NetworkStatus.online) {
            statusView.backgroundColor = .systemGreen
        }
        else if (user.status == NetworkStatus.recentlyOnline) {
            statusView.backgroundColor = .systemYellow
        }
        else {
            statusView.backgroundColor = .systemGray4
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        fullNameLabel.text = nil
        professionLabel.text = nil
        imageView.image = nil
    }
    
    private func layoutImageView() {
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(margin)
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.height.equalTo(imageView.snp.width)
        }
        imageView.layer.cornerRadius = imageView.frame.height/2
    }
    
    private func layoutFullNameLabel() {
        fullNameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(margin*2)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func layoutStatusView() {
        statusView.snp.makeConstraints {
            $0.trailing.equalTo(fullNameLabel.snp.leading)
            $0.centerY.equalTo(fullNameLabel.snp.centerY)
            $0.width.equalTo(8)
            $0.height.equalTo(statusView.snp.width)
        }
        statusView.layer.cornerRadius = statusView.frame.width/2
    }
    
    private func layoutProfessionLabel() {
        professionLabel.snp.makeConstraints {
            $0.top.equalTo(fullNameLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
    }
}
