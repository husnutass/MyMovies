//
//  DetailViewModel.swift
//  MyMovies
//
//  Created by Hüsnü Taş on 23.01.2022.
//

import Foundation

class DetailViewModel {
    
    let serviceProvider: ServiceProvider
    
    init(serviceProvider: ServiceProvider) {
        self.serviceProvider = serviceProvider
    }
    
    func fetchDetailData(movieID: String, completion: @escaping (Result<DetailResponse?, Error>) -> ()) {
        let url = serviceProvider.getDetailUrl(movieId: movieID)
        ApiService.shared.loadMovie(url: url, completion: completion)
    }
    
}
