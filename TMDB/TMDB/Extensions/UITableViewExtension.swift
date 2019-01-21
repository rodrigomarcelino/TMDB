//
//  UITableViewExtension.swift
//  TMDB
//
//  Created by Rodrigo Marcelino on 19/01/19.
//  Copyright © 2019 Rodrigo Marcelino. All rights reserved.
//

import Foundation
import UIKit

extension UITableView{
    func showEmptyCell(string: String){
        let emptyCell: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
        emptyCell.text = string
        emptyCell.textColor = UIColor(named: "TextPattern")
        emptyCell.textAlignment = .center
        backgroundView  = emptyCell
        separatorStyle = .none
    }
    
    func hideEmptyCell(){
        backgroundView = nil
    }
}
