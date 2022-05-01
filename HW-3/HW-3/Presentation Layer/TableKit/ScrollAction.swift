//
//  ScrollAction.swift
//  HW-3
//
//  Created by Ramir Amrayev on 02.05.2022.
//

import UIKit

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
