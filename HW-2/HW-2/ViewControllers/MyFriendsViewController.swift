//
//  MyFriendsViewController.swift
//  HW-2
//
//  Created by Ramir Amrayev on 4/18/22.
//

import UIKit
import SnapKit

class MyFriendsViewController: UIViewController {
    
    var viewModel = MyFriendsViewModel()
    
    private var collectionView: UICollectionView?
    
    private let margin = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Make the navigation bar background clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        layoutUI()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Restore the navigation bar to default
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
    
    private func initUI() {
        title = NSLocalizedString("My Friends", comment: "")
        view.backgroundColor = .secondarySystemBackground
        
        initNavBarButtons()
        initCollectionView()
        setBackBarButtonItem()
    }
    
    private func initNavBarButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(rightBarButtonAction))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .plain, target: self, action: #selector(leftBarButtonAction))
    }
    
    private func initCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = CGFloat(margin)
        layout.minimumInteritemSpacing = CGFloat(margin)
        let itemWidth = ((view.frame.size.width-CGFloat(margin*2))/2)-CGFloat(margin/2)
        layout.itemSize = CGSize(width: itemWidth,
                                 height: itemWidth)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else {
            return
        }
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = .secondarySystemBackground
        
        view.addSubview(collectionView)
    }
    
    
    private func layoutUI() {
        collectionView?.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(margin)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(margin)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(margin)
        }
    }
    
    private func setBackBarButtonItem() {
        let backBarBtnItem = UIBarButtonItem()
            backBarBtnItem.title = NSLocalizedString("Back", comment: "")
            navigationItem.backBarButtonItem = backBarBtnItem
    }
    
    @objc func rightBarButtonAction(sender: UINavigationItem!) {
        print("Search button clicked")
    }
    @objc func leftBarButtonAction(sender: UINavigationItem!) {
        print("Add button clicked")
        
        let addNewFriendVC = AddNewFriendViewController()
        self.navigationController?.pushViewController(addNewFriendVC, animated: true)
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

extension MyFriendsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        
        cell.configure(user: viewModel.users[indexPath.row])
        
        return cell
    }
}

extension MyFriendsViewController: UICollectionViewDelegate {
    
}
