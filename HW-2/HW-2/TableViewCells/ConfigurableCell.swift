//
//  ConfigurableCell.swift
//  HW-2
//
//  Created by Ramir Amrayev on 4/18/22.
//

import Foundation

protocol ConfigurableCell {
    associatedtype DataType
    static var reuseIdentifier: String { get }
    func configure(data: DataType)
}

extension ConfigurableCell {
    static var reuseIdentifier: String { return String(describing: Self.self) }
}
