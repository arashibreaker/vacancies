//
//  RootWireframe.swift
//  Vacancies
//
//  Created by Ruslan on 22/11/2018.
//  Copyright © 2018 hh-test. All rights reserved.
//

import UIKit

class RootWireframe {
    let services: ServiceFactory
    
    var window: UIWindow!
    var navigationController: UINavigationController!
    
    
    init(services: ServiceFactory) {
        self.services = services
    }
    
    func install(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        self.window.rootViewController = self.navigationController
        
        self.presentHomeModule()
    }
    
    func presentHomeModule() {
        let wireframe = HomeWireframe(rootWireframe: self)
        wireframe.presentHomeController(nc: self.navigationController, vacanciesService: self.services.vacanciesService)
    }
}
