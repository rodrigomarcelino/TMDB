//
//  CategoryOptionViewModel.swift
//  TMDB
//
//  Created by Rodrigo Marcelino on 19/01/19.
//  Copyright © 2019 Rodrigo Marcelino. All rights reserved.
//

import Foundation

class CategoryOptionViewModel{
    
    //MARK:- Private variables
    private let category: Category
    
    //MARK:- Public variables
    var name: String{
        return category.name ?? "Genero"
    }
    
    //MARK:- Public methods
    init(category: Category){
        self.category = category
    }
}
