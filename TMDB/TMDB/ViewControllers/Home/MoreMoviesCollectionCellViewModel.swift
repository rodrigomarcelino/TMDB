//
//  MoreMoviesCollectionCellViewModel.swift
//  TMDB
//
//  Created by Rodrigo Marcelino on 17/01/19.
//  Copyright © 2019 Rodrigo Marcelino. All rights reserved.
//

import Foundation

protocol MoreMoviesCollectionViewCellDelegate {
    func searchMoreMovies(completion: @escaping () -> ())
}

class MoreMoviesCollectionCellViewModel: MovieViewModel{
    
    //MARK:- Private variables
    private let delegate: MoreMoviesCollectionViewCellDelegate!
    
    //MARK:- Public variables
    var state: MovieState
    var onChange: ((MovieState.Change) -> ())?
    
    //MARK:- MovieViewModel methods
    func reload() {
        delegate.searchMoreMovies {
            self.onChange!(MovieState.Change.success)
        }
    }
    
    //MARK:- Public methods
    init(delegate: MoreMoviesCollectionViewCellDelegate){
        self.state = MovieState()
        self.delegate = delegate
    }
}
