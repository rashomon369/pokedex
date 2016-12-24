//
//  ViewController.swift
//  PokeDex
//
//  Created by Rwang on 12/23/16.
//  Copyright © 2016 RW. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var musicPlayer: AVAudioPlayer!
    var pokemons = [Pokemon]()
    var filteredPokemons = [Pokemon]()
    var searching = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        collection.delegate = self
        collection.dataSource = self
        searchBar.returnKeyType = .done
        parsePokemonCSV()
        initAudio()
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == ""
        {
            searching = false
            collection.reloadData()
            view.endEditing(true)
        }
        else {
            
            searching = true
            let input = searchBar.text!.lowercased()
            filteredPokemons = pokemons.filter({($0.name.range(of: input ) != nil)})
            collection.reloadData()
        }
        
    }
    
    
    func initAudio(){
        
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        }
        catch let err as NSError
        {
            print(err.debugDescription)
        }
    }
    
    
    func parsePokemonCSV(){
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                let pokeID = Int(row["id"]!)!
                let name = String(row["identifier"]!)!
                
                let pokemon = Pokemon(name: name, pokeDexID: pokeID)
                pokemons.append(pokemon)
                
            }
            
            
        }catch let err as NSError {
            
            print(err.debugDescription)
            
        }
        
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell
        {
            //let pokemon = Pokemon(name: "pokemon", pokeDexID: indexPath.row)
            
            let poke: Pokemon!
            
            if searching {
                
                poke = filteredPokemons[indexPath.row]
                cell.configCell(poke)
                
            }
            else {
                
                poke = pokemons[indexPath.row]
                cell.configCell(poke)
                
            }
            
            
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if searching {
            
            return filteredPokemons.count
        }
        else {
            
            return pokemons.count
            
        }
    }
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    
    @IBAction func musicButtonPressed(_ sender: UIButton) {
        
        if musicPlayer.isPlaying {
            
            musicPlayer.pause()
            sender.alpha = 0.2
        }
        else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
        
    }
}

