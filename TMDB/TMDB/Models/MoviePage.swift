//
//  MoviePage.swift
//  TMDB
//
//  Created by Rodrigo Marcelino on 17/01/19.
//  Copyright © 2019 Rodrigo Marcelino. All rights reserved.
//

import Foundation

struct MoviePage : Codable{
    var page: Int?
    var total_results: Int?
    var total_pages: Int?
    var label: String?
    var results: [Movie]
    
    init() {
        results = [Movie]()
    }
}
