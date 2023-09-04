//
//  PokemonDetailRouter.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 14/10/22.
//

import UIKit
class PokemonDetailRouter: PokemonDetailRouterProtocol{
    var viewController : UIViewController?
    
    static func createPokemonDetailModule(for item: PokemonSavedData) -> UIViewController{
        let view = PokemonDetailViewController()
        let interactor = PokemonDetailInteractor()
        let router = PokemonDetailRouter()
        let presenter = PokemonDetailPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        interactor.pokemon = item
        presenter.pokemon = item
        return view
    }
}
