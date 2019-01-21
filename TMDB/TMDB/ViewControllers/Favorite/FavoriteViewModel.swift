//
//  FavoriteViewModel.swift
//  TMDB
//
//  Created by Rodrigo Marcelino on 19/01/19.
//  Copyright © 2019 Rodrigo Marcelino. All rights reserved.
//

import Foundation

class FavoriteViewModel: MovieViewModel, DataBaseViewModel, ScrollViewModel{
    
    //MARK:- Private variables
    private var allMoviesList: [Movie]!
    private var categoryList: [Category]!
    private(set) var selectedList: [Movie]!
    private(set) var selectedCategoryName: String
    
    //MARK:- Public variables
    var selectedCategoryIndex: Int?{
        didSet{
            reload()
        }
    }
    
    //MARK:- Private methods
    private func setMovieLists(){
        do{
            allMoviesList = try MovieRepository.shared().getAllMovies()
            categoryList = try MovieRepository.shared().getAllCategories()
            
            if(categoryList.count > 0){
                categoryList.sort(by: { $0.name! < $1.name! })
                allMoviesList.sort(by: { $0.title! < $1.title! })
                
                for i in 0...categoryList.count - 1{
                    if categoryList[i].movies != nil{
                        categoryList[i].movies?.sort(by: { $0.title! < $1.title! })
                    }
                }
                
                var allCategory = Category()
                allCategory.id = -1
                allCategory.name = "Todos os filmes"
                allCategory.movies = allMoviesList
                
                categoryList.insert(allCategory, at: 0)
            }
        }catch{
            onChangeDataBase!(MovieState.Change.error)
        }
    }
    
    private func setSelectedList(index: Int){
        if categoryList.count > index{
            selectedCategoryName = categoryList[index].name ?? "Genero"
            selectedList = categoryList[index].movies
            onChange!(MovieState.Change.success)
        }else{
            selectedList = [Movie]()
            selectedCategoryName = "Vazio"
            onChange!(MovieState.Change.emptyResult)
        }
    }
    
    //MARK:- Public methods
    init(onChange: @escaping ((MovieState.Change) -> ()), onChangeDataBase: @escaping ((MovieState.Change) -> ())){
        selectedCategoryName = "Genero"
        self.onChange = onChange
        self.onChangeDataBase = onChangeDataBase
        self.setMovieLists()
    }
    
    func numberOfCategories() -> Int{
        return categoryList.count
    }
    
    func getCategoryOptionViewModel(index: Int) -> CategoryOptionViewModel{
        let categoryOptionViewModel = CategoryOptionViewModel(category: categoryList[index])
        
        return categoryOptionViewModel
    }
    
    func getDetailViewModel(movieId: Int) -> DetailViewModel{
        let detailViewModel = DetailViewModel(movieId: movieId)
        
        return detailViewModel
    }
    
    func getFavoriteCellViewModel(delegate: FavoriteCellViewModelDelegate, index: Int) -> FavoriteCellViewModel{
        return FavoriteCellViewModel(delegate: delegate, movie: selectedList[index])
    }
    
    //MARK:- MovieViewModel methods and variables
    var state: MovieState = MovieState()
    var onChange: ((MovieState.Change) -> ())?
    
    func reload() {
        if selectedCategoryIndex == nil{
            setMovieLists()
            setSelectedList(index: 0)
        }else{
            setSelectedList(index: selectedCategoryIndex!)
        }
    }
    
    //MARK:- DataBaseViewModel methods and variables
    var onChangeDataBase: ((MovieState.Change) -> ())?
    
    func changeDataBase(change: MovieState.Change) {
        switch change {
        case .success:
            selectedCategoryIndex = nil
            break
        default:
            onChangeDataBase!(MovieState.Change.error)
        }
    }
    
    //MARK:- ScrollViewModel methods and variables
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows() -> Int {
        return selectedList.count
    }
    
    func movie(row: Int, section: Int = 1) -> Movie {
        return selectedList[row]
    }
}
