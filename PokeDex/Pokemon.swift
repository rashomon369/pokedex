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
    private var _evoName: String!
    private var _evoLVL: String!
    private var _evoNum: String!
    
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
    
    var evoNum: String {
        
        if _evoNum == nil {
            _evoNum = ""
        }
        
        return _evoNum
    }
    
    var evoName: String {
        
        if _evoName == nil {
            _evoName = ""
        }
        return _evoName
    }
    
    var evoLVL: String {
        
        if _evoLVL == nil {
            _evoLVL = ""
        }
        return _evoLVL
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
    
    var description: String {
        
        if _description == nil {
            _description = ""
        }
        return _description
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
                
                if let evolution = dict["evolutions"] as? [Dictionary <String, AnyObject>]{
                    
                    if !evolution.isEmpty {
                        
                    if let evoName = evolution[0]["to"] as? String {
                        
                        self._evoName = evoName
                       
                    }
                    else {
                        self._evoName = ""
                    }
                 
                    if let evoLVL = evolution[0]["level"] as? Int {
                        
                        self._evoLVL = "\(evoLVL)"
                        
                    }
                    else {
                        self._evoLVL = ""
                    }
                        
                    }

 
                }
                
                
                if let descriptions = dict["descriptions"] as? [Dictionary<String, AnyObject>]{
                    
                    if let RESOURCE_URL = descriptions[0]["resource_uri"]
                    {
                        let DESCRIPTIONS_URL = "\(URL_BASE)\(RESOURCE_URL)"
                        
                        let evoNum = RESOURCE_URL.components(separatedBy: "/")
                        
                            self._evoNum = evoNum[evoNum.endIndex-2]
                        
                        Alamofire.request(DESCRIPTIONS_URL).responseJSON { response in
                            
                            if let innerAPI = response.result.value as? Dictionary <String, AnyObject> {
                                
                                if let description = innerAPI["description"] as? String {
                                    
                                    self._description = description
                                }
                            }
                            completed()
                        }
                }
                
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
                
                if let types = dict["types"] as? [Dictionary <String, String>] , types.count > 0{
                    
                
                    if let type = types[0]["name"] {
                        
                        self._pokeType = type
                    }
                    
                    if types.count > 1 {
                        
                        for x in 1..<types.count {
                            
                            if let name = types[x]["name"]{
                                
                                self._pokeType! += "/\(name.capitalized)"
                                
                            }
                        }
                        
                    }
                    
                }
          
                
            }
            
            completed()
            
            }
        
        }
    }
}
