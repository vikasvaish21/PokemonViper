//
//  ItemDetailRouter.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 13/09/23.
//

import Foundation
import UIKit

class ItemDetailRouter : ItemDetailRouterProtocol{
    var viewController: UIViewController?
    static func createModule(_ data: Pocket) -> UIViewController {
        let view = ItemDetailViewController()
        let interactor = ItemDetailInteractor()
        let router = ItemDetailRouter()
        let presenter = ItemDetailPresenter(view: view, Interactor: interactor, Router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        presenter.itemData = data
        view.itemData = data
        return view
    }
    
}
