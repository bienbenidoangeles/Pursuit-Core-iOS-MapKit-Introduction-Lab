//
//  SchoolsAPIClient.swift
//  Pursuit-Core-iOS-MapKit-Introduction-Lab
//
//  Created by Bienbenido Angeles on 2/25/20.
//  Copyright © 2020 Bienbenido Angeles. All rights reserved.
//

import Foundation
import NetworkHelper

class NYCDataAPIClient {
    static func getSchools(completion: @escaping (Result<[School], AppError>)->()){
        let endPointUrlString = "https://data.cityofnewyork.us/resource/uq7m-95z8.json"
        
        guard let url = URL(string: endPointUrlString) else {
            completion(.failure(.badURL(endPointUrlString)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result{
            case .failure(let error):
                completion(.failure(.networkClientError(error)))
            case .success(let data):
                do {
                    let school = try JSONDecoder().decode([School].self, from: data)
                    completion(.success(school))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
