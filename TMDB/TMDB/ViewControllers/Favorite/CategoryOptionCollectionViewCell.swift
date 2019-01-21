//
//  CategoryOptionCollectionViewCell.swift
//  TMDB
//
//  Created by Rodrigo Marcelino on 19/01/19.
//  Copyright © 2019 Rodrigo Marcelino. All rights reserved.
//

import Foundation
import UIKit

class CategoryOptionCollectionViewCell: UICollectionViewCell{
    
    //MARK:- Constants
    static let identifier = "categoryOptionCollectionViewCell"
    
    //MARK:- Private variables
    private var viewModel: CategoryOptionViewModel!
    
    //MARK:- View variables
    @IBOutlet weak var nameLabel: UILabel!
    
    //MARK:- Primitive methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setLittleBorderFeatured()
    }
    
    //MARK:- Private methods
    func configure(){
        nameLabel.text = viewModel.name
    }
    
    //MARK:- Public methods
    func setup(viewModel: CategoryOptionViewModel){
        self.viewModel = viewModel
        configure()
    }
}
