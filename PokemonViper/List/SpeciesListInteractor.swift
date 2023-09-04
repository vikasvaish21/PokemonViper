//
//  SpeciesListInteractor.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 08/10/22.
//

import Foundation
class SpeciesListInteractor: SpeciesListInteractorInputProtocol{
    var presenter: SpeciesListInteractorOutputProtocol?
    
    func fetchNumberOfSpecies(_ pokemonList: URL) {
        APIClient.fetchPokemon(pokemonList , expecting: Pokemon.self) { [weak self] result in
            switch result{
            case .success(let data):
                DispatchQueue.main.async {
                    self?.presenter?.numberOfPokemonSuccesfully(model: data)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchSpecies(_ pokemonList: URL) {
        APIClient.fetchPokemon(pokemonList , expecting: Pokemon.self) { [weak self] result in
            switch result{
            case .success(let data):
                DispatchQueue.main.async {
                    self?.presenter?.speciesFetchedSuccessfully(model: data)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    func fetchSinglePokemon(_ text: String,_ RequestUrl: String){
        let url = URL(string: RequestUrl+text)
        APIClient.fetchPokemon(url, expecting: SinglePokemon.self) { [weak self] result in
            switch result{
            case .success(let data):
                    self?.presenter?.allPokemonFetchedSuccessFully(data: data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
}


