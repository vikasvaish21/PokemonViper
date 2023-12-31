//
//  PokemonDetailProtocol.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 14/10/22.
//

import Foundation
import UIKit

protocol PokemonDetailViewProtocol {
//    func setUpImageView(_ imageUrl: URL)
//    func setUpPokemonLabel(_ text: String)
//    func setUpPokemonPrimaryTypeLabel(_ text: String)
//    func setUpPokemonSecondaryTypeLabel(_ text: String)
//    func setUpPokemonStatLabel()
    func reloadData()
    func setupViewContent()
    func setHeaderContentData(name: String)
    func setNaviagtionBar(firstColor: UIColor,secondColor: UIColor)
    func setNavigationBarColor(_ type: PokemonType)
    func setUpImageView(_ url: URL)
}


protocol PokemonDetailInteractorOutputProtocol {
    func singlePokemonFetchedSuccessfully(model: SinglePokemon)
    func pokemonDescriptionFetchSuccessfully(model: PokemonDescription)
    func pokemonEvolutionFetchSuccessfully(model: PokemonEvolutionChain)
    func pokemonMovesFetchSuccesfully(model: PokemonMovesDetail)
    func megaPokemonDescriptionFetchSuccessfully(model: PokemonDescription) 
    
}


protocol PokemonDetailInteractorInputProtocol {
//    var presenter: PokemonDetailInteractorOutputProtocol? {get set}
    func fetchSinglePokemon( _ RequestUrl: URL)
    func fetchPokemonDescription( _ RequestUrl: URL)
    func fetchPokemonMovesDetail(_ Requesturl: URL)
    func fetchPokemonEvolution(_ requestUrl: URL)
    func fetchMegaPokemonDescription( _ RequestUrl: URL)
}


protocol PokemonDetailPresenterProtocol {
//    var numberOfItems: Int {get}
    func viewDidLoad()
    func getImageUrl()
    func setPokemonDescription() -> String
    func setPokemonName() -> String
    func setPokemonType1() -> String
    func setPokemonType2() -> String
    func setUpMoveslevel() ->[(String,String)]
    func setUpMoveType() ->[String:String]
    var normalEvolutionChain: ([String],[String]) {get}
    var normalEvolutionChainImages:([String],[String]) {get}
    func setPokemonEvolution() -> PokemonEvolutionChain?
    func statiticColorType() -> UIColor
    func pokemonStatData() -> [Stat]?
    func setUpPokemonSequence() -> [String:[String]]
    func numberOfEvolutions(_ completionHandler : @escaping (_ data: Int?) -> ())
    func numberOfMegaEvolution(_ pokemon: String) 
    func setEvolutionPokmonImages(_ value: ([String],[String]))  -> ([String],[String])
    var totalEvolutions :Int?{get}
    var totalMegaPokemons: [String]{get}
    var evolutionNames : [String:[Int]] {get}
    var secondEvolutionName :[String:[Int]] {get}
    var evolutionStone : [String:[String]]{get}
    var secondEvolutionStone : [String:[String]]{get}
    var evolutionHappinessLevel : [String: [Int]]{get}
    var mainBasePokemonArray: [String] {get set}
    var mainEvolutionPokemonArray:[String] {get set}
    var secondEvolutionHappinessLavel : [String: [Int]]{get}
    var secondEvolutionSpecie : [String:String]{get}
    var firstEvolutionSpecie : [String: String]{get}
    var evolutionHeldItem : [String: [String]]{get}
    var evolutionTimeAndDay : [String: [String]]{get}
    var evolutionTriggers : [String:[String]]{get}
    var basePokemon : String{get}
    
}

protocol PokemonDetailRouterProtocol {
//    
}
