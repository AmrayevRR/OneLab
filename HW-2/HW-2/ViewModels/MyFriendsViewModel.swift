//
//  MyFriendsViewModel.swift
//  HW-2
//
//  Created by Ramir Amrayev on 4/18/22.
//

import Foundation
import UIKit

class MyFriendsViewModel {
    lazy var users: [CollectionUser] = {
      return [
        CollectionUser(fullName: "Savannah Tucker", profession: "Retail Supervisor", image: UIImage(named: "savannah")!, status: NetworkStatus.online),
        CollectionUser(fullName: "Kathryn Murphy", profession: "Photographer", image: UIImage(named: "kathryn")!, status: NetworkStatus.online),
        CollectionUser(fullName: "Darrell Stewart", profession: "UI/UX Designer", image: UIImage(named: "darrell")!, status: NetworkStatus.offline),
        CollectionUser(fullName: "Jenny Wilson", profession: "Model, Actress", image: UIImage(named: "jenny")!, status: NetworkStatus.offline),
        CollectionUser(fullName: "Courtney Henry", profession: "Taxi Driver", image: UIImage(named: "courtney")!, status: NetworkStatus.recentlyOnline),
        CollectionUser(fullName: "Jim Warren", profession: "Company CEO", image: UIImage(named: "jim")!, status: NetworkStatus.offline),
        CollectionUser(fullName: "Alexandria Ocasio", profession: "Politician", image: UIImage(named: "alexandria")!, status: NetworkStatus.recentlyOnline),
        CollectionUser(fullName: "Julien august", profession: "Waitress", image: UIImage(named: "julien")!, status: NetworkStatus.online),
      ]
    }()
}
