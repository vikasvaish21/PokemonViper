//
//  Constants.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 09/10/22.
//

import Foundation

struct Constants {
//    static var pokemonNo : String = ""
    static let totalPokemon = URL(string: "https://pokeapi.co/api/v2/pokemon")
    static var baseUrl :String =  "https://pokeapi.co/api/v2/pokemon/?limit="
    static var singlePokemonUrl :String = "https://pokeapi.co/api/v2/pokemon/"
    static var allMegaPokemonUrl = URL(string: "https://pokemon-go-api.github.io/pokemon-go-api/api/pokedex/mega.json")!
    static let headerHeight: CGFloat = 400
    static var pokemonDescriptionUrl: String = "https://pokeapi.co/api/v2/pokemon-species/"
    static var pokemonRegionUrl :String =  "https://pokeapi.co/api/v2/pokedex/"
    static var pokemonEvolutionUrl: String = "https://pokeapi.co/api/v2/evolution-chain/"
}




