//
//  AddNewFriendViewController.swift
//  HW-2
//
//  Created by Ramir Amrayev on 4/18/22.
//

import UIKit

class AddNewFriendViewController: UIViewController {
    
    private var viewModel = AddNewFriendViewModel()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
           
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        configureTableView()
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
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
}

//MARK: -UITableViewDataSource
extension AddNewFriendViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.items[indexPath.section][indexPath.row]
        tableView.register(type(of: item).cellClass, forCellReuseIdentifier: type(of: item).reuseId)
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: item).reuseId, for: indexPath)
            
        item.configure(cell: cell)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.items.count
    }
    
}

//MARK: -UITableViewDelegate
extension AddNewFriendViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = PaddingLabel()
        label.leftInset = 10
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.backgroundColor = .systemBackground
        label.textColor = UIColor(named: "sectionTextColor")
        
        
        if (section == 0) {
            label.text = NSLocalizedString("Add New Contacts", comment: "")
            return label
        }
        else {
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
