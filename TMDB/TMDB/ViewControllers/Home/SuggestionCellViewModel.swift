//
//  SuggestionCellViewModel.swift
//  TMDB
//
//  Created by Rodrigo Marcelino on 16/01/19.
//  Copyright © 2019 Rodrigo Marcelino. All rights reserved.
//

import Foundation

protocol SuggestionCellViewModelDelegate{
    func changeToMovieDetail(movieId: Int)
}

class SuggestionCellViewModel: MovieViewModel, ScrollViewModel{
    
    //MARK:- Private variables
    private var delegate: SuggestionCellViewModelDelegate
    private(set) var moviePage: MoviePage
    private var getPosterTasks: [URLSessionDataTask]?
    private var page = 2
    private var sort: Sort
    private(set) var canSearchMore: Bool
    
    //MARK:- Public methods
    init(moviePage: MoviePage, delegate: SuggestionCellViewModelDelegate, canSearchMore: Bool, sort: Sort = Sort.popularity){
        self.delegate = delegate
        self.canSearchMore = canSearchMore
        self.sort = sort
        self.moviePage = moviePage
        self.state = MovieState()
    }
    
    func gotoMovieDetail(index: Int){
        if moviePage.results.count > index{
            delegate.changeToMovieDetail(movieId: moviePage.results[index].id!)
        }
    }
    
    func getSuggestionCollectionCellViewModel(index: Int) -> SuggestionCollectionCellViewModel{
        return SuggestionCollectionCellViewModel(movie: moviePage.results[index])
    }
    
    func getMoreMoviesCollectionCellViewModel(delegate: MoreMoviesCollectionViewCellDelegate) -> MoreMoviesCollectionCellViewModel{
        return MoreMoviesCollectionCellViewModel(delegate: delegate)
    }
    
    func isThisTheMoreMoviesCellTime(index: Int) -> Bool{
        if canSearchMore, index == numberOfRows() - 1{
            return true
        }else{
            return false
        }
    }
    
    //MARK:- MovieViewModel
    var state: MovieState
    
    var onChange: ((MovieState.Change) -> ())?
    
    func reload() {
        onChange!(MovieState.Change.success)
    }
    
    func searchMoreMovies(completion: @escaping () -> ()){
        MovieService.shared().getMoviePage(page: page, sort: sort, order: Order.descending){ newMoviePage, response, error in
            
            self.moviePage.results.append(contentsOf: newMoviePage.results)
            
            self.page += 1
            
            self.onChange!(MovieState.Change.success)
            
            completion()
        }
        
    }
    
    //MARK:- ScrollViewModel
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows() -> Int {
        if canSearchMore{
            return moviePage.results.count + 1
        }
        
        return moviePage.results.count
    }
    
    func movie(row: Int, section: Int = 1) -> Movie {
        return moviePage.results[row]
    }
}
