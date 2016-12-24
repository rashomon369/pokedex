//
//  PokemonDetailVC.swift
//  PokeDex
//
//  Created by Rwang on 12/24/16.
//  Copyright © 2016 RW. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       pokemonNameLabel.text = pokemon.name
    }

 

}
