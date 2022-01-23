//
//  ServiceProvider.swift
//  MyMovies
//
//  Created by Hüsnü Taş on 23.01.2022.
//

import Foundation

class ServiceProvider {
    
    private let baseUrl = "https://www.omdbapi.com/?"
    private let apiKey = "apikey=827a5a2d"
    
    func getSearchUrl(searchParam: String?) -> URL {
        return URL(string: baseUrl + apiKey + QueryParam.search.rawValue + (searchParam ?? "Batman"))!
    }
    
    func getDetailUrl(movieId: String) -> URL {
        return URL(string: baseUrl + apiKey + QueryParam.id.rawValue + movieId)!
    }
    
}

enum QueryParam: String {
    case search = "&s="
    case id = "&i="
}
