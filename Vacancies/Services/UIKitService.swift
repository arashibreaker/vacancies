//
//  UIKitService.swift
//  Vacancies
//
//  Created by Ruslan on 22/11/2018.
//  Copyright © 2018 hh-test. All rights reserved.
//

import UIKit

class UIKitService {
    private(set) var fontBody: UIFont = UIFont.systemFont(ofSize: 17, weight: .regular)
    private(set) var fontTitle: UIFont = UIFont.systemFont(ofSize: 21, weight: .regular)
    private(set) var fontSubtitle: UIFont = UIFont.systemFont(ofSize: 18, weight: .medium)
    private(set) var fontErrorMessage: UIFont = UIFont.systemFont(ofSize: 20, weight: .regular)
    
    private(set) var grayColor: UIColor = .gray
    
    static let shared: UIKitService = UIKitService()
    
    private init() {
        
    }
}
