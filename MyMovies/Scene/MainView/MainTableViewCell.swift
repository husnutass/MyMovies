//
//  MainTableViewCell.swift
//  MyMovies
//
//  Created by Hüsnü Taş on 23.01.2022.
//

import UIKit

class MainTableViewCell: UITableViewCell {

   
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var movieName: UILabel!
    
    
    @IBOutlet weak var movieYear: UILabel!
    
    func setup(search: Search) {
        movieName.text = search.title
        movieYear.text = search.year
        movieImage.loadImage(from: search.poster, UIImage(named: "movie"))
    }
    
    

}
