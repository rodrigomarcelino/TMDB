//
//  MoreMoviesCollectionViewCell.swift
//  TMDB
//
//  Created by Rodrigo Marcelino on 17/01/19.
//  Copyright © 2019 Rodrigo Marcelino. All rights reserved.
//

import Foundation
import UIKit

class MoreMoviesCollectionViewCell: UICollectionViewCell{
    
    //MARK:- Constants
    static let identifier = "moreMoviesCollectionViewCell"
    
    //MARK:- Private variables
    private var viewModel: MoreMoviesCollectionCellViewModel!
    
    //MARK:- View variables
    @IBOutlet weak var searchMoreMoviesButton: UIButton!
    
    //MARK:- View actions
    @IBAction func searchMoreMovies(_ sender: Any) {
        searchMoreMoviesButton.isEnabled = false
        viewModel.reload()
    }
    
    //MARK:- Public methods
    func setup(viewModel: MoreMoviesCollectionCellViewModel){
        self.viewModel = viewModel
        bindViewModel()
    }
}

//MARK:- MoviewViewController methods
extension MoreMoviesCollectionViewCell: MovieViewController{
    func viewModelStateChange(change: MovieState.Change) {
        switch change {
        case .success:
            self.searchMoreMoviesButton.isEnabled = true
            break
        default:
            break
        }
    }
    
    func bindViewModel() {
        viewModel.onChange = viewModelStateChange
    }
}
