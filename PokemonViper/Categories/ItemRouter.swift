//
//  ItemRouter.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 13/09/23.
//

import Foundation
import UIKit

class ItemRouter: ItemRouterProtocol {
    var viewController: UIViewController?
    static func createModule() -> UIViewController {
        let view = ItemViewController()
        let interactor = ItemInteractor()
        let router = ItemRouter()
        let presenter = ItemPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
    
    func navigationToCategoryitems(_ item: ItemResult) {
        let vc = CategoryItemsRouter.createModule(item)
        viewController?.navigationController?.pushViewController(vc, animated: false)
    }
}
