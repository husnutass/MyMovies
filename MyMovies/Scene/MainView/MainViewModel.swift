//
//  MainViewModel.swift
//  MyMovies
//
//  Created by Hüsnü Taş on 23.01.2022.
//

import Foundation

class MainViewModel {
    
    private let serviceProvider: ServiceProvider
    
    init(serviceProvider: ServiceProvider) {
        self.serviceProvider = serviceProvider
    }
    
    func fetchSearchData(searchParam: String?, completion: @escaping (Result<SearchResponse?, Error>) -> ()) {
        let url = serviceProvider.getSearchUrl(searchParam: searchParam)
        ApiService.shared.loadMovie(url: url, completion: completion)
    }
    
}
