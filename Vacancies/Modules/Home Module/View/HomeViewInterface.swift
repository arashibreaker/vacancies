//
//  HomeViewInterface.swift
//  Vacancies
//
//  Created by Ruslan Kuchukbaev on 22/11/2018.
//  Copyright © 2018 Ruslan Kuchukbaev. All rights reserved.
//

protocol HomeViewInterface: class {
    func toggleSpinner(enabled: Bool)
    func setCenteredMessage(message: String)
    func hideCenteredMessage()
    func reloadData()
    func endRefreshingAnimation()
}
