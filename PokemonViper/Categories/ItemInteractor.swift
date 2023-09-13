//
//  ItemInteractor.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 13/09/23.
//

import Foundation
class ItemInteractor: ItemInteractorInputProtocol{
    var presenter: ItemInteractorOutputProtocol?
    
    func fetchItemCategories(_ url: URL) {
        APIClient.fetchPokemon(url, expecting: ItemCategoryCountModel.self) { result in
            switch result{
            case .success(let data):
                DispatchQueue.main.async {
                    self.presenter?.fetchItemCategriesSuccessfully(data)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchAllItemCategories(_ url : URL) {
        APIClient.fetchPokemon(url, expecting: ItemCategoryModel.self) { result in
            switch result{
            case .success(let data):
                DispatchQueue.main.async {
                    self.presenter?.fetchAllCategoriesSuccessfully(data)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
