//
//  AddNewFriendViewModel.swift
//  HW-2
//
//  Created by Ramir Amrayev on 4/19/22.
//

import Foundation

class AddNewFriendViewModel {
    lazy var items: [[CellConfigurator]] = {
      return [
        [
            AddFriendOptionCellConfigurator(item: AddFriendOption(systemImageName: "book", title: NSLocalizedString("From Contacts", comment: ""))),
            AddFriendOptionCellConfigurator(item: AddFriendOption(systemImageName: "signature", title: NSLocalizedString("By Username", comment: ""))),
            AddFriendOptionCellConfigurator(item: AddFriendOption(systemImageName: "phone.connection", title: NSLocalizedString("By Phone Number", comment: "")))
        ],
        [
            FriendCellConfigurator(item: Friend(imageName: "savannah", username: "Savannah Tucker", friendAmount: 1298, isAdded: false, status: NetworkStatus.offline)),
            FriendCellConfigurator(item: Friend(imageName: "kathryn", username: "KathMur96", friendAmount: 12300, isAdded: true, status: NetworkStatus.online)),
            FriendCellConfigurator(item: Friend(imageName: "courtney", username: "Courtney Hehry", friendAmount: 467, isAdded: true, status: NetworkStatus.recentlyOnline)),
            FriendCellConfigurator(item: Friend(imageName: "jim", username: "Jimmy", friendAmount: 4500, isAdded: false, status: NetworkStatus.offline)),
            FriendCellConfigurator(item: Friend(imageName: "jenny", username: "Jenny Wilson", friendAmount: 18, isAdded: false, status: NetworkStatus.online)),
            FriendCellConfigurator(item: Friend(imageName: "darrell", username: "Darrell Stewart", friendAmount: 489, isAdded: false, status: NetworkStatus.online)),
            FriendCellConfigurator(item: Friend(imageName: "alexandria", username: "Alexandria Ocasio", friendAmount: 732, isAdded: false, status: NetworkStatus.offline)),
            FriendCellConfigurator(item: Friend(imageName: "julien", username: "Julien August", friendAmount: 67, isAdded: false, status: NetworkStatus.recentlyOnline))
        ]
      ]
    }()
}
