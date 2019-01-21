//
//  SuggestionCollectionCellViewModel.swift
//  TMDB
//
//  Created by Rodrigo Marcelino on 16/01/19.
//  Copyright © 2019 Rodrigo Marcelino. All rights reserved.
//

import Foundation

class SuggestionCollectionCellViewModel{
    
    //MARK:- Private variables
    private let movie: Movie!
    
    //MARK:- Public variables
    var posterPath: String{
        return AppConstants.BaseImageURL + Quality.low.rawValue + "/" + (movie.poster_path ?? "")
    }
    
    //MARK:- Public methods
    init(movie: Movie){
        self.movie = movie
    }
}
