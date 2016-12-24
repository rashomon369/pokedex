//
//  PokemonDetailVC.swift
//  PokeDex
//
//  Created by Rwang on 12/24/16.
//  Copyright © 2016 RW. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var pokeDescription: UILabel!
    @IBOutlet weak var pokeType: UILabel!
    @IBOutlet weak var defenseLBL: UILabel!
    @IBOutlet weak var heightLBL: UILabel!
    @IBOutlet weak var weightLBL: UILabel!
    @IBOutlet weak var baseAttackLBL: UILabel!
    @IBOutlet weak var pokedexIDLBL: UILabel!
    @IBOutlet weak var nextEVOLBL: UILabel!
    @IBOutlet weak var currentEVOImage: UIImageView!
    @IBOutlet weak var nextEVOImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        pokemon.downloadPokemonDetails {
            //whatever is run is comes after the network call is complete 
            
            self.updateUI()
            
        }
    }

    
 
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
   
    
    func updateUI(){
        
       nameLBL.text = pokemon.name.capitalized
        pokeType.text = pokemon.pokeType.capitalized
        baseAttackLBL.text = pokemon.attack
        defenseLBL.text = pokemon.defense
        weightLBL.text = pokemon.weight
        heightLBL.text = pokemon.height
        pokedexIDLBL.text = "\(pokemon.pokeDexID)"
        pokeImage.image = UIImage(named: "\(pokemon.pokeDexID)")
        currentEVOImage.image = UIImage(named: "\(pokemon.pokeDexID)")
        
        
    }

}
