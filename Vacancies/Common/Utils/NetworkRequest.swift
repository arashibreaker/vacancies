//
//  NetworkRequest.swift
//  Vacancies
//
//  Created by Ruslan on 22/11/2018.
//  Copyright © 2018 hh-test. All rights reserved.
//

import Foundation

class NetworkRequest {
    private let url: String
    
    init(url: String) {
        self.url = url
    }
    
    func sendRequest(params: [String: String], completion: @escaping (Data?, Error?) -> ()) {
        var components = URLComponents(string: self.url)!
        components.queryItems = params.map({ (key, value) in
            URLQueryItem(name: key, value: value)
        })
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        let request = URLRequest(url: components.url!)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                (200 ..< 300) ~= response.statusCode,
                error == nil else {
                    completion(nil, error)
                    return
            }
            completion(data, nil)
        }
        task.resume()
    }
}
