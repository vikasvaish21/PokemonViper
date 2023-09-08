//
//  EvolutionChainCell.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 23/08/23.
//

import Foundation
import UIKit


class EvolutionChainCell: UITableViewCell{
    static var reuseIdentifier = "EvolutionChainCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)  {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(mainView)
        mainView.addSubview(basePokemon)
        mainView.addSubview(basePokemonLabel)
        mainView.addSubview(evolutionPokemon)
        mainView.addSubview(evolutionPokemonLabel)
        mainView.addSubview(rightArrow)
        mainView.addSubview(rightArrowLabel)
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let mainView: UIView = {
        let view = UIView()
        return view
    }()
    
    let basePokemon: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let basePokemonLabel = MyLabel(textSize: 15, color: .black, alignment: .center)
    
    let evolutionPokemon: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let evolutionPokemonLabel = MyLabel(textSize: 15, color: .black, alignment: .center)
    
    let rightArrow: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rightArrow")
        return imageView
    }()
    
    let rightArrowLabel = MyLabel(textSize: 12, color: .black, alignment: .center)
    
    func setupConstraint() {
        mainView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 10, paddingLeft: 5, paddingBottom: 10, paddingRight: 5, height: 100)
        basePokemon.anchor(top: mainView.topAnchor,left: mainView.leftAnchor,paddingTop: 5,paddingLeft: 20,width: 75,height: 75)
        evolutionPokemon.anchor(top: mainView.topAnchor, right: mainView.rightAnchor, paddingTop: 5, paddingRight: 20, width: 75, height: 75)
        evolutionPokemonLabel.anchor(top: evolutionPokemon.bottomAnchor)
        evolutionPokemonLabel.centerX(inView: evolutionPokemon)
        basePokemonLabel.anchor(top: basePokemon.bottomAnchor)
        basePokemonLabel.centerX(inView: basePokemon)
        rightArrow.anchor(width: 55, height: 30)
        rightArrow.centerX(inView: mainView)
        rightArrow.centerY(inView: mainView)
        rightArrowLabel.anchor(bottom: rightArrow.topAnchor,paddingTop: 20, width: 100, height: 20)
        rightArrowLabel.centerX(inView: mainView)
    }
    
    
    
}
