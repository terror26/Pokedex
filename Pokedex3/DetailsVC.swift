//
//  Detailviewcontroller.swift
//  Pokedex3
//
//  Created by Kanishk Verma on 05/08/17.
//  Copyright © 2017 Kanishk Verma. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {
    
    var pokemon:Pokemon!
    
    @IBOutlet weak var pokemonnameLBL:UILabel!
    @IBOutlet weak var DescriptionLbl: UILabel!
    @IBOutlet weak var TypeLbl: UILabel!
    @IBOutlet weak var PokemonMainImg: UIImageView!
    @IBOutlet weak var HeightLbl: UILabel!
    @IBOutlet weak var DefenseLbl: UILabel!
    @IBOutlet weak var WeightLbl: UILabel!
    @IBOutlet weak var AttackLbl: UILabel!
    @IBOutlet weak var PokedexIdLbl: UILabel!
    @IBOutlet weak var EvolutionLbl: UILabel!
    @IBOutlet weak var currentEvoLevel: UIImageView!
    @IBOutlet weak var nextEvoLevel: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonnameLBL.text = pokemon.name
        currentEvoLevel.image = UIImage(named: "\(pokemon.pokemonId)")
        PokemonMainImg.image = currentEvoLevel.image
        PokedexIdLbl.text = "\(pokemon.pokemonId)"
        
        pokemon.downloadPokemonDetails {
            //download the data
            print("ram ram")
            self.UpdateUI()

        }
    }
    func UpdateUI() {
        DefenseLbl.text = pokemon.defense
        WeightLbl.text = pokemon.weight
        AttackLbl.text = pokemon.attack
        HeightLbl.text = pokemon.height
        TypeLbl.text = pokemon.type
        DescriptionLbl.text = pokemon.description
        
        if pokemon.nextEvoId == "" {
            nextEvoLevel.isHidden = true
            EvolutionLbl.text = ""
        } else {
            nextEvoLevel.isHidden = false
            nextEvoLevel.image = UIImage(named: "\(pokemon.nextEvoId)")
            let str = "Next Evolution : \(pokemon.nextevolutionname) -LVL \(pokemon.nextEvolutionLevel)"
            EvolutionLbl.text = str
        }
        

    }
    

    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
