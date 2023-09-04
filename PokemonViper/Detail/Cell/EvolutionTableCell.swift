//
//  EvolutionTableCell.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 23/08/23.
//


import Foundation
import UIKit


class EvolutionTableCell: UITableViewCell{
    static var reuseIdentifier = "EvolutionTableCell"
    var titleLabel = MyLabel(textSize: 20, color: .black, alignment: .center)
    var pokemonEvolution : PokemonEvolutionChain?
    var megaEvolution = [String]()
    var result = [PokemonSavedData]()
    var totalEvolutions : Int?
    var totalmegaEvolution :Int?
    var evolutionNames = [String:[Int]]()
    var secondEvolutionName = [String:[Int]]()
    var evolutionStone = [String:[String]]()
    var secondEvolutionStone = [String:[String]]()
    var evolutionHappinessLevel = [String: [Int]]()
    var secondEvolutionHappinessLavel =  [String: [Int]]()
    var secondEvolutionSpecie = [String:String]()
    var firstEvolutionSpecie = [String: String]()
    var basePokemon = [String]()
    var evolutionSequence = [String:Array<String>]()
    var evolutions = [[String]]()
    var baseEvolutionArray = [String]()
    var basePokemonImgaeArray = [String?]()
    var evolutionPokemonImageArray = [String?]()
    var evolutionArray = [String]()
    
    private let manager : PokemonManager = PokemonManager()
    private lazy var pokemonTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.isScrollEnabled = false
        tableView.register(EvolutionChainCell.self, forCellReuseIdentifier: EvolutionChainCell.reuseIdentifier)
        
        return tableView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        pokemonTableView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        contentView.addSubview(pokemonTableView)
        setUpContraint()
        
    }
    func reloadTableView() {
        evolutionNames.merge(secondEvolutionName) { (evolutionNames, _) in
            evolutionNames
        }
        evolutionStone.merge(secondEvolutionStone) { evolutionStone, _ in
            evolutionStone
        }
        print(evolutionNames)
        pokemonTableView.reloadData()
    }
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setUpContraint(){
        titleLabel.anchor(top: contentView.topAnchor,width: 150,height: 60)
        titleLabel.centerX(inView: contentView)
        pokemonTableView.anchor(top: titleLabel.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
    }
}


extension EvolutionTableCell: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return evolutionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pokemonTableView.dequeueReusableCell(withIdentifier: EvolutionChainCell.reuseIdentifier, for: indexPath) as! EvolutionChainCell
        if !baseEvolutionArray.isEmpty{
            cell.basePokemonLabel.text = baseEvolutionArray[indexPath.row].capitalized
            var currentPokemon  = evolutionArray[indexPath.row].capitalized
            cell.evolutionPokemonLabel.text = currentPokemon
            if let levelAvailable = evolutionNames[evolutionArray[indexPath.row]]?.first{
                cell.rightArrowLabel.text = "Level \(levelAvailable)"
            }else{
                if let stoneAvailable = evolutionStone[evolutionArray[indexPath.row]]?.first{
                    cell.rightArrowLabel.text = "use \(stoneAvailable)"
                }else{
                    cell.rightArrowLabel.text = ""
                }
            }
        }
        if !basePokemonImgaeArray.isEmpty{
            if let urlString = basePokemonImgaeArray[indexPath.row]{
                if let imageURL = URL(string: urlString) {
                    cell.basePokemon.kf.setImage(with: imageURL)
                }
            }
        }
        if !evolutionPokemonImageArray.isEmpty{
            if let urlString = evolutionPokemonImageArray[indexPath.row]{
                if let imageURL = URL(string: urlString) {
                    cell.evolutionPokemon.kf.setImage(with: imageURL)
                }
            }
        }
            
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
