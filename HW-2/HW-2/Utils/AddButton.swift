//
//  AddButton.swift
//  HW-2
//
//  Created by Ramir Amrayev on 4/19/22.
//
import UIKit

class AddButton: UIButton {
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
    
    override var isEnabled: Bool {
        didSet {

            switch isEnabled {
            case true:
                self.backgroundColor = .systemBackground
                layer.borderColor = UIColor.link.cgColor
            case false:
                self.backgroundColor = UIColor(named: "addButtonDisableColor")
                layer.borderColor = UIColor(named: "addButtonDisableBorderColor")?.cgColor
            }
        }
    }
}
