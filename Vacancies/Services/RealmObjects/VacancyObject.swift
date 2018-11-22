//
//  VacancyObject.swift
//  Vacancies
//
//  Created by Ruslan on 23/11/2018.
//  Copyright © 2018 hh-test. All rights reserved.
//

import Foundation
import RealmSwift

class VacancyObject: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var salary: SalaryObject? = SalaryObject()
    @objc dynamic var employer: EmployerObject? = EmployerObject()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension VacancyObject {
    convenience init(vacancy: Vacancy) {
        self.init()
        self.id = vacancy.id
        self.name = vacancy.name
        self.salary = SalaryObject(salary: vacancy.salary)
        self.employer = EmployerObject(employer: vacancy.employer)
    }
}
