//
//  ItemProtocols.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 13/09/23.
//

import Foundation


protocol ItemViewProtocol{
    var presenter : ItemPresenterProtocol?{get set}
    func reloadData()
    
}

protocol ItemPresenterProtocol{
    var view : ItemViewProtocol?{get set}
    var numberOfRows:Int{get}
    func viewDidLoad()
    func setUpText(_ index: Int) -> String
    func getFilteredData(_ searchText: String)
    func selectCategory(at index: Int) 
    
}

protocol ItemInteractorInputProtocol{
    var presenter : ItemInteractorOutputProtocol?{get set}
    func fetchItemCategories(_ url: URL)
    func fetchAllItemCategories(_ url: URL)
}

protocol ItemInteractorOutputProtocol{
    func fetchItemCategriesSuccessfully(_ model: ItemCategoryCountModel)
    func fetchAllCategoriesSuccessfully(_ model: ItemCategoryModel)
}

protocol ItemRouterProtocol{
    func navigationToCategoryitems(_ item: ItemResult)
}
