//
//  HomeModuleInterface.swift
//  Vacancies
//
//  Created by Ruslan Kuchukbaev on 22/11/2018.
//  Copyright © 2018 Ruslan Kuchukbaev. All rights reserved.
//
import UIKit

protocol HomeModuleInterface: class {
    var modelsCount: Int { get }
    func getModel(indexPath: IndexPath) -> HomeTableModel
    
    func viewLoaded()
    func reloadRequested()
    func scrolledContentToBottom()
}
