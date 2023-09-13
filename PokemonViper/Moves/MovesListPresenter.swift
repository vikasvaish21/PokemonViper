//
//  MovesListPresenter.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 11/09/23.
//

import Foundation

class MovesListPresenter: MovesListInteractorOutputProtocol ,MovesListPresenterProtocol{
    
    
    
    var view : MovesListViewProtocol?
    private let interactor: MovesListInteractorInputProtocol
    private let router: MovesListRouterProtocol
    private let manager : MovesManager = MovesManager()
    var offset = 0
    var totalOffsets = 0
    var result = [MovesDetailSavedData]()
    var searchResult : [MovesDetailSavedData] = []
    private var filteredMoves: [MovesDetailModel] = []
    var movesDetail = [MovesDetailModel]()
    var MovesDict = [String:String]()
    var movesName = [String]()
    var numberOfRows: Int{
        return searchResult.isEmpty ? filteredMoves.count : searchResult.count
    }

    init(view: MovesListViewProtocol, interactor: MovesListInteractorInputProtocol, router: MovesListRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        result = manager.fetchMoves()!
        offset = result.count
        if result.count != 0{
            searchResult = result
        }else{
            interactor.fetchNumberOfMovesList(URL(string: Constants.pokemonMovesUrl)!)
        }
        
    }
    
   
    
    func allPokemonMoves(){
        if offset < totalOffsets{
            manager.deleteAllMove()
            interactor.fetchMoveList(URL(string: Constants.pokemonMovesUrlAll + "\(totalOffsets)")!)
        }else{
            searchResult = result
        }
    }
    
    func fetchMovesListDataSuccesfully(_ model: MovesCountModel) {
        totalOffsets = model.count ?? 0
        allPokemonMoves()
    }
    
    func fetchMoveListDataSuccessfully(_ model: ModelListModel) {
        for i in 0..<model.results!.count{
            if let name = model.results?[i].name{
                movesName.append(name)
                MovesDict[name] = model.results?[i].url
            }
        }
        
        for i in movesName{
            if let moveUrl =  MovesDict[i]{
                interactor.fetchMoveData(URL(string: moveUrl)!)
            }
        }
    }
    
    func fetchSingleMoveDetailSuccessfully(_ model :MovesDetailModel) {
        movesDetail.append(model)
        insertRecords(model)
        movesDetail = movesDetail.sorted{ $0.id! < $1.id!}
        filteredMoves = movesDetail
        DispatchQueue.main.async { [weak self] in
            self?.view?.reloadData()
        }
    }
    
    func setMoveNames(at index: Int) -> String{
        if !searchResult.isEmpty{
            return searchResult[index].name!
        }else {
            return filteredMoves[index].name!
        }
    }
    
    func setMoveTypeImage(at index: Int) -> String{
        if !searchResult.isEmpty{
            return searchResult[index].type!
        }else {
            return filteredMoves[index].type?.name ?? ""
        }
    }
    
    func selectMove(at index: Int) {
        if !searchResult.isEmpty{
            router.navigationToMoveDetail(searchResult[index])
        }else{
            router.navigationToMoveDetail(MovesDetailSavedData(accuracy: filteredMoves[index].accuracy, id: UUID(), moveNo: filteredMoves[index].id, name: filteredMoves[index].name, power: filteredMoves[index].power, pp: filteredMoves[index].pp, priority: filteredMoves[index].priority, target: filteredMoves[index].target?.name, type: filteredMoves[index].type?.name))
        }
    }
    
    
    func insertRecords(_ element: MovesDetailModel){
        let entryPokemon = MovesDetailSavedData(accuracy: element.accuracy, id: UUID(), moveNo: element.id, name: element.name, power: element.power, pp: element.pp, priority: element.priority, target: element.target?.name, type: element.type?.name)
        manager.createPokemonData(pokemon: entryPokemon)
    }
    
    
    func getFilteredData(_ searchText: String)  {
        if !result.isEmpty{
            searchResult = []
            if searchText == ""{
                searchResult = result
                print(searchResult.count)
            } else{
                for poke in result{
                    if poke.name!.lowercased().contains(searchText.lowercased()){
                        searchResult.append(poke)
                    }
                }
            }
            DispatchQueue.main.async {
                self.view?.reloadData()
            }
            
        } else{
            filteredMoves = []
            if searchText == ""{
                filteredMoves = movesDetail
            } else{
                for poke in movesDetail{
                    if poke.name!.lowercased().contains(searchText.lowercased()){
                        filteredMoves.append(poke)
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.view?.reloadData()
            }
        }
    }
    
}
