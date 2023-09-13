//
//  ItemPresenter.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 13/09/23.
//

import Foundation
class ItemPresenter: ItemPresenterProtocol,ItemInteractorOutputProtocol{
    
    var view: ItemViewProtocol?
    private let interactor: ItemInteractorInputProtocol
    private let router:  ItemRouterProtocol
    private var items: ItemCategoryModel?
    var searchResult : [ItemResult] = []
    private var filteredItems: [ItemResult] = []
    var offset: Int = 0
    var totalOffsets = 0
    var numberOfRows: Int{
        return searchResult.isEmpty ? filteredItems.count : searchResult.count
    }

    
    
    init(view: ItemViewProtocol, interactor: ItemInteractorInputProtocol, router: ItemRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    
    func viewDidLoad() {
        interactor.fetchItemCategories(URL(string:Constants.pokemonItemCategoryBaseUrl)!)
    }
  
    
    func allItemCategories() {
        if offset < totalOffsets{
            interactor.fetchAllItemCategories(URL(string: Constants.pokemonItemCategoryBaseUrlAll + "\(totalOffsets)")!)
        }
    }
    
    func fetchItemCategriesSuccessfully(_ model: ItemCategoryCountModel) {
        totalOffsets = model.count
        allItemCategories()
    }
    
    func selectCategory(at index: Int) {
        if !searchResult.isEmpty{
            router.navigationToCategoryitems(searchResult[index])
        }else{
            router.navigationToCategoryitems(filteredItems[index])
        }
    }
    
    func fetchAllCategoriesSuccessfully(_ model: ItemCategoryModel) {
        items = model
        filteredItems = model.results
        view?.reloadData()
    }
    
    func setUpText(_ index: Int) -> String{
        if !searchResult.isEmpty{
            return searchResult[index].name
        }else if let items = items?.results{
            if !items.isEmpty{
                return items[index].name
            }
        }
        return ""
    }
    
    
    func getFilteredData(_ searchText: String)  {
        if !filteredItems.isEmpty{
            searchResult = []
            if searchText == ""{
                searchResult = filteredItems
            } else{
                searchResult += filteredItems.filter{$0.name.lowercased().hasPrefix(searchText.lowercased())}
                self.view?.reloadData()
            }
        }
        DispatchQueue.main.async {
            self.view?.reloadData()
        }
       
    }
 

}
