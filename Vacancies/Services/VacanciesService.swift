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
    func reset()
}

class DefaultVacanciesService: VacanciesService {
    private let dataSource: DataSourceService
    private let storage: StorageService
    
    private static let query = "iOS"
    private var page: Int
    private var dateFrom: Date?
    private var dateTo: Date
    
    private(set) var vacancies: [Vacancy]
    
    init(dataSource: DataSourceService, storage: StorageService) {
        self.dataSource = dataSource
        self.storage = storage
        
        self.page = 0
        self.dateTo = Date()
        
        self.vacancies = []
    }
    
    func initialLoad(callback: (([Vacancy]?, Error?) -> ())?) {
        if let dateTo = self.storage.loadDateTo(),
            let page = self.storage.loadPage() {
            let vacancies = self.storage.loadVacancies()
            if vacancies.count > 0 {
                self.dateTo = dateTo
                self.page = page
                self.dateFrom = self.getDateFrom(from: self.dateTo)
                
                self.vacancies = vacancies
                callback?(self.vacancies, nil)
                return
            } else {
                self.storage.clear()
            }
        }
        
        self.page = 0
        self.dateTo = Date()
        
        var components = DateComponents()
        components.year = -1
        let dateFrom = Calendar.current.date(byAdding: components, to: self.dateTo) ?? Date()
        self.dateFrom = dateFrom
        
        self.dataSource.loadVacancies(query: DefaultVacanciesService.query, page: self.page, dateFrom: dateFrom, dateTo: self.dateTo) { (vacancies, error) in
            if let vacancies = vacancies {
                self.vacancies = vacancies
                
                self.storage.saveDateTo(dateTo: self.dateTo)
                self.storage.savePage(page: self.page)
                self.storage.saveVacancies(vacancies: vacancies)
            }
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
            if let vacancies = vacancies {
                self.vacancies.append(contentsOf: vacancies)
                self.storage.savePage(page: self.page)
                self.storage.saveVacancies(vacancies: vacancies)
            }
            callback?(vacancies, error)
        }
    }
    
    func reset() {
        self.storage.clear()
    }
    
    private func getDateFrom(from dateTo: Date) -> Date {
        var components = DateComponents()
        components.year = -1
        return Calendar.current.date(byAdding: components, to: dateTo) ?? Date()
    }
}
