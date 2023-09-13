//
//  ItemDetailInteractor.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 13/09/23.
//

import Foundation
class ItemDetailInteractor: ItemDetailInteractorInputProtocol{
    var presenter : ItemDetailInteractorOutputProtocol?
    
    
    func fetchitemDetail(_ url: URL) {
        APIClient.fetchPokemon(url, expecting: ItemDetailModel.self) { result in
            switch result{
            case .success(let data):
                DispatchQueue.main.async {
                    self.presenter?.fetchItemDetailDataSuccessfully(data)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
