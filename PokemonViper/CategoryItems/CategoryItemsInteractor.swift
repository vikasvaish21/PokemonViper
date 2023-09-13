//
//  CategoryItemsInteractor.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 13/09/23.
//

import Foundation
class CategoryItemsInteractor: CategoryItemsInteractorInputProtocol{
    var presenter: CategoryItemsInteractorOutputProtocol?
    
    func fetchAllCategorieItems(_ url: URL) {
        APIClient.fetchPokemon(url, expecting: CategoryItemsModel.self) { result in
            switch result{
            case .success(let data):
                DispatchQueue.main.async {
                    self.presenter?.fetchCategoryItemSuccessfully(data)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
