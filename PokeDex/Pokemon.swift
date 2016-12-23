//
//  Pokemon.swift
//  PokeDex
//
//  Created by Rwang on 12/23/16.
//  Copyright © 2016 RW. All rights reserved.
//

import Foundation

class Pokemon
{
    
    fileprivate var _name: String!
    fileprivate var _pokeDexID: Int!
    
    var name: String {
        
        return _name
    }
    
    var pokeDexID: Int {
        
        return _pokeDexID
    }
    
    init(name: String, pokeDexID: Int)
    {
        _name = name
        _pokeDexID = pokeDexID
    }
    
    
    
    
}
