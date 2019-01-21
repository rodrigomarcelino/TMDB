//
//  GenreViewModel.swift
//  TMDB
//
//  Created by Rodrigo Marcelino on 19/01/19.
//  Copyright © 2019 Rodrigo Marcelino. All rights reserved.
//

import UIKit

enum GenreStyle: Int{
    case pattern = 1
    case secondary = 2
}

class GenreViewModel{
    
    //MARK:- Private variables
    private let genre: Genre
    private let style: GenreStyle
    
    //MARK:- Public variables
    var name: String{
        return genre.name ?? "Genero"
    }
    
    var textColor: UIColor{
        switch style {
        case GenreStyle.pattern:
            return AppConstants.textColorPattern
        case GenreStyle.secondary:
            return AppConstants.textColorPattern
        }
    }
    
    var backGroundColor: UIColor{
        switch style {
        case GenreStyle.pattern:
            return AppConstants.colorPattern
        case GenreStyle.secondary:
            return AppConstants.colorSecondary
        }
    }
    
    //MARK:- Public methods
    init(genre: Genre, style : GenreStyle){
        self.genre = genre
        self.style = style
    }
}

