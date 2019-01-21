//
//  SearchViewModel.swift
//  TMDB
//
//  Created by Rodrigo Marcelino on 18/01/19.
//  Copyright © 2019 Rodrigo Marcelino. All rights reserved.
//

import Foundation

class SearchViewModel : MovieViewModel, ScrollViewModel{
    
    //MARK:- Private variables
    private var moviePage: MoviePage
    
    //MARK:- Public variables
    var state: MovieState
    var onChange: ((MovieState.Change) -> ())?
    
    var searchQuery: String{
        didSet{
            reload()
        }
    }
    
    //MARK:- Public Methods
    init(){
        searchQuery = ""
        state = MovieState()
        moviePage = MoviePage()
    }
    
    func getSearchCellViewModel(index: Int) -> SearchCellViewModel{
        let cellViewModel = SearchCellViewModel(movie: moviePage.results[index])
        
        return cellViewModel
    }
    
    func getDetailViewModel(index: Int) -> DetailViewModel{
        let movieId = moviePage.results[index].id!
        
        let detailViewModel = DetailViewModel(movieId: movieId)
        
        return detailViewModel
    }
    
    //MARK:- MovieViewModel methods
    func reload(){
        if searchQuery.isEmpty{
            self.moviePage = MoviePage()
            self.onChange!(MovieState.Change.emptyResult)
        }else{
            MovieService.shared().getMoviePageByName(query: searchQuery){ moviePage, reponse, requestError in
                if requestError != nil{
                    self.moviePage = MoviePage()
                    self.onChange!(MovieState.Change.error)
                }else if moviePage.results.isEmpty{
                    self.moviePage = MoviePage()
                    self.onChange!(MovieState.Change.emptyResult)
                }else{
                    self.moviePage = moviePage
                    self.onChange!(MovieState.Change.success)
                }
            }
        }
    }
    
    //MARK:- ScrollViewModel methods
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows() -> Int{
        return moviePage.results.count
    }
}
