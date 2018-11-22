//
//  HomePresenter.swift
//  Vacancies
//
//  Created by Ruslan Kuchukbaev on 22/11/2018.
//  Copyright © 2018 Ruslan Kuchukbaev. All rights reserved.
//
import Foundation

class HomePresenter: HomeInteractorOutput, HomeModuleInterface {
    var interactor: HomeInteractorInput!
    var wireframe: HomeWireframe!
    
    weak var userInterface: HomeViewInterface?
    weak var homeModuleDelegate: HomeModuleDelegate?
    
    private var models: [HomeTableModel] = []
    
    private var isLoading = false
    
    // MARK: output
    
    func loadVacanciesSucceed(vacancies: [Vacancy]) {
        self.models = vacancies.map({HomeTableModel(type: .vacancy, object: $0)})
        DispatchQueue.main.async {
            guard let userInterface = self.userInterface else {
                return
            }
            userInterface.toggleSpinner(enabled: false)
            userInterface.endRefreshingAnimation()
            userInterface.reloadData()
        }
    }
    
    func loadMoreVacanciesSucceed(vacancies: [Vacancy]) {
        guard let userInterface = self.userInterface else {
            return
        }
        
        DispatchQueue.main.async {
            if vacancies.count > 0 {
                self.models.append(contentsOf: vacancies.map({HomeTableModel(type: .vacancy, object: $0)}))
                userInterface.reloadData()
            }
            self.isLoading = false
        }
    }
    
    func loadVacanciesFailed(message: String) {
        DispatchQueue.main.async {
            guard let userInterface = self.userInterface else {
                return
            }
            userInterface.toggleSpinner(enabled: false)
            userInterface.setCenteredMessage(message: message)
        }
    }
    
    func loadMoreVacanciesFailed(message: String) {
        
    }
    
    // MARK: module interface
    
    func viewLoaded() {
        guard let userInterface = self.userInterface else {
            return
        }
        userInterface.toggleSpinner(enabled: true)
        self.interactor.loadVacancies()
    }
    
    func reloadRequested() {
        guard let userInterface = self.userInterface else {
            return
        }
        userInterface.hideCenteredMessage()
        self.interactor.reloadVacancies()
    }
    
    var modelsCount: Int {
        get {
            return self.models.count
        }
    }
    
    func getModel(indexPath: IndexPath) -> HomeTableModel {
        return self.models[indexPath.row]
    }
    
    func scrolledContentToBottom() {
        guard !self.isLoading else {
            return
        }
        self.isLoading = true
        DispatchQueue.global(qos: .default).async {
            self.interactor.loadMoreVacancies()
        }
    }
}
