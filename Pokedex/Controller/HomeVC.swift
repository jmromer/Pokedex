//
//  HomeVC.swift
//  Pokedex
//
//  Created by Jake Romer on 3/28/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, UICollectionViewDelegate,
  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  @IBOutlet weak var collectionView: UICollectionView!

  var pokemons = [Pokemon]()

  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.dataSource = self
    collectionView.delegate = self

    let pokemonData = parsePokemonCSV()
    pokemons = Pokemon.create(collectionFrom: pokemonData)
  }

  func parsePokemonCSV() -> [Dictionary<String, String>] {
    do {
      guard let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        else { fatalError("could not find csv in bundle") }
      let csv = try CSV(contentsOfURL: path)
      let rows = csv.rows
      return rows
    } catch let error as NSError {
      print(error)
      return [] //[Dictionary<String, String>]()
    }
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
      return cell.configureCell(pokemon: pokemons[indexPath.row])
    } else {
      return UICollectionViewCell()
    }
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let selectedPokemon = pokemons[indexPath.row]
    print(selectedPokemon)
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return pokemons.count
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 105, height: 105)
  }
}
