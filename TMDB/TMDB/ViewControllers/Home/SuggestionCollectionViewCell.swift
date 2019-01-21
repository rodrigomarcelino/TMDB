//
//  SuggestionCollectionViewCell.swift
//  TMDB
//
//  Created by Rodrigo Marcelino on 16/01/19.
//  Copyright © 2019 Rodrigo Marcelino. All rights reserved.
//

import UIKit
import Kingfisher

class SuggestionCollectionViewCell: UICollectionViewCell{
    
    //MARK:- Constants
    static let identifier = "suggestionMovieCollectionViewCell"
    
    //MARK:- Private variables
    private var viewModel: SuggestionCollectionCellViewModel!
    
    //MARK:- View variables
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK:- Private methods
    fileprivate func beginImageDownload(from imageUrl: String?) {
        guard let imageUrl = imageUrl, let url = URL(string: imageUrl) else {
            posterImageView.image = UIImage(named: AppConstants.placeHolder)
            activityIndicator.stopAnimating()
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: imageUrl)
        posterImageView.kf.setImage(with: resource, completionHandler: {
            [weak self] (image, error, cacheType, imageUrl) in
            self?.activityIndicator.stopAnimating()
        })
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        activityIndicator.startAnimating()
    }
    
    //MARK:- Public methods
    func setup(viewModel: SuggestionCollectionCellViewModel){
        self.viewModel = viewModel
        beginImageDownload(from: viewModel.posterPath)
    }
}
