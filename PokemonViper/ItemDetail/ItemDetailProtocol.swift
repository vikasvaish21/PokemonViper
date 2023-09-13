//
//  ItemDetailProtocol.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 13/09/23.
//

import Foundation
protocol ItemDetailViewControllerProtocol{
    func setUpData(_ data: ItemDetailModel)
}

protocol ItemDetailPresenterProtocol {
    func viewDidLoad()
    func getFetchItemDetail()
}


protocol ItemDetailInteractorInputProtocol {
    var presenter: ItemDetailInteractorOutputProtocol? { get }
    func fetchitemDetail(_ url: URL)
}


protocol ItemDetailInteractorOutputProtocol {
    func fetchItemDetailDataSuccessfully(_ model: ItemDetailModel)
}

protocol ItemDetailRouterProtocol{
    
}
