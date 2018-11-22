//
//  HomeIO.swift
//  Vacancies
//
//  Created by Ruslan Kuchukbaev on 22/11/2018.
//  Copyright © 2018 Ruslan Kuchukbaev. All rights reserved.
//

protocol HomeInteractorInput {
    func loadVacancies()
    func loadMoreVacancies()
}


protocol HomeInteractorOutput: class {
    func loadVacanciesSucceed(vacancies: [Vacancy])
    func loadMoreVacanciesSucceed(vacancies: [Vacancy])
    func loadVacanciesFailed(message: String)
    func loadMoreVacanciesFailed(message: String)
}
