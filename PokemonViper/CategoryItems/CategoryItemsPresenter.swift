//
//  CategoryItemsPresenter.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 13/09/23.
//

import Foundation

class CategoryItemsPresenter:  CategoryItemsPresenterProtocol,CategoryItemsInteractorOutputProtocol{
    var view : CategoryItemsViewControllerProtocol?
    private let interactor: CategoryItemsInteractorInputProtocol
    private let router: CategoryItemsRouterProtocol
    var category: ItemResult?
    var searchResult : [Pocket] = []
    private var filteredItems: [Pocket] = []
    var offset: Int = 0
    var totalOffsets = 0
    var numberOfRows: Int{
        return searchResult.isEmpty ? filteredItems.count : searchResult.count
    }
    
    
    
    init(view: CategoryItemsViewController, interactor: CategoryItemsInteractorInputProtocol, router: CategoryItemsRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad(){
        fetchCategoryItems()
    }
    
    func fetchCategoryItems(){
        if let itemUrl = category?.url{
            interactor.fetchAllCategorieItems(URL(string: itemUrl)!)
        }
    }
    
    func fetchCategoryItemSuccessfully(_ model: CategoryItemsModel) {
        totalOffsets = model.items.count
        filteredItems = model.items
        view?.reloadData()
    }
    
    func setUpText(_ index: Int) -> String{
        if !searchResult.isEmpty{
            return searchResult[index].name
        }else if !filteredItems.isEmpty{
            return filteredItems[index].name
        }
        return ""
    }
    
    func selectCategoryItem(at index: Int) {
        if !searchResult.isEmpty{
            router.navigationToitemDetail(searchResult[index])
        }else{
            router.navigationToitemDetail(filteredItems[index])
        }
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
