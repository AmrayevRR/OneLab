//
//  AddNewFriendViewController.swift
//  HW-2
//
//  Created by Ramir Amrayev on 4/18/22.
//

import UIKit

class AddNewFriendViewModel {
    lazy var items: [CellConfigurator] = {
      return [
        AddFriendOptionCellConfigurator(item: AddFriendOption(systemImageName: "book", title: "From Contacts")),
        AddFriendOptionCellConfigurator(item: AddFriendOption(systemImageName: "signature", title: "By Username")),
        AddFriendOptionCellConfigurator(item: AddFriendOption(systemImageName: "phone.connection", title: "By Phone Number")),
        FriendCellConfigurator(item: Friend(imageName: "savannah", username: "Savannah Tucker", friendAmount: 1298, isAdded: false)),
        FriendCellConfigurator(item: Friend(imageName: "kathryn", username: "KathMur96", friendAmount: 12300, isAdded: true))
      ]
    }()
}

class AddNewFriendViewController: UIViewController {
    
    var viewModel = AddNewFriendViewModel()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
           
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        configureTableView()
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    private func initUI() {
        title = "Add New Friend"
        view.backgroundColor = .white
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddNewFriendViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.items[indexPath.row]
        tableView.register(type(of: item).cellClass, forCellReuseIdentifier: type(of: item).reuseId)
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: item).reuseId, for: indexPath)
            
        item.configure(cell: cell)
        
        return cell
    }
    
}
