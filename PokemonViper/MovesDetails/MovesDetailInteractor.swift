//
//  MovesDetailInteractor.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 12/09/23.
//

import Foundation
class MovesDetailInteractor: MovesDetailInteractorInputProtocol{
    
    var presenter : MovesDetailInteractorOutputProtocol?
    var moveDetail: MovesDetailSavedData?
    
    
    
    func fetchMoveData(_ url: URL){
        APIClient.fetchPokemon(url, expecting: MoveDescriptionModel.self) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.presenter?.fetchMoveDetailSuccessfully(data)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
