//
//  ServiceFactory.swift
//  Vacancies
//
//  Created by Ruslan on 22/11/2018.
//  Copyright © 2018 hh-test. All rights reserved.
//

import Foundation

protocol ServiceFactory {
    var vacanciesService: VacanciesService { get }
}

class DefaultServiceFactory: ServiceFactory {
    private(set) var vacanciesService: VacanciesService
    
    init() {
        let parserService = HHNetworkJsonParserService()
        let dataSourceService = HHNetworkService(parser: parserService)
        let storageService = RealmStorageService()
        self.vacanciesService = DefaultVacanciesService(dataSource: dataSourceService, storage: storageService)
    }
}
