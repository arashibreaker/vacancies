//
//  Salary.swift
//  Vacancies
//
//  Created by Ruslan on 22/11/2018.
//  Copyright © 2018 hh-test. All rights reserved.
//

import Foundation

struct Salary: Codable {
    var from: Int?
    var to: Int?
    var currency: String?
}

extension Salary {
    init(salaryObject: SalaryObject) {
        self.from = salaryObject.from < 0 ? nil : salaryObject.from
        self.to = salaryObject.to < 0 ? nil : salaryObject.to
        self.currency = salaryObject.currency.isEmpty ? nil : salaryObject.currency
    }
}
