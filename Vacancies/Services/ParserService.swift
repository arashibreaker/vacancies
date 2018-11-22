//
//  ParserService.swift
//  Vacancies
//
//  Created by Ruslan on 22/11/2018.
//  Copyright © 2018 hh-test. All rights reserved.
//

import Foundation

protocol ParserService {
    func parseVacancies(data: Data) -> [Vacancy]
}

class HHNetworkJsonParserService: ParserService {
    func parseVacancies(data: Data) -> [Vacancy] {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(VacancyResponse.self, from: data).items
        } catch {
            return []
        }
    }
}
