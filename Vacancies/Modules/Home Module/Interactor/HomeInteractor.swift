//
//  HomeInteractor.swift
//  Vacancies
//
//  Created by Ruslan Kuchukbaev on 22/11/2018.
//  Copyright © 2018 Ruslan Kuchukbaev. All rights reserved.
//

import Foundation

class HomeInteractor : HomeInteractorInput {
    weak var output: HomeInteractorOutput?
    
    private let vacanciesService: VacanciesService
    
    init(vacanciesService: VacanciesService) {
        self.vacanciesService = vacanciesService
    }
    
    func loadVacancies() {
        self.vacanciesService.initialLoad { [weak self] (vacancies, error) in
            guard let output = self?.output else {
                return
            }
            guard let vacancies = vacancies else {
                output.loadVacanciesFailed(message: error?.localizedDescription ?? NSLocalizedString("Network error occured", comment: ""))
                return
            }
            output.loadVacanciesSucceed(vacancies: vacancies)
        }
    }
    
    func loadMoreVacancies() {
        self.vacanciesService.loadMore { [weak self] (vacancies, error) in
            guard let output = self?.output else {
                return
            }
            guard let vacancies = vacancies else {
                output.loadMoreVacanciesFailed(message: error?.localizedDescription ?? NSLocalizedString("Network error occured", comment: ""))
                return
            }
            output.loadMoreVacanciesSucceed(vacancies: vacancies)
        }
    }
    
    func reloadVacancies() {
        self.vacanciesService.reset()
        self.loadVacancies()
    }
}
