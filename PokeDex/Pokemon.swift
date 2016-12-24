//
//  Pokemon.swift
//  PokeDex
//
//  Created by Rwang on 12/23/16.
//  Copyright © 2016 RW. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon
{
    
    fileprivate var _name: String!
    fileprivate var _pokeDexID: Int!
    private var _description: String!
    private var _baseAttack: String!
    private var _height: String!
    private var _weight: String!
    private var _defense: String!
    private var _pokeType: String!
    private var _nextEvo: String!
    private var _pokemonURL: String!
    
    //private var _currentImage:
    
    
    var name: String {
        
        if _name == nil {
            
            _name = ""
        }
        
        return _name
    }
    
    var pokeDexID: Int {
        
    
        return _pokeDexID
    }
    
    var pokeType: String {
        
        if _pokeType == nil {
            _pokeType = ""
        }
        return _pokeType
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
        
    }
    
    var weight: String {
        
        if _weight == nil {
            _weight = ""
        }
        return _weight
        
    }
    
    var defense: String {
        
        if _defense == nil {
            _defense = ""
        }
        return _defense
        
    }
    
    var attack: String {
        
        if _baseAttack == nil {
            _baseAttack = ""
        }
        return _baseAttack
    }
    
    
    
    init(name: String, pokeDexID: Int)
    {
        self._name = name
        self._pokeDexID = pokeDexID
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokeDexID)/"
        
        
    }
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete){
        
        Alamofire.request(_pokemonURL).responseJSON { response in
           
            
            if let dict = response.result.value as? Dictionary <String, AnyObject>{
                
                if let attack = dict["attack"] as? Int{
                    
                    self._baseAttack = "\(attack)"
                }
                if let defense = dict["defense"] as? Int{
                    
                    self._defense = "\(defense)"
                }
                
                if let height = dict["height"] as? String{
                    
                    self._height = height
                }
                
                if let weight = dict["weight"] as? String{
                    
                    self._weight = weight
                }
                
                if let types = dict["types"] as? [Dictionary <String, String>] {
                    
                    if let type = types[0]["name"] {
                        
                        self._pokeType = type
                    }
                }
                
                print(self._baseAttack)
                print(self._weight)
                print(self._height)
                print(self._pokeType)
                print(self._defense)
                
            }
            
            completed()
            
            }
        
        }
    
}
