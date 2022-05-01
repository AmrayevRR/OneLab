//
//  CellActionProxy.swift
//  HW-3
//
//  Created by Ramir Amrayev on 4/27/22.
//

import UIKit

class CellActionProxy {
    private var actions = [String: ((CellConfigurator, UIView) -> Void)]()
    
    // invoke some action and makes some notification
    func invoke(action: CellAction, cell: UIView, configurator: CellConfigurator) {
        let key = "\(action.hashValue)\(type(of: configurator).reuseId)"
        if let action = actions[key] {
            action(configurator, cell)
        }
    }
    
    // subscribe to cell action
    @discardableResult
    func on<CellType, DataType>(action: CellAction, handler: @escaping ((TableCellConfigurator<CellType, DataType>, CellType) -> Void)) -> Self {
        let key = "\(action.hashValue)\(CellType.reuseIdentifier)"
        actions[key] = { c, cell in
            handler(c as! TableCellConfigurator<CellType, DataType>, cell as! CellType)
        }
        return self
    }
}

class ScrollActionProxy {
    private var action: ((UIView) -> Void)?
    
    // invoke some action and makes some notification
    func invoke(scrollView: UIView) {
        if let action = action {
            action(scrollView)
        }
    }
    
    // subscribe to cell action
    func on(handler: @escaping ((UIScrollView) -> Void)) {
        action = { scrollView in
            handler(scrollView as! UIScrollView)
        }
    }
}
