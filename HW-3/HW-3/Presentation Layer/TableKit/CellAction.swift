//
//  CellAction.swift
//  HW-3
//
//  Created by Ramir Amrayev on 4/27/22.
//

import UIKit

enum CellAction: Hashable {
    case didSelect
    case willDisplay
    case custom(String)
    
    var hashValue: Int {
        switch self {
        case .didSelect: return 0
        case .willDisplay: return 1
        case .custom(let custom):
            return custom.hashValue
        }
    }
}

struct CellActionEventData {
    let action: CellAction
    let cell: UIView
}

extension CellAction {
    static let notificationName = NSNotification.Name("cellAction")
    
    func invoke(cell: UIView) {
        NotificationCenter.default.post(name: CellAction.notificationName, object: nil, userInfo: ["data": CellActionEventData(action: self, cell: cell)])
    }
}

// ScrollView

struct ScrollActionEventData {
    let action: ScrollAction
    let scrollView: UIView
}

struct ScrollAction {
    static let notificationName = NSNotification.Name("scrollAction")
    
    func invoke(scrollView: UIView) {
        NotificationCenter.default.post(name: ScrollAction.notificationName, object: nil, userInfo: ["scroll_data": ScrollActionEventData(action: self, scrollView: scrollView)])
    }
}
