//
//  MovesDetailRouter.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 12/09/23.
//


import UIKit

class MovesDetailRouter: MovesDetailRouterProtocol{
    var viewController : UIViewController?
    static func createPokemonMovesDetailModule(for item : MovesDetailSavedData) -> UIViewController{
        let view = MovesDetailViewController()
        let interactor = MovesDetailInteractor()
        let router = MovesDetailRouter()
        let presenter = MovesDetailPresenter(view: view ,interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        interactor.moveDetail = item
        presenter.moveDetail = item
        return view
        
    }
}
