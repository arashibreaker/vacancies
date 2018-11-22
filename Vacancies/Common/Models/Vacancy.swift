//
//  Vacancy.swift
//  Vacancies
//
//  Created by Ruslan on 22/11/2018.
//  Copyright © 2018 hh-test. All rights reserved.
//

import Foundation

struct Vacancy: Codable {
    var id: String
    var name: String
    var salary: Salary
    var employer: Employer
}
