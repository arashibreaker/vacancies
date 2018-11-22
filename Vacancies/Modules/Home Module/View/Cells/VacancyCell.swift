//
//  VacancyCell.swift
//  Vacancies
//
//  Created by Ruslan on 22/11/2018.
//  Copyright © 2018 hh-test. All rights reserved.
//

import UIKit

class VacancyCell: UITableViewCell {
    
    private var titleLabel: UILabel!
    private var salaryLabel: UILabel!
    private var employerLabel: UILabel!
    
    var model: Vacancy? {
        didSet {
            self.titleLabel?.text = model?.name
            
            var salary = ""
            if let from = model?.salary.from {
                salary = "\(NSLocalizedString("от", comment: "")) \(from) "
            } else if let to = model?.salary.to {
                salary = "\(salary)\(NSLocalizedString("до", comment: "")) \(to) "
            }
            if let currency = model?.salary.currency {
                var currencySymbol = ""
                switch currency {
                case "RUR":
                    currencySymbol = "₽"
                case "USD":
                    currencySymbol = "$"
                case "EUR":
                    currencySymbol = "€"
                default:
                    currencySymbol = currency
                }
                salary = "\(salary)\(currencySymbol)"
            } else {
                salary = "\(salary)₽"
            }
            self.salaryLabel.text = salary
            
            self.employerLabel.text = model?.employer.name
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.titleLabel = UILabel()
        self.titleLabel.font = UIKitService.shared.fontTitle
        self.titleLabel.numberOfLines = 0
        self.addSubview(self.titleLabel)
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16.0).isActive = true
        
        self.salaryLabel = UILabel()
        self.salaryLabel.font = UIKitService.shared.fontSubtitle
        self.salaryLabel.numberOfLines = 1
        self.addSubview(self.salaryLabel)
        
        self.salaryLabel.translatesAutoresizingMaskIntoConstraints = false
        self.salaryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0).isActive = true
        self.salaryLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16.0).isActive = true
        
        self.employerLabel = UILabel()
        self.employerLabel.font = UIKitService.shared.fontBody
        self.employerLabel.numberOfLines = 0
        self.addSubview(self.employerLabel)
        
        self.employerLabel.translatesAutoresizingMaskIntoConstraints = false
        self.employerLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8.0).isActive = true
        self.employerLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor).isActive = true
        self.employerLabel.trailingAnchor.constraint(equalTo: self.salaryLabel.trailingAnchor).isActive = true
        self.employerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16.0).isActive = true
        
        self.titleLabel.trailingAnchor.constraint(equalTo: self.salaryLabel.leadingAnchor, constant: -16.0).isActive = true
        
        self.titleLabel.setContentHuggingPriority(UILayoutPriority(749), for: .horizontal)
        self.salaryLabel.setContentHuggingPriority(UILayoutPriority(750), for: .horizontal)
        
        self.titleLabel.setContentCompressionResistancePriority(UILayoutPriority(250), for: .horizontal)
        self.salaryLabel.setContentCompressionResistancePriority(UILayoutPriority(251), for: .horizontal)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
