//
//  TableDirector.swift
//  HW-2
//
//  Created by Ramir Amrayev on 4/24/22.
//

import UIKit

class TableDirector: NSObject {
    
    let tableView: UITableView
    var items = [[CellConfigurator]]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    let actionProxy = CellActionProxy()
    
    init(tableView: UITableView, items: [[CellConfigurator]]) {
        self.tableView = tableView
        super.init()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.items = items
        
        NotificationCenter.default.addObserver(self, selector: #selector(onActionEvent(notification:)), name: CellAction.notificationName, object: nil)
    }
    
    @objc fileprivate func onActionEvent(notification: Notification) {
        if let eventData = notification.userInfo?["data"] as? CellActionEventData, let cell = eventData.cell as? UITableViewCell, let indexPath = self.tableView.indexPath(for: cell) {
            actionProxy.invoke(action: eventData.action, cell: cell, configurator: self.items[indexPath.section][indexPath.row])
        }
    }
}

extension TableDirector: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellConfig = self.items[indexPath.section][indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }
        self.actionProxy.invoke(action: .didSelect, cell: cell, configurator: cellConfig)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cellConfig = self.items[indexPath.section][indexPath.row]
        self.actionProxy.invoke(action: .willDisplay, cell: cell, configurator: cellConfig)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = PaddingLabel()
        label.leftInset = 10
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.backgroundColor = .systemBackground
        label.textColor = UIColor(named: "sectionTextColor")
        
        
        if (section == 0) {
            label.text = NSLocalizedString("Add New Contacts", comment: "")
            return label
        } else {
            label.text = NSLocalizedString("You Might Know Them", comment: "")
            label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            
            let amountLabel = UILabel()
            amountLabel.text = "(435)"
            amountLabel.font = UIFont.systemFont(ofSize: 12)
            amountLabel.textColor = .systemGray4
            
            let headerView = UIStackView(arrangedSubviews: [label, amountLabel])
            headerView.axis = .horizontal
            headerView.distribution = .fill
            headerView.spacing = 4
            headerView.backgroundColor = .systemBackground
            
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

extension TableDirector: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellConfig = self.items[indexPath.section][indexPath.row]
        tableView.register(type(of: cellConfig).cellClass, forCellReuseIdentifier: type(of:cellConfig).reuseId)
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: cellConfig).reuseId, for: indexPath)
        cellConfig.configure(cell: cell)
        return cell
    }
}
