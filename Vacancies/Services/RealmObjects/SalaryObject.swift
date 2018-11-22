//
//  SalaryObject.swift
//  Vacancies
//
//  Created by Ruslan on 23/11/2018.
//  Copyright © 2018 hh-test. All rights reserved.
//

import Foundation
import RealmSwift

class SalaryObject: Object {
    @objc dynamic var from: Int = -1
    @objc dynamic var to: Int = -1
    @objc dynamic var currency: String = ""
}

extension SalaryObject {
    convenience init(salary: Salary) {
        self.init()
        self.from = salary.from ?? -1
        self.to = salary.to ?? -1
        self.currency = salary.currency ?? ""
    }
}
