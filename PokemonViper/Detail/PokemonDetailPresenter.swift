//
//  PokemonDetailPresenter.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 14/10/22.
//

import Foundation
import UIKit
class PokemonDetailPresenter : PokemonDetailInteractorOutputProtocol,PokemonDetailPresenterProtocol{
    
    
    
    typealias newData = ([String],[String])
    var view : PokemonDetailViewProtocol?
    private let interactor: PokemonDetailInteractorInputProtocol
    private let router: PokemonDetailRouter
    var pokemon: PokemonSavedData?
    var descriptionArray: [String] = []
    var pokemonDescription: PokemonDescription?
    var pokemonData : SinglePokemon?
    var pokemonEvolution: PokemonEvolutionChain?
    private let manager : PokemonManager = PokemonManager()
    var movesDetail = [PokemonMovesDetail]()
    var pokemonMegaAndGmaxform  = [String]()
    var evolutionNames = [String:[Int]]()
    var secondEvolutionName = [String:[Int]]()
    var evolutionStone = [String:[String]]()
    var normalEvolutionChain = ([""],[""])
    var normalEvolutionChainImages = ([""],[""])
    var secondEvolutionStone = [String:[String]]()
    var evolutionHappinessLevel = [String: [Int]]()
    var evolutionHeldItem = [String: [String]]()
    var evolutionTimeAndDay = [String: [String]]()
    var evolutionTriggers = [String:[String]]()
    var secondEvolutionHappinessLavel =  [String: [Int]]()
    var secondEvolutionSpecie = [String:String]()
    var firstEvolutionSpecie = [String: String]()
    var movesLevel = [String:String]()
    var movesType = [String:String]()
    var totalEvolutions :Int?
    var totalMegaPokemons = [String]()
    var basePokemon = String()
    var firstForm = String()
    var basePokemonArray = [String]()
    var mainBasePokemonArray = [String]()
    var mainEvolutionPokemonArray = [String]()
    var mainBasePokemonImageArray = [String]()
    var mainEvolutionPokemonImageArray = [String]()
    var evolutionSequence = [String:[String]]()

    
    init(view: PokemonDetailViewProtocol, interactor: PokemonDetailInteractorInputProtocol, router: PokemonDetailRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
       
    func viewDidLoad(){
        selectPokemonType()
        getImageUrl()
        setUpTextOnLabel()
        fetchPokemonData()
        fetchPokemonDescription()
        initializePokemonArray()
        
    }
    
    func initializePokemonArray() {
        normalEvolutionChain.0.removeAll()
        normalEvolutionChain.1.removeAll()
        normalEvolutionChainImages.0.removeAll()
        normalEvolutionChainImages.1.removeAll()
    }
    
    
    func selectPokemonType(){
        if pokemon!.primaryTypes == "grass"{
            view?.setNavigationBarColor(.Grass)
        } else if pokemon!.primaryTypes == "electric"{
            view?.setNavigationBarColor(.Electric)
        } else if pokemon?.primaryTypes == "dragon"{
            view?.setNavigationBarColor(.Dragon)
        } else if pokemon?.primaryTypes == "fighting"{
            view?.setNavigationBarColor(.Fight)
        } else if pokemon?.primaryTypes == "flying"{
            view?.setNavigationBarColor(.Flying)
        } else if pokemon?.primaryTypes == "fairy" {
            view?.setNavigationBarColor(.Fairy)
        } else if pokemon?.primaryTypes == "ghost"{
            view?.setNavigationBarColor(.Ghost)
        } else if pokemon?.primaryTypes == "fire"{
            view?.setNavigationBarColor(.Fire)
        } else if pokemon?.primaryTypes == "ground"{
            view?.setNavigationBarColor(.Ground)
        } else if pokemon?.primaryTypes == "poison"{
            view?.setNavigationBarColor(.Poison)
        } else if pokemon?.primaryTypes == "normal"{
            view?.setNavigationBarColor(.Normal)
        } else if pokemon?.primaryTypes == "psychic"{
            view?.setNavigationBarColor(.Psychic)
        } else if pokemon?.primaryTypes == "steel"{
            view?.setNavigationBarColor(.Steel)
        } else if pokemon?.primaryTypes == "rock"{
            view?.setNavigationBarColor(.Rock)
        } else if pokemon?.primaryTypes == "water"{
            view?.setNavigationBarColor(.Water)
        } else if pokemon?.primaryTypes == "dark"{
            view?.setNavigationBarColor(.Dark)
        } else if pokemon?.primaryTypes == "bug"{
            view?.setNavigationBarColor(.Bug)
        } else if pokemon?.primaryTypes == "ice"{
            view?.setNavigationBarColor(.Ice)
        }
    }
    
    func getImageUrl(){
        let urlString = pokemon?.sprites
        if let url = urlString{
            if let imageURL = URL(string: url) {
                view?.setUpImageView(imageURL)
            }
        } else{
            if let imageURL = URL(string: "https://www.freeiconspng.com/img/23485") {
                view?.setUpImageView(imageURL)
            }
        }
    }
   
    func fetchPokemonData(_ name: String? = nil){
        let number = pokemon!.pokemonNo
        var pokemonDetail = URL(string: "")
        if name != nil{
            pokemonDetail = URL(string: Constants.singlePokemonUrl + "\(name ?? "")")
        }else{
            pokemonDetail = URL(string: Constants.singlePokemonUrl + "\(number ?? 0)")
        }
        interactor.fetchSinglePokemon(pokemonDetail!)
    }
    
    func fetchPokemonDescription(_ url: URL? = nil){
        let number = pokemon!.pokemonNo
        let descriptionUrl = URL(string: Constants.pokemonDescriptionUrl + "\(number ?? 0)")
        if url != nil{
            interactor.fetchPokemonDescription(url!)
        }else{
            interactor.fetchPokemonDescription(descriptionUrl!)
        }
    }
    
    
    func fetchMegaPokemonDescription(_ url: URL? = nil){
        interactor.fetchMegaPokemonDescription(url ?? URL(fileURLWithPath: ""))
    }
    
    func fetchPokemonEvolution(_ url : String) {
        self.interactor.fetchPokemonEvolution(URL(string: url)!)
    }
    
    
    func fetchMovesDetail() {
        let moves = pokemonData?.moves.map { $0.move.url }
        if let urlArray = moves{
            for url in urlArray{
                DispatchQueue.main.async {
                    self.interactor.fetchPokemonMovesDetail(URL(string: url)!)
                }
            }
        }
    }
    
    
    func setUpTextOnLabel(){
        let text = pokemon?.name ?? ""
        view?.setHeaderContentData(name: text.capitalized)
    }
    
    func setPokemonDescription() -> String{
        return descriptionArray.randomElement() ?? ""
    }
    
    
    func setPokemonName() -> String{
        return pokemonData?.name ?? ""
    }
    
    func setPokemonType1() -> String{
        return pokemon!.primaryTypes?.capitalized ?? ""
    }
    
    func setPokemonType2() -> String{
        return pokemon!.secondaryType?.capitalized ?? ""
    }
    
    
    func setPokemonEvolution() -> PokemonEvolutionChain?{
        return pokemonEvolution
    }
    
    func setBasePokemon() -> String{
        pokemonDescription?.evolvesFromSpecies?.name ?? ""
    }
    
    func setUpPokemonSequence() -> [String:[String]]{
        return evolutionSequence
    }

    func setUpMoveslevel() ->[(String,String)]{
        let count = pokemonData?.moves.count ?? 0
        for i in 0..<count{
            if (pokemonData?.moves[i].versionGroupDetails.first!.levelLearnedAt)! > 0{
                if let levelNo = pokemonData?.moves[i].versionGroupDetails.first!.levelLearnedAt{
                    movesLevel[(pokemonData?.moves[i].move.name)!] = "\(levelNo)"
                }
            }
        }
        let level = movesLevel.sorted(by: { $0.value < $1.value })
        return level
    }
    
    func setUpMoveType() ->[String:String] {
        for i in 0..<movesDetail.count{
            movesType[movesDetail[i].name!] = movesDetail[i].type.name
        }
        return movesType
    }
    
    func setBaseEvolutionPokemon() -> ([String],[String]){
        mainBasePokemonArray.removeAll()
        mainEvolutionPokemonArray.removeAll()
        if !basePokemonArray.isEmpty{
            for i in basePokemonArray{
                let count = evolutionSequence[i]?.count ?? 0
                for _ in 0..<count{
                    mainBasePokemonArray.append(i)
                }
            }
        }
        
        if !basePokemonArray.isEmpty{
            for j in basePokemonArray{
                let values = evolutionSequence[j]
                for k in 0..<(values?.count ?? 0){
                    mainEvolutionPokemonArray.append(values?[k] ?? "")
                }
            }
        }
        return (mainBasePokemonArray,mainEvolutionPokemonArray)
    }
    

    func setEvolutionPokmonImages(_ value : ([String],[String])) -> ([String],[String]){
        mainBasePokemonImageArray.removeAll()
        mainEvolutionPokemonImageArray.removeAll()
        let result = manager.fetchPokemon()
        if !value.0.isEmpty && !value.1.isEmpty{
            for i in value.0{
                if let pokemonData = result?.filter({$0.name == i}).first{
                    if let value = pokemonData.sprites{
                        mainBasePokemonImageArray.append(value)
                    }
                }
            }
            
            for j in value.1{
                if let pokemonData = result?.filter({$0.name == j}).first{
                    if let value = pokemonData.sprites{
                        mainEvolutionPokemonImageArray.append(value)
                    }
                }
            }
        }
        return (mainBasePokemonImageArray,mainEvolutionPokemonImageArray)
    }
    
    
    
    func statiticColorType() -> UIColor{
        if pokemon!.primaryTypes == "grass"{
            return .grassFirstColor
        } else if pokemon!.primaryTypes == "electric"{
            return .electricFirstColor
        } else if pokemon!.primaryTypes == "dragon"{
            return .dragonFirstColor
        } else if pokemon!.primaryTypes == "fighting"{
            return .fightFirstColor
        } else if pokemon!.primaryTypes == "flying"{
            return .flyingFirstColor
        } else if pokemon!.primaryTypes == "fairy" {
            return .fairyFirstColor
        } else if pokemon!.primaryTypes == "ghost"{
            return .ghostFirstColor
        } else if pokemon!.primaryTypes == "fire"{
            return .fireFirstColor
        } else if pokemon!.primaryTypes == "ground"{
            return .groundFirstColor
        } else if pokemon!.primaryTypes == "poison"{
            return .poisonfirstColor
        } else if pokemon!.primaryTypes == "normal"{
            return .normalFirstColor
        } else if pokemon!.primaryTypes == "psychic"{
            return .psychicFirstColor
        } else if pokemon!.primaryTypes == "steel"{
            return .steelFirstColor
        } else if pokemon!.primaryTypes == "rock"{
            return .rockFirstColor
        } else if pokemon!.primaryTypes == "water"{
            return .waterFirstColor
        } else if pokemon!.primaryTypes == "dark"{
            return .darkFirstColor
        } else if pokemon!.primaryTypes == "bug"{
            return .bugFirstColor
        } else if pokemon!.primaryTypes == "ice"{
            return .IceFirstColor
        }
        return UIColor()
    }
    
    func pokemonStatData() -> [Stat]?{
        return pokemonData?.stats
    }

    
    func pokemonDescriptionFetchSuccessfully(model: PokemonDescription){
        let descritionData = model.flavorTextEntries.filter{$0.language?.name == "en"}
        descriptionArray = descritionData.map{$0.flavorText?.replacingOccurrences(of: "\n", with: " ") ?? ""}
        if model.evolutionChain?.url != ""{
            fetchPokemonEvolution(model.evolutionChain?.url ?? "")
            if model.formsSwitchable == true{
                if let megaPokemons = findMegaAndGmaxPokemon(model){
                    totalMegaPokemons = megaPokemons
                }
            }
        }
    }
    
    
    func megaPokemonDescriptionFetchSuccessfully(model: PokemonDescription){
        pokemonDescription = model
        if pokemonMegaAndGmaxform.isEmpty{
            if let megaPokemons = findMegaAndGmaxPokemon(model){
                totalMegaPokemons = megaPokemons
            }
        }else{
            totalMegaPokemons = pokemonMegaAndGmaxform
        }
        for i in 0..<totalMegaPokemons.count{
            if let pokemonName = model.name{
                normalEvolutionChain.0.append(pokemonName)
            }
            normalEvolutionChain.1.append(totalMegaPokemons[i])
        }
        
        normalEvolutionChainImages = setEvolutionPokmonImages(normalEvolutionChain)
        view?.reloadData()
    }
    
    func singlePokemonFetchedSuccessfully(model: SinglePokemon) {
        pokemonData = model
        fetchMovesDetail()
        view?.reloadData()
    }
    
    func pokemonEvolutionFetchSuccessfully(model: PokemonEvolutionChain) {
        pokemonEvolution = model
        numberOfEvolutions { data in
            print(data ?? 0)
        }
        normalEvolutionChain = setBaseEvolutionPokemon()
        if !secondEvolutionName.isEmpty{
            numberOfMegaEvolution(secondEvolutionSpecie[((normalEvolutionChain.1.last)!)]!)
        }else if secondEvolutionName.isEmpty && !evolutionNames.isEmpty{
            numberOfMegaEvolution(firstEvolutionSpecie[(normalEvolutionChain.1.last!)]!)
        }else if secondEvolutionName.isEmpty && evolutionNames.isEmpty{
            numberOfMegaEvolution(model.chain?.species?.url ?? "")
        }

    }
    
    func pokemonMovesFetchSuccesfully(model: PokemonMovesDetail) {
        movesDetail.append(model)
        if let name = model.name{
            movesType[name] = model.type.name
        }
    }
    
    
    
    func findMegaAndGmaxPokemon(_ model: PokemonDescription) -> [String]?{
        if let varieties = model.varieties{
            for i in 0..<varieties.count{
                if varieties[i].isDefault == false{
                    if let varityPokemon = varieties[i].pokemon?.name{
                        pokemonMegaAndGmaxform.append(varityPokemon)
                    }
                }
            }
        }
        return pokemonMegaAndGmaxform
    }
    
    func numberOfEvolutions(_ completionHandler : @escaping (_ data: Int?) -> ()){
        if let firstEvolution = pokemonEvolution?.chain?.evolvesTo?.map({$0.species?.name}).compactMap({$0}){
            for i in 0..<firstEvolution.count{
                evolutionNames[firstEvolution[i]] = pokemonEvolution?.chain?.evolvesTo?[i].evolutionDetails?.compactMap({$0.minLevel})
                evolutionStone[firstEvolution[i]] = pokemonEvolution?.chain?.evolvesTo?[i].evolutionDetails?.compactMap({$0.item?.name})
                evolutionHappinessLevel[firstEvolution[i]] = pokemonEvolution?.chain?.evolvesTo?[i].evolutionDetails?.compactMap{$0.minHappiness}
                evolutionHeldItem[firstEvolution[i]] = pokemonEvolution?.chain?.evolvesTo?[i].evolutionDetails?.compactMap{$0.heldItem?.name}
                evolutionTimeAndDay[firstEvolution[i]] = pokemonEvolution?.chain?.evolvesTo?[i].evolutionDetails?.compactMap{$0.timeOfDay}
                evolutionTriggers[firstEvolution[i]] = pokemonEvolution?.chain?.evolvesTo?[i].evolutionDetails?.compactMap{$0.trigger?.name}
                firstEvolutionSpecie[firstEvolution[i]] = pokemonEvolution?.chain?.evolvesTo?[i].species?.url
                basePokemon = pokemonEvolution?.chain?.species?.name ?? ""
                if !basePokemonArray.contains(pokemonEvolution?.chain?.species?.name ?? ""){
                    basePokemonArray.append(pokemonEvolution?.chain?.species?.name ?? "")
                }
            }
            evolutionSequence[basePokemon] = evolutionNames.keys.map{$0}
            if let secondEvolution = pokemonEvolution?.chain?.evolvesTo?.compactMap({$0.evolvesTo?.compactMap({$0.species?.name})}).flatMap({$0}){
                for i in 0..<firstEvolution.count{
                    for j in 0..<secondEvolution.count{
                        secondEvolutionName[secondEvolution[j]] = pokemonEvolution?.chain?.evolvesTo?[i].evolvesTo?[j].evolutionDetails?.compactMap{($0.minLevel)}
                        evolutionStone[secondEvolution[j]] = pokemonEvolution?.chain?.evolvesTo?[i].evolvesTo?[j].evolutionDetails?.compactMap{$0.item?.name}
                        secondEvolutionHappinessLavel[secondEvolution[j]] = pokemonEvolution?.chain?.evolvesTo?[i].evolvesTo?[j].evolutionDetails?.compactMap{$0.minHappiness}
                        evolutionHeldItem[secondEvolution[j]] = pokemonEvolution?.chain?.evolvesTo?[i].evolvesTo?[j].evolutionDetails?.compactMap{$0.heldItem?.name}
                        evolutionTimeAndDay[secondEvolution[j]] = pokemonEvolution?.chain?.evolvesTo?[i].evolvesTo?[j].evolutionDetails?.compactMap{$0.timeOfDay}
                        evolutionTriggers[secondEvolution[j]] = pokemonEvolution?.chain?.evolvesTo?[i].evolvesTo?[j].evolutionDetails?.compactMap{$0.trigger?.name}
                        secondEvolutionSpecie[secondEvolution[j]] = pokemonEvolution?.chain?.evolvesTo?[i].evolvesTo?[j].species?.url
                        firstForm = pokemonEvolution?.chain?.evolvesTo?[i].species?.name ?? ""
                        if !basePokemonArray.contains(pokemonEvolution?.chain?.evolvesTo?[i].species?.name ?? ""){
                            basePokemonArray.append(pokemonEvolution?.chain?.evolvesTo?[i].species?.name ?? "")
                        }
                    }
                }
                evolutionSequence[firstForm] = secondEvolutionName.keys.map{$0}
            }
        }
        
        totalEvolutions = evolutionNames.count + secondEvolutionName.count
        completionHandler(totalEvolutions)
    }
    
    func numberOfMegaEvolution(_ pokemon: String) {
        fetchMegaPokemonDescription(URL(string: pokemon))
    }
}
