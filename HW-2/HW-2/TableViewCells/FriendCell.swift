//
//  FriendCell.swift
//  HW-2
//
//  Created by Ramir Amrayev on 4/19/22.
//

import UIKit

typealias FriendCellConfigurator = TableCellConfigurator<FriendCell, Friend>

class FriendCell: UITableViewCell, ConfigurableCell {
    
    static let didTapAddButtonAction = "FriendCellDidTapAddButtonAction"
    
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
        stackView.spacing = -10
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var addButton: UIButton = {
        let button = AddButton(type: .system)
        button.setTitle(NSLocalizedString("ADD", comment: ""), for: .normal)
        button.setTitle(NSLocalizedString("ADDED", comment: ""), for: .disabled)
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .disabled)
        
        button.setInsets(forContentPadding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4), imageTitlePadding: 4)
        button.layer.borderWidth = 1
        
        button.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        
        return button
    }()
    
    private let statusView: UIView = {
       let view = UIView()
        view.backgroundColor = .gray
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.systemBackground.cgColor
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
        
        layoutMainStack()
        layoutButton()
    }
    
    func configure(data: Friend) {
        friendImageView.image = UIImage(named: data.imageName)
        usernameLabel.text = data.username
        friendsAmountLabel.text = amountToString(amount: data.friendAmount)
        addButton.isEnabled = !data.isAdded
        
        switch data.status {
        case NetworkStatus.online:
            statusView.backgroundColor = .systemGreen
        case NetworkStatus.recentlyOnline:
            statusView.backgroundColor = .systemYellow
        default:
            statusView.backgroundColor = .systemGray4
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        accessoryType = .none
    }
    
    private func layoutUI() {
        contentView.addSubview(addButton)
        contentView.addSubview(mainStack)
        
        contentView.snp.makeConstraints {
            $0.height.equalTo(imageWidth+margin*2)
            $0.width.equalToSuperview()
        }
    }
    
    private func layoutMainStack() {
        mainStack.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
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
            $0.size.equalToSuperview().dividedBy(3)
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        statusView.layer.cornerRadius = statusView.layer.frame.width/2
    }
    
    private func layoutButton() {
        addButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.centerY.equalTo(verticalStack.snp.centerY)
        }
        addButton.layer.cornerRadius = addButton.layer.frame.height/2
    }
    
    @objc private func didTapAddButton() {
        CellAction.custom(type(of: self).didTapAddButtonAction).invoke(cell: self)
    }
    
    private func amountToString(amount: Int) -> String {
        var string: String
        if amount < 2000 {
            string = "\(amount)"
        } else {
            string = "\(Double(amount)/1000.0)K"
        }
        string += " \(NSLocalizedString("Friends", comment: ""))"
        return string
    }
}
