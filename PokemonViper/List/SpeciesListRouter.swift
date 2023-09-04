//
//  SpeciesListRouter.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 08/10/22.
//

import Foundation
import UIKit
class SpeciesListRouter: SpeciesListRouterProtocol{
    
    
    
    
    var viewController: UIViewController?
    static func createModule() -> UIViewController {
        let view = SpeciesListViewController()
        let interactor = SpeciesListInteractor()
        let router = SpeciesListRouter()
        let presenter = SpeciesListPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
    
    func naviagtionToSpeciesDetail(_ item: PokemonSavedData) {
        let vc = PokemonDetailRouter.createPokemonDetailModule(for: item)
        viewController?.navigationController?.pushViewController(vc, animated: false)
    }
    
    
}
