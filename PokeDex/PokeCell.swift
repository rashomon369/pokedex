//
//  PokeCell.swift
//  PokeDex
//
//  Created by Rwang on 12/23/16.
//  Copyright © 2016 RW. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImage : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    
    var pokemon: Pokemon!
    
    
    //rounded corners for cells
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
            layer.cornerRadius = 5.0
    }
    
    
    func configCell (_ pokemon: Pokemon)
    {
        self.pokemon = pokemon
        nameLabel.text = self.pokemon.name.capitalized
        thumbImage.image = UIImage(named: "\(self.pokemon.pokeDexID)")
    }
    
    
    
    
    
}
