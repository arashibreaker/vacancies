//
//  StorageService.swift
//  Vacancies
//
//  Created by Ruslan on 22/11/2018.
//  Copyright © 2018 hh-test. All rights reserved.
//

import Foundation
import RealmSwift

protocol StorageService {
    func saveDateTo(dateTo: Date)
    func loadDateTo() -> Date?
    func savePage(page: Int)
    func loadPage() -> Int?
    
    func saveVacancies(vacancies: [Vacancy])
    func loadVacancies() -> [Vacancy]
    
    func clear()
}

class RealmStorageService: StorageService {
    private static let dateKey = "dateTo"
    private static let pageKey = "page"
    
    func saveDateTo(dateTo: Date) {
        UserDefaults.standard.set(dateTo, forKey: RealmStorageService.dateKey)
    }
    
    func loadDateTo() -> Date? {
        return UserDefaults.standard.value(forKey: RealmStorageService.dateKey) as? Date
    }
    
    func savePage(page: Int) {
        UserDefaults.standard.set(page, forKey: RealmStorageService.pageKey)
    }
    
    func loadPage() -> Int? {
        return UserDefaults.standard.value(forKey: RealmStorageService.pageKey) as? Int
    }
    
    private static let schemaVersion: UInt64 = 1
    
    private let queue: DispatchQueue
    private let realmConfig: Realm.Configuration?
    
    init() {
        self.queue = DispatchQueue(label: "com.hh-test.vacancies.realm-storage-service", qos: .background, attributes: [.concurrent])
        
        var configuration = Realm.Configuration(schemaVersion: RealmStorageService.schemaVersion)
        if let folderUrl = configuration.fileURL?.deletingLastPathComponent() {
            let fileUrl = folderUrl.appendingPathComponent("vacancies.realm")
            configuration.fileURL = fileUrl
            self.realmConfig = configuration
        } else {
            self.realmConfig = nil
        }
    }
    
    func saveVacancies(vacancies: [Vacancy]) {
        if vacancies.count <= 0 {
            return
        }
        guard let realmConfig = self.realmConfig else {
            return
        }
        self.queue.async(flags: [.barrier]) {
            do {
                let realm = try Realm(configuration: realmConfig)
                let vacancyObjects = vacancies.map({VacancyObject(vacancy: $0)})
                try realm.write {
                    realm.add(vacancyObjects, update: true)
                }
            } catch {
                
            }
        }
    }
    
    func loadVacancies() -> [Vacancy] {
        guard let realmConfig = self.realmConfig else {
            return []
        }
        do {
            let realm = try Realm(configuration: realmConfig)
            
            var vacanciesObjects: [VacancyObject] = []
            let vacanciesResults = realm.objects(VacancyObject.self)
            for v in vacanciesResults {
                vacanciesObjects.append(v)
            }
            
            let vacancies = vacanciesObjects.map({Vacancy(vacancyObject: $0)})
            return vacancies
        } catch {
            return []
        }
    }
    
    func clear() {
        UserDefaults.standard.removeObject(forKey: RealmStorageService.dateKey)
        UserDefaults.standard.removeObject(forKey: RealmStorageService.pageKey)
        guard let realmConfig = self.realmConfig else {
            return
        }
        self.queue.sync(flags: [.barrier]) {
            do {
                let realm = try Realm(configuration: realmConfig)
                try realm.write {
                    realm.deleteAll()
                }
            } catch {
                
            }
        }
    }
}
