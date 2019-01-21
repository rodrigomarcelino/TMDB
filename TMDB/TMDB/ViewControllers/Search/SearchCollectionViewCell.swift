//
//  SearchCollectionViewCell.swift
//  TMDB
//
//  Created by Rodrigo Marcelino on 18/01/19.
//  Copyright © 2019 Rodrigo Marcelino. All rights reserved.
//

import UIKit
import Kingfisher

class SearchCollectionViewCell : UICollectionViewCell{
    
    //MARK:- Constants
    static let identifier: String = "searchCollectionViewCell"
    
    //MARK:- Private variables
    private var viewModel: SearchCellViewModel!
    
    //MARK:- View variables
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    fileprivate func beginImageDownload(from imageUrl: String?) {
        guard let imageUrl = imageUrl, let url = URL(string: imageUrl) else {
            activityIndicator.stopAnimating()
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: imageUrl)
        posterImage.kf.setImage(with: resource, completionHandler: {
            [weak self] (image, error, cacheType, imageUrl) in
            self?.activityIndicator.stopAnimating()
        })
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImage.image = nil
        activityIndicator.startAnimating()
    }
    
    //MARK:- Public functions
    func setup(viewModel: SearchCellViewModel){
        self.viewModel = viewModel
        posterImage.setLittleBorderFeatured()
        beginImageDownload(from: viewModel.posterPath)
    }
}
