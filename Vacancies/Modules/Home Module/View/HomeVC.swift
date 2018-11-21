//
//  HomeVC.swift
//  Vacancies
//
//  Created by Ruslan Kuchukbaev on 22/11/2018.
//  Copyright © 2018 Ruslan Kuchukbaev. All rights reserved.
//

import UIKit

class HomeVC: UITableViewController, HomeViewInterface {
    var eventHandler: HomeModuleInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = NSLocalizedString("Vacancies", comment: "")
        
        self.tableView.tableFooterView = UIView()
    }
}

// MARK: Data Source
extension HomeVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}
