//
//  HomeVC.swift
//  Vacancies
//
//  Created by Ruslan Kuchukbaev on 22/11/2018.
//  Copyright © 2018 Ruslan Kuchukbaev. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, HomeViewInterface {
    var eventHandler: HomeModuleInterface!
    
    private var tableView: UITableView!
    private let spinner = UIActivityIndicatorView(style: .whiteLarge)
    private var errorMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.navigationItem.title = NSLocalizedString("Вакансии", comment: "")
        
        self.tableView = UITableView()
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.tableView)
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.allowsSelection = false
        self.tableView.tableFooterView = UIView()
        self.tableView.register(VacancyCell.self, forCellReuseIdentifier: "VacancyCell")
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(tableRefreshStarted), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
        
        self.spinner.translatesAutoresizingMaskIntoConstraints = false
        self.spinner.color = .gray
        self.spinner.hidesWhenStopped = true
        self.view.addSubview(self.spinner)
        self.spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        self.errorMessageLabel = UILabel()
        self.errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        self.errorMessageLabel.font = UIKitService.shared.fontErrorMessage
        self.errorMessageLabel.textColor = UIKitService.shared.grayColor
        self.errorMessageLabel.numberOfLines = 0
        self.errorMessageLabel.textAlignment = .center
        self.view.addSubview(self.errorMessageLabel)
        self.errorMessageLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        self.errorMessageLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0).isActive = true
        self.errorMessageLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.errorMessageLabel.isHidden = true
        
        self.eventHandler.viewLoaded()
    }
    
    func toggleSpinner(enabled: Bool) {
        if enabled {
            self.spinner.startAnimating()
        } else {
            self.spinner.stopAnimating()
        }
    }
    
    @objc func tableRefreshStarted() {
        self.eventHandler.reloadRequested()
    }
    
    func setCenteredMessage(message: String) {
        self.errorMessageLabel.isHidden = false
        self.errorMessageLabel.text = message
    }
    
    func hideCenteredMessage() {
        self.errorMessageLabel.isHidden = true
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
    
    func endRefreshingAnimation() {
        self.tableView.refreshControl?.endRefreshing()
    }
}

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.eventHandler.getModel(indexPath: indexPath)
        switch model.type {
        case .vacancy:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "VacancyCell") as? VacancyCell else {
                return UITableViewCell()
            }
            cell.model = model.object as? Vacancy
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventHandler.modelsCount
    }
}

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.eventHandler.modelsCount - 1 {
            self.eventHandler.scrolledContentToBottom()
        }
    }
}
