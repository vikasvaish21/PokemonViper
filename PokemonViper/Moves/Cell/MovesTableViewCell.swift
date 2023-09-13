//
//  MovesTableViewCell.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 12/09/23.
//

import Foundation
import UIKit


class MovesTableViewCell : UITableViewCell{
    static var reuseId = "MovesTableViewCell"
    let myLabel = MyLabel(textSize: 19, color: .black, alignment: .center)
    let pokemonMoveType: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let mainView: UIView = {
        let view = UIView()
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(mainView)
        contentView.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 0.8)
        mainView.addSubview(myLabel)
        mainView.addSubview(pokemonMoveType)
        setUpConstraint()
        
    }
    
    
    func setUpConstraint() {
        mainView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 10, paddingLeft: 5, paddingBottom: 10, paddingRight: 5, width: 60, height: 60)
        myLabel.anchor(left: mainView.leftAnchor, paddingLeft: 10)
        myLabel.centerY(inView: mainView)
        pokemonMoveType.anchor(right: mainView.rightAnchor, paddingRight: 10, width: 45, height: 45)
        pokemonMoveType.centerY(inView: mainView)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
