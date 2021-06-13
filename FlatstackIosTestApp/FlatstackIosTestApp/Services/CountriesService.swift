//
//  CountriesService.swift
//  FlatstackIosTestApp
//
//  Created by Svetlana Safonova on 12.06.2021.
//

import UIKit

class CountriesService {
    private var nextPageUrl: String?
    
    let queue = DispatchQueue.global(qos: .userInitiated)
    
    func getCountries(isRefreshing: Bool, completion: @escaping (Result<[Country], Error>) -> Void) {
        let semaphore = DispatchSemaphore(value: 0)
        
        if isRefreshing {
            nextPageUrl = nil
        }
        
        if nextPageUrl == nil {
            nextPageUrl = "https://rawgit.com/NikitaAsabin/799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888/page1.json"
        } else if nextPageUrl == "" {
            return
        }
        
        guard let nextPage = nextPageUrl else {
            return
        }
        if let url = URL(string: nextPage) {
            var request = URLRequest(url: url, timeoutInterval: Double.infinity)
            request.httpMethod = "GET"
            
            queue.async {
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data else {
                        print(String(describing: error))
                        semaphore.signal()
                        completion(.failure(error!))
                        return
                    }
                    
                    let decoder = JSONDecoder()
                    
                    if let countries = try? decoder.decode(Countries.self, from: data) {
                        self.nextPageUrl = countries.next
                        completion(.success(countries.countries))
                    }
                    semaphore.signal()
                        
                }
                task.resume()
                semaphore.wait()
            }
        }
    }
}
