//
//  NewsPage.swift
//  HW-3
//
//  Created by Ramir Amrayev on 4/26/22.
//

import UIKit
import SnapKit

class NewsPage: UIViewController {
    
    private let viewModel: NewsViewModel
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 380
        return tableView
    }()
    
    private lazy var tableDirector: TableDirector = {
        let tableDirector = TableDirector(tableView: tableView, items: [])
        return tableDirector
    }()
    
    private var cellBuilder = NewsCellBuilder()
    
    init(viewModel: NewsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        view.backgroundColor = .systemBackground
        bindViewModel()
        layoutUI()
        
        cellActionHandlers()
        scrollActionHandler()
        fetchData()
        
        tableDirector.tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    private func layoutUI() {
        navigationController?.view.backgroundColor = .systemBackground
        layoutTableView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearchButton))
    }
    
    private func layoutTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    private func fetchData() {
        viewModel.fetchTopHeadLines()
    }
    
    private func bindViewModel() {
        viewModel.didLoadNews = { [weak self] in
            guard let news = self?.viewModel.getNews() else { return }
            let cellItems = self?.cellBuilder.reset()
                .buildCells(with: news)
                .getConfigurableCells()
            
            if let cellItems = cellItems {
                self?.tableDirector.reloadTable(with: cellItems)
            }
        }
    }
    
    private func cellActionHandlers() {
        self.tableDirector.cellActionProxy
            .on(action: .didSelect) { [weak self] (config: NewsCellConfigurator, cell) in
                let item = config.item
                let newsDetailWebPage = NewsDetailWebPage(url: URL(string: item.url))
                self?.navigationController?.pushViewController(newsDetailWebPage, animated: true)
            }
    }
    
    private func scrollActionHandler() {
        self.tableDirector.scrollActionProxy
            .on { [weak self] scrollView in
                let position = scrollView.contentOffset.y
                
                guard let tableViewContentHeight = self?.tableView.contentSize.height else { return }
                if position > (tableViewContentHeight - 100 - scrollView.frame.size.height) {
                    // fetch more data
                    self?.viewModel.fetchTopHeadLines()
                }
            }
    }
    
    @objc func didTapSearchButton() {
        let newsSearchPage = NewsSearchPage(viewModel: NewsSearchViewModel(newsService: viewModel.getService()))
        navigationController?.pushViewController(newsSearchPage, animated: true)
    }
}

extension NewsPage: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > tableView.contentSize.height - 100 {
            // fetch more data
            print("fetch more data")
        }
    }
}
