//
//  File.swift
//  Pokedex3
//
//  Created by Kanishk Verma on 05/08/17.
//  Copyright © 2017 Kanishk Verma. All rights reserved.
//

import Foundation

class Pokemon {
    private var _name: String!
    private var _pokemonId: Int!
    
    var name : String {
        return _name
    }
    var pokemonId: Int {
        return _pokemonId
    }
    init(name:String, pokemonId:Int  ) {
        self._name = name
        self._pokemonId = pokemonId
        
    }
}
