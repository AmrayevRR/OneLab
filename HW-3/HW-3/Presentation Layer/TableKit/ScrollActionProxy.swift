//
//  ScrollActionProxy.swift
//  HW-3
//
//  Created by Ramir Amrayev on 02.05.2022.
//

import UIKit

class ScrollActionProxy {
    private var action: ((UIView) -> Void)?
    
    // invoke some action and makes some notification
    func invoke(scrollView: UIView) {
        if let action = action {
            action(scrollView)
        }
    }
    
    // subscribe to scroll action
    func on(handler: @escaping ((UIScrollView) -> Void)) {
        action = { scrollView in
            handler(scrollView as! UIScrollView)
        }
    }
}
