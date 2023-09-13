//
//  CategoryItemsProtocols.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 13/09/23.
//

import Foundation
protocol CategoryItemsViewControllerProtocol{
    func reloadData()
}
protocol CategoryItemsPresenterProtocol{
    var numberOfRows: Int{ get }
    func viewDidLoad()
    func getFilteredData(_ searchText: String)
    func setUpText(_ index: Int) -> String
    func selectCategoryItem(at index: Int)
    
}


protocol CategoryItemsInteractorInputProtocol{
    var presenter : CategoryItemsInteractorOutputProtocol? { get }
    func fetchAllCategorieItems(_ url: URL)
}


protocol CategoryItemsInteractorOutputProtocol{
    func fetchCategoryItemSuccessfully(_ model: CategoryItemsModel)
}

protocol  CategoryItemsRouterProtocol{
    func navigationToitemDetail(_ item: Pocket)
}
