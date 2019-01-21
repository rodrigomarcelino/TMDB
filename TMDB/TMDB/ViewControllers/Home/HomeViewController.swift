//
//  HomeViewController.swift
//  TMDB
//
//  Created by Rodrigo Marcelino on 16/01/19.
//  Copyright © 2019 Rodrigo Marcelino. All rights reserved.
//

import UIKit
import Kingfisher

//TODO:- Tratar os erros de viewModelStateChange
class HomeViewController: UIViewController {
    
    //MARK:- Private variables
    private var viewModel: HomeViewModel!
    
    //MARK:- View variables
    @IBOutlet weak var suggestionTable: UITableView!
    @IBOutlet weak var bestMovieView: UIView!
    @IBOutlet weak var bestMovieImage: UIImageView!
    @IBOutlet weak var bestMovieTitleLabel: UILabel!
    @IBOutlet weak var bestMovieVotesAverageLabel: UILabel!
    @IBOutlet weak var bestMovieVotesCountLabel: UILabel!
    @IBOutlet weak var bestMovieYearLabel: UILabel!
    @IBOutlet weak var bestMovieRuntimeLabel: UILabel!
    @IBOutlet weak var bestMovieGenreCollection: UICollectionView!
    @IBOutlet weak var bestMovieGenreCollectionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK:- Primitive methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bestMovieGenreCollection.register(UINib(nibName: GenreCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: GenreCollectionViewCell.identifier)
        
        suggestionTable.delegate = self
        suggestionTable.dataSource = self
        
        bestMovieGenreCollection.delegate = self
        bestMovieGenreCollection.dataSource = self
        
        bestMovieImage.setLittleBorderFeatured()
        bestMovieView.setLittleBorderFeatured()
        
        viewModel = HomeViewModel()
        bindViewModel()
        viewModel.reload()
        activityIndicator.startAnimating()
    }
    
    //MARK:- Private methods
    private func setBestMovie(){
        beginImageDownload(from: viewModel.posterPath)
        
        self.bestMovieYearLabel.text = viewModel.year
        self.bestMovieTitleLabel.text = viewModel.title
        self.bestMovieRuntimeLabel.text = viewModel.runtime
        self.bestMovieVotesCountLabel.text = viewModel.voteCount
        self.bestMovieVotesAverageLabel.text = viewModel.voteAverage
        
        self.bestMovieGenreCollection.reloadData()
        let height = self.bestMovieGenreCollection.collectionViewLayout.collectionViewContentSize.height
        self.bestMovieGenreCollectionHeightConstraint.constant = height
        
        self.suggestionTable.reloadData()
    }
    
    fileprivate func beginImageDownload(from imageUrl: String?) {
        guard let imageUrl = imageUrl, let url = URL(string: imageUrl) else {
            activityIndicator.stopAnimating()
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: imageUrl)
        bestMovieImage.kf.setImage(with: resource, completionHandler: {
            [weak self] (image, error, cacheType, imageUrl) in
            self?.activityIndicator.stopAnimating()
        })
    }
}

//MARK:- SuggestionCellViewModelDelegate methods
extension HomeViewController: SuggestionCellViewModelDelegate {
    func changeToMovieDetail(movieId: Int) {
        if let viewController = UIStoryboard(name: AppConstants.storyBoardName, bundle: nil).instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController {
            viewController.setup(viewModel: DetailViewModel(movieId: movieId))
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
}

//MARK:- MoviewViewController methods
extension HomeViewController: MovieViewController{
    func viewModelStateChange(change: MovieState.Change) {
        switch change {
        case .success:
            self.setBestMovie()
            break
        default:
            break
        }
    }
    
    func bindViewModel() {
        viewModel.onChange = viewModelStateChange
    }
}

//MARK:- Table view methods
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SuggestionTableViewCell.identifier, for: indexPath) as! SuggestionTableViewCell
        
        cell.setup(viewModel: viewModel.getSuggestionCellViewModel(index: indexPath.row, delegate: self))
        
        return cell
    }
}

//MARK:- Collection view methods
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfGenres()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.identifier, for: indexPath) as! GenreCollectionViewCell
        
        cell.setup(viewModel: viewModel.getGenreViewModel(index: indexPath.row))
        
        return cell
    }
}
