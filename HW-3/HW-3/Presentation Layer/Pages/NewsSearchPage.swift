//
//  NewsSearchController.swift
//  HW-3
//
//  Created by Ramir Amrayev on 4/28/22.
//

import UIKit

class NewsSearchPage: UIViewController {

    private let viewModel: NewsSearchViewModel
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 380
        return tableView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        return searchBar
    }()
    
    private lazy var tableDirector: TableDirector = {
        let tableDirector = TableDirector(tableView: tableView, items: [])
        return tableDirector
    }()
    
    private var cellBuilder = NewsCellBuilder()
    
    init(viewModel: NewsSearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bindViewModel()
        layoutUI()
        cellActionHandlers()
        
        tableDirector.tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    private func layoutUI() {
        navigationController?.view.backgroundColor = .white
        self.navigationItem.setHidesBackButton(true, animated: true)
        layoutTableView()
        navigationItem.titleView = searchBar
    }
    
    private func layoutTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    private func bindViewModel() {
        viewModel.didLoadNews = { [weak self] news in
            let cellItems = self?.cellBuilder.reset()
                .buildCells(with: news)
                .getConfigurableCells()
            
            if let cellItems = cellItems {
                self?.tableDirector.reloadTable(with: cellItems)
            }
        }
    }
    
    private func cellActionHandlers() {
        self.tableDirector.actionProxy
            .on(action: .didSelect) { (config: NewsCellConfigurator, cell) in
                let item = config.item
                let newsDetailWebPage = NewsDetailWebPage(url: URL(string: item.url))
                self.navigationController?.pushViewController(newsDetailWebPage, animated: true)
            }
    }
    
    private func fetchNews(with searchText: String) {
        viewModel.getNews(with: searchText)
    }

}

extension NewsSearchPage: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationController?.popViewController(animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchText = searchBar.text else { return }
        
        if searchText != "" {
            fetchNews(with: searchText)
        }
    }
}
