//
//  FavoriteCellViewModel.swift
//  TMDB
//
//  Created by Rodrigo Marcelino on 19/01/19.
//  Copyright © 2019 Rodrigo Marcelino. All rights reserved.
//

import Foundation

protocol FavoriteCellViewModelDelegate{
    func removeFavoriteMovie(id: Int)
    func changeToMovieDetail(movieId: Int)
}

class FavoriteCellViewModel: MovieViewModel, BaseDetailViewModel{
    
    //MARK:- Private variables
    private var delegate: FavoriteCellViewModelDelegate!
    private(set) var movie: Movie!
    private(set) var state: MovieState = MovieState()
    var progressBarScore: Float{
        return movie.vote_average != nil ? movie.vote_average! / 10.0 : 0.0
    }
    
    //MARK: Public variables
    var onChange: ((MovieState.Change) -> ())?
    
    //MARK:- Public methods
    init(delegate: FavoriteCellViewModelDelegate, movie: Movie){
        self.delegate = delegate
        self.movie = movie
    }
    
    func gotoDetailScene(){
        if let id = movie.id{
            delegate.changeToMovieDetail(movieId: id)
        }
    }
    
    func removeFromFavorite(){
        if let id = movie.id{
            delegate.removeFavoriteMovie(id: id)
        }
    }
    
    //MARK:- MovieViewModel methods
    func reload() {
        onChange!(MovieState.Change.success)
    }
    
    //MARK:- BaseDetailViewModel methods
    func numberOfGenres() -> Int {
        guard let genres = movie.genres else { return 0 }
        
        return genres.count
    }
    
    func getGenreViewModel(index: Int) -> GenreViewModel {
        let genreViewModel = GenreViewModel(genre: movie.genres![index], style: .pattern)
        
        return genreViewModel
    }
}
