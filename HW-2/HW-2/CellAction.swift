//
//  CellAction.swift
//  HW-2
//
//  Created by Ramir Amrayev on 4/24/22.
//

import Foundation
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
