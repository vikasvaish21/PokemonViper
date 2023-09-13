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
    var evolutionHeldItem = [String: [String]]()
    var secondEvolutionHeldItem = [String: [String]]()
    var evolutionTimeAndDay = [String: [String]]()
    var evolutionTriggers = [String:[String]]()
    var pokemonLevel = [Int]()
    var pokemonStone = [String]()
    var pokemonHeldItem = [String]()
    var pokemonTigger = [String]()
    var pokemonCondition = [String]()
    
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
    
    
    override func awakeFromNib(){
        contentView.addSubview(titleLabel)
        contentView.addSubview(pokemonTableView)
        setUpContraint()
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
            cell.basePokemonLabel.text = baseEvolutionArray[indexPath.row].replacingOccurrences(of: "-", with: " ").capitalized
            cell.evolutionPokemonLabel.text = evolutionArray[indexPath.row].replacingOccurrences(of: "-", with: " ").capitalized
            if let levels = evolutionNames[evolutionArray[indexPath.row]]{
                if !levels.isEmpty{
                    cell.rightArrowLabel.text = "Level \(levels.first ?? 0 )"
                }
            }
            if let stones = evolutionStone[evolutionArray[indexPath.row]]{
                if !stones.isEmpty{
                    cell.rightArrowLabel.text = "Use \(stones.first!.replacingOccurrences(of: "-", with: " ").capitalized)"
                }
            }
            if let heldItems = evolutionHeldItem[evolutionArray[indexPath.row]]{
                if !heldItems.isEmpty{
                    cell.rightArrowLabel.text = "Use \(heldItems.first!.replacingOccurrences(of: "-", with: " ").capitalized)"
                }
            }
            if let timeAndDay = evolutionTimeAndDay[evolutionArray[indexPath.row]]{
                if timeAndDay.first != ""{
                    cell.rightArrowLabel.text = "In \(evolutionTimeAndDay[evolutionArray[indexPath.row]]?.first?.capitalized ?? "")"
                }
            }
            
            
            
            if evolutionArray[indexPath.row].contains("mega"){
                cell.rightArrowLabel.text = "Mega Stone"
            }else if evolutionArray[indexPath.row].contains("gmax"){
                cell.rightArrowLabel.text = "Max Soup"
            }
            
            
//            else if  !evolutionTimeAndDay[evolutionArray[indexPath.row]]!.isEmpty{
//                cell.rightArrowLabel.text = "In \(evolutionTimeAndDay[evolutionArray[indexPath.row]]?.first?.capitalized ?? "")"
//            }else if evolutionHeldItem[evolutionArray[indexPath.row]] != nil{
//                cell.rightArrowLabel.text = (evolutionHeldItem[evolutionArray[indexPath.row]]?.first?.replacingOccurrences(of: "-", with: " ").capitalized ?? "")
//                if let trigger = evolutionTriggers[evolutionArray[indexPath.row]]?.first {
//                    (" + \(trigger.capitalized)")
//                }
//            }
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
