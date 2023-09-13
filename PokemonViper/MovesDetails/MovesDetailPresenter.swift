//
//  MovesDetailPresenter.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 12/09/23.
//

import Foundation
import UIKit

class MovesDetailPresenter: MovesDetailPresenterProtocol,MovesDetailInteractorOutputProtocol{
    
    var view : MovesDetailViewProtocol?
    private let interactor : MovesDetailInteractorInputProtocol
    private let router : MovesDetailRouter
    var moveDetail: MovesDetailSavedData?
    
    init(view: MovesDetailViewProtocol, interactor: MovesDetailInteractorInputProtocol, router: MovesDetailRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        selectPokemonType()
        setMovesTypeImage()
        fetchMoveDescription()
    }
    
    func selectPokemonType(){
        if moveDetail?.type == "grass"{
            view?.setNavigationBarColor(.Grass)
        } else if moveDetail?.type == "electric"{
            view?.setNavigationBarColor(.Electric)
        } else if moveDetail?.type == "dragon"{
            view?.setNavigationBarColor(.Dragon)
        } else if moveDetail?.type == "fighting"{
            view?.setNavigationBarColor(.Fight)
        } else if moveDetail?.type == "flying"{
            view?.setNavigationBarColor(.Flying)
        } else if moveDetail?.type == "fairy" {
            view?.setNavigationBarColor(.Fairy)
        } else if moveDetail?.type == "ghost"{
            view?.setNavigationBarColor(.Ghost)
        } else if moveDetail?.type == "fire"{
            view?.setNavigationBarColor(.Fire)
        } else if moveDetail?.type == "ground"{
            view?.setNavigationBarColor(.Ground)
        } else if moveDetail?.type == "poison"{
            view?.setNavigationBarColor(.Poison)
        } else if moveDetail?.type == "normal"{
            view?.setNavigationBarColor(.Normal)
        } else if moveDetail?.type == "psychic"{
            view?.setNavigationBarColor(.Psychic)
        } else if moveDetail?.type == "steel"{
            view?.setNavigationBarColor(.Steel)
        } else if moveDetail?.type == "rock"{
            view?.setNavigationBarColor(.Rock)
        } else if moveDetail?.type == "water"{
            view?.setNavigationBarColor(.Water)
        } else if moveDetail?.type == "dark"{
            view?.setNavigationBarColor(.Dark)
        } else if moveDetail?.type == "bug"{
            view?.setNavigationBarColor(.Bug)
        } else if moveDetail?.type == "ice"{
            view?.setNavigationBarColor(.Ice)
        }
    }
    
    func setMovesTypeImage(){
        view?.getTypeData(moveDetail!)
    }
    
    
    func fetchMoveDescription(){
        if let moveNo = moveDetail?.moveNo{
            interactor.fetchMoveData(URL(string: Constants.pokemonMovesUrl + "\(moveNo)")!)
        }
    }
    
    
    func fetchMoveDetailSuccessfully(_ model: MoveDescriptionModel){
        view?.getDescriptionData(model.effectEntries.first?.effect ?? "")
    }
    
}
