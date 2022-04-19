//
//  AddFriendOptionCell.swift
//  HW-2
//
//  Created by Ramir Amrayev on 4/18/22.
//

import Foundation

import UIKit

typealias AddFriendOptionCellConfigurator = TableCellConfigurator<AddFriendOptionCell, AddFriendOption>

class AddFriendOptionCell: UITableViewCell, ConfigurableCell {
    private let optionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .gray
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = UIColor(named: "addFriendOptinTextColor")
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [optionImageView, titleLabel])
        stackView.axis = .horizontal
        stackView.spacing = 10
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
        
        stackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().inset(8)
            $0.top.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(8)
            $0.height.equalTo(40)
        }
        
        optionImageView.snp.makeConstraints {
            $0.size.equalTo(30)
        }
        optionImageView.layer.cornerRadius = optionImageView.bounds.width / 2
    }
    
    func configure(data: AddFriendOption) {
        optionImageView.image = UIImage(systemName: data.systemImageName)
        titleLabel.text = data.title
    }
    
    private func layoutUI() {
        contentView.addSubview(stackView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        accessoryType = .none
    }
}
