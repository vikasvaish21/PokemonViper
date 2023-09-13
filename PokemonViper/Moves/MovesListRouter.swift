//
//  MovesListRouter.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 11/09/23.
//

import Foundation

import UIKit


class MovesListRouter: MovesListRouterProtocol {
    var viewController: UIViewController?
    static func createModule() -> UIViewController {
        let view = MovesViewController()
        let interactor = MovesListInteractor()
        let router = MovesListRouter()
        let presenter = MovesListPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
    
    func navigationToMoveDetail(_ item: MovesDetailSavedData) {
        let vc = MovesDetailRouter.createPokemonMovesDetailModule(for: item)
        viewController?.navigationController?.pushViewController(vc, animated: false)
    }
}
