//
//  GenreCollectionViewCell.swift
//  TMDB
//
//  Created by Rodrigo Marcelino on 19/01/19.
//  Copyright © 2019 Rodrigo Marcelino. All rights reserved.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    
    //MARK- Constants
    static let identifier = "genreCollectionViewCell"
    static let className = "GenreCollectionViewCell"
    
    //MARK:- Private variables
    private var viewModel: GenreViewModel!
    
    //MARK:- View variables
    @IBOutlet weak var nameLabel: UILabel!
    
    //MARK:- Primitive methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setLittleBorderFeatured()
        setCornerRadius()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = ""
    }
    
    //MARK:- Private Methods
    private func configure(){
        nameLabel.text = viewModel.name
        nameLabel.textColor = viewModel.textColor
        nameLabel.backgroundColor = viewModel.backGroundColor
    }
    
    //MARK:- Public methods
    func setup(viewModel: GenreViewModel){
        self.viewModel = viewModel
        configure()
    }
}
