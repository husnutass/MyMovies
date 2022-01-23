//
//  ApiService.swift
//  MyMovies
//
//  Created by Hüsnü Taş on 23.01.2022.
//

import Foundation


class ApiService {
    
    static let shared = ApiService()
    
    private init() {}
    
    func loadMovie<R: Decodable>(url: URL, completion: @escaping (Result<R?, Error>) -> ())  {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data , error == nil else {
                completion(.failure(error!))
                return
            }
            do {
                let jsonData = try JSONDecoder().decode(R.self, from: data)
                completion(.success(jsonData))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}
