//
//  AppDelegate.swift
//  Vacancies
//
//  Created by Ruslan on 21/11/2018.
//  Copyright © 2018 hh-test. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var services: ServiceFactory!
    var rootWireframe: RootWireframe!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        window.makeKeyAndVisible()
        
        self.services = DefaultServiceFactory()
        self.rootWireframe = RootWireframe(services: self.services)
        self.rootWireframe.install(window: window)
        
        return true
    }

}

