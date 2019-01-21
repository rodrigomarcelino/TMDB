//
//  MovieViewController.swift
//  TMDB
//
//  Created by Rodrigo Marcelino on 19/01/19.
//  Copyright © 2019 Rodrigo Marcelino. All rights reserved.
//

import Foundation

protocol MovieViewController{
    func viewModelStateChange(change: MovieState.Change)
    func bindViewModel()
}

protocol DataBaseViewController{
    func viewModelDataBaseChange(change: MovieState.Change)
}
