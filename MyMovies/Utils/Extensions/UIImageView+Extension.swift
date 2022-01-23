//
//  UIImageView+Extension.swift
//  MyMovies
//
//  Created by Hüsnü Taş on 23.01.2022.
//

import UIKit
import Kingfisher

extension UIImageView {
    func loadImage(from url: String, _ placeholder: UIImage?) {
        guard let url = URL(string: url) else { return }
        self.kf.setImage(with: url, placeholder: placeholder, options: [.transition(.fade(0.3))], completionHandler: nil)
    }
}
