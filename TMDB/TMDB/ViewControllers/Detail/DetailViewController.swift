//
//  DetailViewController.swift
//  TMDB
//
//  Created by Rodrigo Marcelino on 17/01/19.
//  Copyright © 2019 Rodrigo Marcelino. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

//TODO:- Tratar os erros de viewModelStateChange e viewModelDataBaseChange
class DetailViewController : UIViewController{
    
    //MARK:- Constants
    static let identifier = "NewDetailView"
    
    //MARK:- Private variables
    private var viewModel: DetailViewModel!
    
    //MARK:- View variables
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var votesCountLabel: UILabel!
    @IBOutlet weak var votesAverageLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var genreCollection: UICollectionView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var genreCollectionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var posterView: UIView!
    @IBOutlet weak var overviewView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK:- View actions
    @IBAction func favoriteMovie(_ sender: Any) {
        viewModel.saveMovieOrRemoveFavorite()
    }
    
    //MARK:- Primitive functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genreCollection.register(UINib(nibName: GenreCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: GenreCollectionViewCell.identifier)
        
        genreCollection.delegate = self
        genreCollection.dataSource = self
        
        titleLabel.setLittleBorderFeatured()
        favoriteButton.setBorderFeatured()
        overviewView.setLittleBorderFeatured()
        titleLabel.setCornerRadius()
        
        activityIndicator.startAnimating()
        bindViewModel()
        viewModel.reload()
    }
    
    //MARK:- Private Functions
    private func setButtonState(){
        if (viewModel.movie?.favorite)!{
            self.favoriteButton.backgroundColor = AppConstants.colorSecondary
            self.favoriteButton.setTitle(NSLocalizedString("Remove", comment: ""), for: UIControl.State.normal)
            self.favoriteButton.setTitleColor(AppConstants.colorFeatured, for: UIControl.State.normal)
        }else{
            self.favoriteButton.backgroundColor = AppConstants.colorFeatured
            self.favoriteButton.setTitle(NSLocalizedString("Favorite", comment: ""), for: UIControl.State.normal)
            self.favoriteButton.setTitleColor(AppConstants.colorSecondary, for: UIControl.State.normal)
        }
    }
    
    private func setFields(){
        
        beginImageDownload(from: viewModel.posterPath)
        
        yearLabel.text = viewModel.year
        titleLabel.text = viewModel.title
        runtimeLabel.text = viewModel.runtime
        overviewLabel.text = viewModel.overview
        votesCountLabel.text = viewModel.voteCount
        votesAverageLabel.text = viewModel.voteAverage
        
        genreCollection.reloadData()
        
        let height = genreCollection.collectionViewLayout.collectionViewContentSize.height
        genreCollectionHeightConstraint.constant = height
        
        setButtonState()
    }
    
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
    
    //MARK:- Public functions
    public func setup(viewModel: DetailViewModel){
        self.viewModel = viewModel
    }
}

//MARK:- MovieViewController methods
extension DetailViewController: MovieViewController{
    func bindViewModel(){
        viewModel.onChange = viewModelStateChange
        viewModel.onChangeDataBase = viewModelDataBaseChange
    }
    
    func viewModelStateChange(change: MovieState.Change) {
        switch change {
        case .success:
            setFields()
            break
        case .error:
            break
        case .emptyResult:
            break
        }
    }
}

//MARK:- DataBaseViewController methods
extension DetailViewController: DataBaseViewController{
    func viewModelDataBaseChange(change: MovieState.Change) {
        switch change {
        case .success:
            setButtonState()
            break
        case .error:
            break
        case .emptyResult:
            break
        }
    }
}

//MARK:- Collection View Methods
extension DetailViewController :  UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfGenres()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.identifier, for: indexPath) as! GenreCollectionViewCell
        
        cell.setup(viewModel: viewModel.getGenreViewModel(index: indexPath.row))
        
        return cell
    }
}
