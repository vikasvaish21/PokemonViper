//
//  MovesListInteractor.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 11/09/23.
//

import Foundation


class MovesListInteractor: MovesListInteractorInputProtocol{
    var presenter: MovesListInteractorOutputProtocol?
    
    
    func fetchNumberOfMovesList(_ url: URL){
        APIClient.fetchPokemon(url, expecting: MovesCountModel.self) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.presenter?.fetchMovesListDataSuccesfully(data)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func fetchMoveList(_ url: URL) {
        APIClient.fetchPokemon(url, expecting: ModelListModel.self) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.presenter?.fetchMoveListDataSuccessfully(data)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchMoveData(_ url: URL){
        APIClient.fetchPokemon(url, expecting: MovesDetailModel.self) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.presenter?.fetchSingleMoveDetailSuccessfully(data)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
