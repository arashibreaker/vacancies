//
//  VacanciesService.swift
//  Vacancies
//
//  Created by Ruslan on 22/11/2018.
//  Copyright © 2018 hh-test. All rights reserved.
//

import Foundation

protocol VacanciesService {
    var vacancies: [Vacancy] { get }
    
    func initialLoad(callback: (([Vacancy]?, Error?) -> ())?)
    func loadMore(callback: (([Vacancy]?, Error?) -> ())?)
}

class DefaultVacanciesService: VacanciesService {
    private let dataSource: DataSourceService
    
    private static let query = "iOS"
    private var page: Int
    private var dateFrom: Date?
    private var dateTo: Date
    
    private(set) var vacancies: [Vacancy]
    
    init(dataSource: DataSourceService) {
        self.dataSource = dataSource
        
        self.page = 0
        self.dateTo = Date()
        
        self.vacancies = []
    }
    
    func initialLoad(callback: (([Vacancy]?, Error?) -> ())?) {
        self.page = 0
        self.dateTo = Date()
        
        var components = DateComponents()
        components.year = -1
        let dateFrom = Calendar.current.date(byAdding: components, to: self.dateTo) ?? Date()
        self.dateFrom = dateFrom
        
        self.dataSource.loadVacancies(query: DefaultVacanciesService.query, page: self.page, dateFrom: dateFrom, dateTo: self.dateTo) { (vacancies, error) in
            callback?(vacancies, error)
        }
    }
    
    func loadMore(callback: (([Vacancy]?, Error?) -> ())?) {
        guard let dateFrom = self.dateFrom else {
            self.initialLoad(callback: callback)
            return
        }
        
        self.page += 1
        self.dataSource.loadVacancies(query: DefaultVacanciesService.query, page: self.page, dateFrom: dateFrom, dateTo: self.dateTo) { (vacancies, error) in
            callback?(vacancies, error)
        }
    }
}
