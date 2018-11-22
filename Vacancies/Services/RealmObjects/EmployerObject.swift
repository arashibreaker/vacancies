//
//  EmployerObject.swift
//  Vacancies
//
//  Created by Ruslan on 23/11/2018.
//  Copyright © 2018 hh-test. All rights reserved.
//

import Foundation
import RealmSwift

class EmployerObject: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension EmployerObject {
    convenience init(employer: Employer) {
        self.init()
        self.id = employer.id
        self.name = employer.name
    }
}
