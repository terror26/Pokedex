//
//  ViewController.swift
//  Pokedex3
//
//  Created by Kanishk Verma on 04/08/17.
//  Copyright © 2017 Kanishk Verma. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UISearchBarDelegate {
    
   
    @IBOutlet weak var collection :UICollectionView!
    @IBOutlet weak var SearchBar: UISearchBar!
    
    var insearchmode = false
    var pokemon = [Pokemon]()
    var musicPlayer:AVAudioPlayer!
    var filteredPokemon = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.dataSource = self
        collection.delegate = self
        SearchBar.delegate = self
        
        SearchBar.returnKeyType = UIReturnKeyType.done
        parsePokemonCSv()
        initaudio()

    }
    func initaudio() {
        let audio = Bundle.main.path(forResource: "pokemon", ofType: "mp3")!
        do {
            musicPlayer = try AVAudioPlayer( contentsOf: URL(string: audio)! )
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        } catch let err as NSError {
            print(err.description)
        }
        
    }
    
    func parsePokemonCSv() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        do {
            let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows
            print(rows)
            for row in rows {
                
                let name = row["identifier"]!
                let pokeId = Int(row["id"]!)!
                let poke = Pokemon(name: name, pokemonId: pokeId)
                pokemon.append(poke)
            }
            
        } catch _ as NSError {
            print(NSError.description())
        }
    }
    
    
    // perform the segue
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var poke: Pokemon!
        if insearchmode {
            poke = filteredPokemon[indexPath.row]
        } else {
            poke = pokemon[indexPath.row]
        }
        performSegue(withIdentifier: "DetailsVC", sender: poke)
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if insearchmode {
            return filteredPokemon.count
        } else {
            return pokemon.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as?PokeCell {
            
            let poke:Pokemon!
            
            if insearchmode {
                poke = filteredPokemon[indexPath.row]
                cell.ConfigureCell(poke)
            } else {
                poke = pokemon[indexPath.row]
                cell.ConfigureCell(poke)
            }
            return cell
        
        }
        else {
            return UICollectionViewCell()
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 108, height: 108)
    }
    
    
    @IBAction func music(_ sender: UIButton) {
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha  = 0.2
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            insearchmode = false
            collection.reloadData()
            view.endEditing(true)
        } else {
            insearchmode = true
            let lower = searchBar.text!.lowercased()
            filteredPokemon = pokemon.filter( { $0.name.range(of: lower) != nil })
            collection.reloadData()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsVC" {
            if let DetailsVC = segue.destination as?DetailsVC {
                if let poke = sender as?Pokemon {
                    DetailsVC.pokemon = poke
                }
            }
        }
    }
    
    
}

