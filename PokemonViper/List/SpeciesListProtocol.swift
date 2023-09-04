//
//  SpeciesListProtocol.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 08/10/22.
//

import Foundation
import UIKit

protocol SpeciesListViewProtocol {
    var presenter: SpeciesListPresenterProtocol? {get set}
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func setUpTableview()
    func setUpSearchBar()
    func reloadData()
    func emptySpeciesList()
    func showErrorMessage(message: Error)
    
}


protocol SpeciesListPresenterProtocol{
    var view: SpeciesListViewProtocol? { get set }
    var numberOfRows: Int { get }
    func viewDidLoad()
    func insertRecords(_ element: SinglePokemon)
    func getFilteredData(_ searchText: String) 
    func selectSpecies(at index: Int)
    func getPokemonNumber(_ index:Int) -> Int64
    func setPokemonSecondryType(_ index: Int) -> UIImage
    func setPokemonPrimaryType(_ index: Int) -> UIImage
    func getPokemonName(at index: Int) -> String
    func getPokemonImage(at index:Int) -> String
}


protocol SpeciesListRouterProtocol {
    func naviagtionToSpeciesDetail(_ item : PokemonSavedData)
}


protocol SpeciesListInteractorInputProtocol{
    var presenter: SpeciesListInteractorOutputProtocol? {get set}
    func fetchSpecies(_ url: URL)
    func fetchSinglePokemon(_ text: String,_ RequestUrl: String)
    func fetchNumberOfSpecies(_ pokemonList: URL) 
    
    
}



protocol SpeciesListInteractorOutputProtocol{
    func speciesFetchedSuccessfully(model: Pokemon)
    func speciesfetchingFailed(withError error: Error)
    func allPokemonFetchedSuccessFully(data: SinglePokemon)
    func numberOfPokemonSuccesfully(model:Pokemon) 
}
