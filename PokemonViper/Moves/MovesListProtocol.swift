//
//  MovesListProtocol.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 11/09/23.
//

import Foundation
import UIKit


protocol MovesListViewProtocol {
    var presenter: MovesListPresenterProtocol? {get set}
    func reloadData()
    
}

protocol MovesListPresenterProtocol{
    var view: MovesListViewProtocol? { get set }
    var numberOfRows: Int{get}
    var MovesDict: [String:String]{get set}
    var movesName : [String] {get set}
    func viewDidLoad()
    func setMoveNames(at index: Int) -> String
    func getFilteredData(_ searchText: String)
    func setMoveTypeImage(at index: Int) -> String
    func selectMove(at index: Int)
}


protocol MovesListRouterProtocol{
    func navigationToMoveDetail(_ item: MovesDetailSavedData) 
}

protocol MovesListInteractorInputProtocol{
    var presenter : MovesListInteractorOutputProtocol? {get set}
    func fetchNumberOfMovesList(_ url: URL)
    func fetchMoveList(_ url: URL)
    func fetchMoveData(_ url: URL)
}


protocol MovesListInteractorOutputProtocol{
    func fetchMovesListDataSuccesfully(_ model: MovesCountModel)
    func fetchMoveListDataSuccessfully(_ model: ModelListModel)
    func fetchSingleMoveDetailSuccessfully(_ model :MovesDetailModel)
}

