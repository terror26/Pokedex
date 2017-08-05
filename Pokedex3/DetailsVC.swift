//
//  Detailviewcontroller.swift
//  Pokedex3
//
//  Created by Kanishk Verma on 05/08/17.
//  Copyright © 2017 Kanishk Verma. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {

    
    
    @IBOutlet weak var pokemonnameLBL:UILabel!
    var pokemon:Pokemon!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonnameLBL.text = pokemon.name

    }
    
}
