//
//  CategoryItemsRouter.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 13/09/23.
//

import Foundation
import UIKit

class CategoryItemsRouter : CategoryItemsRouterProtocol{
    var viewController: UIViewController?
    static func createModule(_ data: ItemResult) -> UIViewController {
        let view = CategoryItemsViewController()
        let interactor = CategoryItemsInteractor()
        let router = CategoryItemsRouter()
        let presenter = CategoryItemsPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        presenter.category = data
        view.itemData = data
        return view
    }
    
    func navigationToitemDetail(_ item: Pocket) {
        let vc = ItemDetailRouter.createModule(item)
        viewController?.navigationController?.pushViewController(vc, animated: false)
    }
}
