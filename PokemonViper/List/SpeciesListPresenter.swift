//
//  SpeciesListPresenter.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 08/10/22.
//

import Foundation
import UIKit

class SpeciesListPresenter: SpeciesListInteractorOutputProtocol,SpeciesListPresenterProtocol {
   
    
    
    var view : SpeciesListViewProtocol?
    private let interactor: SpeciesListInteractorInputProtocol
    private let router: SpeciesListRouterProtocol
    private let manager : PokemonManager = PokemonManager()
    private var pokemonName: [String] = []
    private var imageUrls : [String] = []
    private var pokemon: [SinglePokemon] = []
    var searchResult : [PokemonSavedData] = []
    private var filteredSpecies: [SinglePokemon] = []
    var offset: Int = 0
    var totalOffsets = 0
    var limit = 10
    var result = [PokemonSavedData]()
    
    var isSearchMode:Bool = false
    
    var numberOfRows: Int{
        return searchResult.isEmpty ? filteredSpecies.count : searchResult.count
    }
    
    init(view: SpeciesListViewProtocol, interactor: SpeciesListInteractorInputProtocol, router: SpeciesListRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        result = manager.fetchPokemon()!
        offset = result.count
        if result.count != 0{
            searchResult = result
        }else{
            interactor.fetchNumberOfSpecies(Constants.totalPokemon!)
        }
        
    }
    
    
    func allPokemonSpecies() {
        if offset < totalOffsets{
            manager.deleteAllPokemon()
            interactor.fetchSpecies(URL(string: Constants.baseUrl + "\(totalOffsets)")!)
        }else{
            searchResult = result
        }
    }
    
    func selectSpecies(at index: Int) {
        if !searchResult.isEmpty{
            router.naviagtionToSpeciesDetail(searchResult[index])
        }else{
            router.naviagtionToSpeciesDetail(PokemonSavedData(name: filteredSpecies[index].name,pokemonNo: filteredSpecies[index].id,sprites: filteredSpecies[index].sprites?.other?.officialArtwork?.frontDefault,primaryTypes: filteredSpecies[index].types?[0].type?.name,secondaryType: filteredSpecies[index].types?[0].type?.name))
        }
    }
    

    func speciesfetchingFailed(withError error: Error) {
        view?.hideLoadingIndicator()
        view?.showErrorMessage(message: error)
    }
    
    func numberOfPokemonSuccesfully(model:Pokemon) {
        totalOffsets = model.count
        allPokemonSpecies()
    }

    func speciesFetchedSuccessfully(model: Pokemon) {
        pokemonName = model.results.map{$0.name}
        for i in pokemonName{
            interactor.fetchSinglePokemon(i, Constants.singlePokemonUrl)
        }
    }
    
    

    func allPokemonFetchedSuccessFully(data: SinglePokemon) {
        pokemon.append(data)
        insertRecords(data)
        pokemon = pokemon.sorted{ $0.id! < $1.id!}
        print(pokemon.count)
        filteredSpecies = pokemon
        DispatchQueue.main.async { [weak self] in
            self?.view?.reloadData()
        }
    }
    
    func insertRecords(_ element: SinglePokemon){
        var secondType = ""
        if element.types!.count > 1{
            secondType = element.types?[1].type?.name ?? ""
        }
        let entryPokemon = PokemonSavedData(name: element.name, id: UUID(), pokemonNo: element.id, sprites: element.sprites?.other?.officialArtwork?.frontDefault, primaryTypes: (element.types?[0].type?.name)!, secondaryType: secondType)
        manager.createPokemonData(pokemon: entryPokemon)
    }

    func getPokemonName(at index: Int) -> String{
        if !searchResult.isEmpty{
            return searchResult[index].name!
        } else{
            return filteredSpecies[index].name!
        }
    }
    
    func getPokemonImage(at index:Int) -> String{
        if !searchResult.isEmpty{
            return searchResult[index].sprites ?? ""
        } else{
            return (filteredSpecies[index].sprites?.other?.officialArtwork?.frontDefault) ?? ""
        }
    }
    
    
    func setPokemonPrimaryType(_ index: Int) -> UIImage{
        if !searchResult.isEmpty{
            return UIImage(named: searchResult[index].primaryTypes ?? "") ?? UIImage()
        }
        return UIImage(named: filteredSpecies[index].types?[0].type?.name ?? "" )  ?? UIImage()
    }
    
    func setPokemonSecondryType(_ index: Int) -> UIImage{
        if !searchResult.isEmpty{
            if !searchResult[index].secondaryType!.isEmpty{
                return UIImage(named: searchResult[index].secondaryType ?? "") ?? UIImage()
            }
        } else{
            if filteredSpecies[index].types!.count > 1{
                return UIImage(named: filteredSpecies[index].types?[1].type?.name ?? "" )  ?? UIImage()
            }
        }
       return UIImage()
    }
    
    func getPokemonNumber(_ index:Int) -> Int64{
        if searchResult.isEmpty{
            return filteredSpecies[index].id!
        }else{
            return searchResult[index].pokemonNo!
        }
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
            filteredSpecies = []
            if searchText == ""{
                filteredSpecies = pokemon
            } else{
                for poke in pokemon{
                    if poke.name!.lowercased().contains(searchText.lowercased()){
                        filteredSpecies.append(poke)
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.view?.reloadData()
            }
        }
    }
 
}
