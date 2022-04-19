//
//  FriendCell.swift
//  HW-2
//
//  Created by Ramir Amrayev on 4/19/22.
//

import Foundation
import UIKit

struct Friend {
    let imageName: String
    let username: String
    let friendAmount: Int
    let isAdded: Bool
}

typealias FriendCellConfigurator = TableCellConfigurator<FriendCell, Friend>

class FriendCell: UITableViewCell, ConfigurableCell {
    
    private let imageWidth = 50
    private let margin = 8
    
    private let friendImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()
    
    private let friendsAmountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    private lazy var verticalStack: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [usernameLabel, friendsAmountLabel])
        stackView.axis = .vertical
        stackView.spacing = -8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ADD", for: .normal)
        button.setTitle("ADDED", for: .disabled)
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        
        button.setInsets(forContentPadding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4), imageTitlePadding: 4)
        button.layer.borderWidth = 1
        button.layer.borderColor = CGColor(red: 57/255, green: 122/255, blue: 246/255, alpha: 1)
        
        return button
    }()
    
    private let statusView: UIView = {
       let view = UIView()
        view.backgroundColor = .gray
        view.layer.borderWidth = 1
        view.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        return view
    }()
    
    private lazy var imageStatusView: UIView = {
       let view = UIView()
        view.addSubview(friendImageView)
        view.addSubview(statusView)
        return view
    }()
    
    private lazy var mainStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageStatusView, verticalStack])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fill
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        layoutFriendImageView()
//        layoutVerticalStackView()
        layoutButton()
        
        mainStack.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
//            $0.trailing.equalToSuperview().inset(12)
            $0.top.equalToSuperview().inset(margin)
            $0.bottom.equalToSuperview().inset(margin)
            $0.width.equalToSuperview().multipliedBy(0.7)
        }
        
        imageStatusView.snp.makeConstraints {
            $0.size.equalTo(imageWidth)
        }
        
        friendImageView.snp.makeConstraints {
            $0.size.equalToSuperview()
        }
        friendImageView.layer.cornerRadius = CGFloat(imageWidth/2)
        
        statusView.snp.makeConstraints {
            $0.size.equalToSuperview().dividedBy(4)
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        statusView.layer.cornerRadius = statusView.layer.frame.width/2
    }
    
    func configure(data: Friend) {
        friendImageView.image = UIImage(named: data.imageName)
        usernameLabel.text = data.username
        friendsAmountLabel.text = "\(data.friendAmount) Friends"
        addButton.isEnabled = !data.isAdded
        
        if (data.isAdded) {
            addButton.layer.borderColor = CGColor(red: 191/255, green: 191/255, blue: 191/255, alpha: 1)
        }
        else {
            addButton.layer.borderColor = CGColor(red: 57/255, green: 122/255, blue: 246/255, alpha: 1)
        }
    }
    
    private func layoutUI() {
//        contentView.addSubview(friendImageView)
//        contentView.addSubview(usernameLabel)
//        contentView.addSubview(verticalStack)
        contentView.addSubview(addButton)
        contentView.addSubview(mainStack)
        
        contentView.snp.makeConstraints {
            $0.height.equalTo(imageWidth+margin*2)
            $0.width.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        accessoryType = .none
    }
    
    private func layoutFriendImageView() {
        friendImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(imageWidth)
        }
        
        friendImageView.layer.cornerRadius = CGFloat(imageWidth/2)
    }
    
    private func layoutVerticalStackView() {
        verticalStack.snp.makeConstraints {
            $0.leading.equalTo(friendImageView.snp.trailing).offset(8)
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.centerY.equalToSuperview()
        }
        verticalStack.backgroundColor = .blue
        
        usernameLabel.snp.makeConstraints {
            $0.width.equalToSuperview()
        }
        friendsAmountLabel.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalTo(usernameLabel.snp.bottom)
        }
    }
    
    private func layoutButton() {
        addButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.centerY.equalTo(verticalStack.snp.centerY)
        }
        addButton.layer.cornerRadius = addButton.layer.frame.height/2
    }
}

extension UIButton {
    func setInsets(
        forContentPadding contentPadding: UIEdgeInsets,
        imageTitlePadding: CGFloat
    ) {
        self.contentEdgeInsets = UIEdgeInsets(
            top: contentPadding.top,
            left: contentPadding.left,
            bottom: contentPadding.bottom,
            right: contentPadding.right + imageTitlePadding
        )
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: imageTitlePadding,
            bottom: 0,
            right: -imageTitlePadding
        )
    }
}
