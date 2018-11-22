//
//  DataSourceService.swift
//  Vacancies
//
//  Created by Ruslan on 22/11/2018.
//  Copyright © 2018 hh-test. All rights reserved.
//

import Foundation

protocol DataSourceService {
    func loadVacancies(query: String, page: Int, dateFrom: Date, dateTo: Date, callback: @escaping ([Vacancy]?, Error?) -> ())
}

class HHNetworkService: DataSourceService {
    private static let rootUrl = "https://api.hh.ru/vacancies"
    
    private let parser: ParserService
    
    init(parser: ParserService) {
        self.parser = parser
    }
    
    func loadVacancies(query: String, page: Int, dateFrom: Date, dateTo: Date, callback: @escaping ([Vacancy]?, Error?) -> ()) {
        let request = NetworkRequest(url: HHNetworkService.rootUrl)
        
        request.sendRequest(params: [
            "text": query,
            "page": "\(page)",
            "per_page": "20",
            "date_from": DataFormatters.formatToString(date: dateFrom),
            "date_to": DataFormatters.formatToString(date: dateTo),
            "only_with_salary": "true"
        ]) { (data, error) in
            guard let data = data else {
                callback(nil, error)
                return
            }
            
            let vacancies = self.parser.parseVacancies(data: data)
            callback(vacancies, nil)
        }
    }
}
