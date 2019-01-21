//
//  SearchCellViewModel.swift
//  TMDB
//
//  Created by Rodrigo Marcelino on 18/01/19.
//  Copyright © 2019 Rodrigo Marcelino. All rights reserved.
//

import Foundation

class SearchCellViewModel{
    //MARK:- Private variables
    private let movie: Movie
    
    //MARK:- Public variables
    var posterPath: String{
        guard let path = movie.poster_path else { return "" }
        
        return AppConstants.BaseImageURL + Quality.low.rawValue + path
    }
    
    //MARK:- Public methods
    init(movie: Movie){
        self.movie = movie
    }
}
