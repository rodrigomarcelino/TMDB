//
//  DetailViewModel.swift
//  TMDB
//
//  Created by Rodrigo Marcelino on 17/01/19.
//  Copyright © 2019 Rodrigo Marcelino. All rights reserved.
//

import Foundation

class DetailViewModel: MovieViewModel, DataBaseViewModel, BaseDetailViewModel{
    
    //MARK:- Private variables
    private(set) var movie: Movie!
    
    //MARK:- Public variables
    var state: MovieState
    var onChange: ((MovieState.Change) -> ())?
    private let movieId: Int
    
    //MARK:- Public methods
    init(movieId: Int){
        state = MovieState()
        movie = Movie()
        
        self.movieId = movieId
    }
    
    func saveMovieOrRemoveFavorite(){
        if(movie.favorite!){
            self.movie.favorite = false
            self.remove(movieId: movieId)
        }else{
            self.movie.favorite = true
            save(movie: movie)
        }
    }
    
    //MARK:- BaseDetailViewModel
    func numberOfGenres() -> Int {
        guard let genres = movie.genres else { return 0 }
        
        return genres.count
    }
    
    func getGenreViewModel(index: Int) -> GenreViewModel {
        let genreViewModel = GenreViewModel(genre: movie.genres![index], style: .secondary)
        
        return genreViewModel
    }
    
    //MARK:- MovieViewModel methods
    func reload() {
        do{
            movie = try MovieRepository.shared().getMovie(by: movieId)
            movie?.favorite = true
            
            onChange!(MovieState.Change.success)
        }catch{
            MovieService.shared().getMovieDetail(id: movieId){ movie, response, requestError in
                if requestError != nil{
                    self.onChange!(MovieState.Change.error)
                }else{
                    self.movie = movie
                    self.movie?.favorite = false
                    
                    self.onChange!(MovieState.Change.success)
                }
            }
        }
    }
    
    //MARK:- DataBaseViewModel methods and variables
    var onChangeDataBase: ((MovieState.Change) -> ())?
    
    func changeDataBase(change: MovieState.Change) {
        onChangeDataBase!(change)
    }
}
