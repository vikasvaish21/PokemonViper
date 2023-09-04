//
//  APIClient.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 09/10/22.
//

import Foundation
class APIClient{
    
    static func fetchPokemon<T:Codable>(_ url: URL?,expecting:T.Type,completion:@escaping (Result<T,Error>) -> Void) {
        URLSession.shared.request(url: url, expecting: expecting, completion: completion)
    }
    

}
