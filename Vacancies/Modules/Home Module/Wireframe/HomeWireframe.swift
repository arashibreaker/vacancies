//
//  HomeWireframe.swift
//  Vacancies
//
//  Created by Ruslan Kuchukbaev on 22/11/2018.
//  Copyright © 2018 Ruslan Kuchukbaev. All rights reserved.
//

import UIKit
import Foundation

class HomeWireframe {
    let rootWireframe: RootWireframe
    var navigationController: UINavigationController!
    
    init(rootWireframe: RootWireframe) {
        self.rootWireframe = rootWireframe
    }
    
    func presentHomeController(nc: UINavigationController, vacanciesService: VacanciesService) {
        self.navigationController = nc
        
        let viewController = HomeVC()
        let interactor = HomeInteractor(vacanciesService: vacanciesService)
        let presenter = HomePresenter()
        
        interactor.output = presenter
        
        viewController.eventHandler = presenter
        
        presenter.interactor = interactor
        presenter.wireframe = self
        presenter.userInterface = viewController
        
        nc.pushViewController(viewController, animated: true)
    }
    
    func dismissHomeController() {
        self.navigationController.popViewController(animated: true)
    }
}
