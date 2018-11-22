//
//  HomeTableModel.swift
//  Vacancies
//
//  Created by Ruslan on 22/11/2018.
//  Copyright © 2018 hh-test. All rights reserved.
//

import Foundation

enum HomeTableModelType {
    case vacancy
}

struct HomeTableModel {
    var type: HomeTableModelType
    var object: Any?
}
