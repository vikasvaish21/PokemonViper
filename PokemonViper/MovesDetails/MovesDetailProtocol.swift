//
//  MovesDetailProtocol.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 12/09/23.
//

import Foundation
protocol MovesDetailViewProtocol{
    func setNavigationBarColor(_ type: PokemonType)
    func getTypeData(_ move: MovesDetailSavedData)
    func getDescriptionData(_ text: String)
}


protocol MovesDetailPresenterProtocol{
    func viewDidLoad()
}


protocol MovesDetailInteractorInputProtocol{
    func fetchMoveData(_ url: URL)
}


protocol MovesDetailInteractorOutputProtocol{
    func fetchMoveDetailSuccessfully(_ model: MoveDescriptionModel)
}


protocol MovesDetailRouterProtocol{
    
}
