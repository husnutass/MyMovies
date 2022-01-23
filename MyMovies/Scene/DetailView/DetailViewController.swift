//
//  DetailViewController.swift
//  MyMovies
//
//  Created by Hüsnü Taş on 23.01.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var movieName: UILabel!
    
    @IBOutlet weak var movieYear: UILabel!
    
    @IBOutlet weak var movieActors: UILabel!
    
    @IBOutlet weak var movieCountry: UILabel!
    
    @IBOutlet weak var movieDirector: UILabel!
    
    @IBOutlet weak var movieIMDB: UILabel!
    
    var selectedID: String!
    
    private var viewModel: DetailViewModel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = DetailViewModel(serviceProvider: ServiceProvider())
        getMovieData()
    }
    
    private func getMovieData() {
        viewModel.fetchDetailData(movieID: selectedID, completion: detailHandler)
    }
    
    lazy var detailHandler: (Result<DetailResponse?, Error>) -> () = { [weak self] result in
        DispatchQueue.main.async {
            switch result {
            case .success(let data):
                guard let data = data else { return }
                self?.setUIData(data:data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setUIData(data: DetailResponse) {
        movieImage.loadImage(from: data.poster, UIImage(named: "movie"))
        movieYear.text = data.year
        movieName.text = data.title
        movieIMDB.text = data.imdbRating
        movieActors.text = data.actors
        movieCountry.text = data.country
        movieDirector.text = data.director
    }
}
