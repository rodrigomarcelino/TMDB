//
//  Category.swift
//  TMDB
//
//  Created by Rodrigo Marcelino on 17/01/19.
//  Copyright © 2019 Rodrigo Marcelino. All rights reserved.
//

import Foundation

struct Category : Codable{
    var id: Int?
    var name: String?
    var movies: [Movie]?
}
