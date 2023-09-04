//
//  PokemonDetailInteractor.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 14/10/22.
//

import Foundation
class PokemonDetailInteractor: PokemonDetailInteractorInputProtocol{
    
    var presenter: PokemonDetailInteractorOutputProtocol?
    var pokemon: PokemonSavedData?
    

    func fetchSinglePokemon(_ RequestUrl: URL) {
        
        APIClient.fetchPokemon(RequestUrl, expecting: SinglePokemon.self) { [weak self] result in
            switch result{
            case .success(let data):
                DispatchQueue.main.async {
                    self?.presenter?.singlePokemonFetchedSuccessfully(model: data)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
   
    func fetchPokemonDescription( _ RequestUrl: URL) {
        APIClient.fetchPokemon(RequestUrl, expecting: PokemonDescription.self) { [weak self] result in
            switch result{
            case .success(let data):
                DispatchQueue.main.async {
                  
                    self?.presenter?.pokemonDescriptionFetchSuccessfully(model: data)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchMegaPokemonDescription( _ RequestUrl: URL) {
        APIClient.fetchPokemon(RequestUrl, expecting: PokemonDescription.self) { [weak self] result in
            switch result{
            case .success(let data):
                DispatchQueue.main.async {
                    self?.presenter?.megaPokemonDescriptionFetchSuccessfully(model: data)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func fetchPokemonSpeciesRegion(_ Requesturl: URL) {
//        APIClient.fetchPokemon(Requesturl, expecting: <#T##(Decodable & Encodable).Protocol#>) { [weak self] result in
//            switch
//        }
    }
    
    
    func fetchPokemonEvolution(_ requestUrl: URL) {
        APIClient.fetchPokemon(requestUrl, expecting: PokemonEvolutionChain.self) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.presenter?.pokemonEvolutionFetchSuccessfully(model: data)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    
}
