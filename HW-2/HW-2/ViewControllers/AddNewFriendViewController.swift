//
//  AddNewFriendViewController.swift
//  HW-2
//
//  Created by Ramir Amrayev on 4/18/22.
//

import UIKit

class AddNewFriendViewController: UIViewController {
    
    private var viewModel = AddNewFriendViewModel()
    
    private lazy var tableDirector: TableDirector = {
        let tableDirector = TableDirector(tableView: tableView, items: viewModel.items)
        return tableDirector
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
           
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        configureTableView()
        cellActionHandlers()
        
        tableDirector.tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    private func initUI() {
        title = NSLocalizedString("Add New Friend", comment: "")
        view.backgroundColor = .white
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.separatorStyle = .none
    }
    
    private func cellActionHandlers() {
        self.tableDirector.actionProxy
            .on(action: .didSelect) { (config: FriendCellConfigurator, cell) in
                print("FriendCell selected")
            }.on(action: .custom(FriendCell.didTapAddButtonAction)){ (config: FriendCellConfigurator, cell) in
                
                var item = config.item
                item.isAdded = true
                
                cell.configure(data: item)
            }
    }
}
