//
//  ItemDetailPresenter.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 13/09/23.
//

import Foundation

class ItemDetailPresenter : ItemDetailPresenterProtocol,ItemDetailInteractorOutputProtocol{
   
    
    
    var presenter: ItemDetailInteractorInputProtocol?
    var itemData: Pocket?
    
    var view: ItemDetailViewControllerProtocol?
    private let Interactor : ItemDetailInteractorInputProtocol
    private let Router : ItemDetailRouterProtocol
    var result : ItemDetailModel?
    
    init(view: ItemDetailViewControllerProtocol, Interactor: ItemDetailInteractorInputProtocol, Router: ItemDetailRouterProtocol) {
        self.view = view
        self.Interactor = Interactor
        self.Router = Router
    }
    
    
    func viewDidLoad() {
        getFetchItemDetail()
    }
    
    
    func getFetchItemDetail() {
        Interactor.fetchitemDetail(URL(string: itemData!.url)!)
    }
    
    
    func fetchItemDetailDataSuccessfully(_ model: ItemDetailModel){
        result = model
        view?.setUpData(result!)
    }
    
    func setUpItemImage() -> URL{
        if let itemImage = result?.sprites.spritesDefault{
            if !itemImage.isEmpty{
                return URL(string: itemImage)!
            }
        }
        
        return URL(fileURLWithPath: "")
    }
    
}
