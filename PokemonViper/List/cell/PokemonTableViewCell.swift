//
//  PokemonTableViewCell.swift
//  PokemonMVVM
//
//  Created by Vikas Vaish on 09/10/22.
//

import UIKit
import Foundation

class PokemonTableViewCell: UITableViewCell {
    static var reuseId = "PokemonTableViewCell"
    
    let myLabel = MyLabel(textSize: 18, color: .black, alignment: .center)
    let orderLabel = MyLabel(textSize: 18, color: .lightGray, alignment: .center)
    let myImage = UIImageView()
    let primaryTypeImage = UIImageView()
    let secondryTypeImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(myImage)
        contentView.addSubview(myLabel)
        contentView.addSubview(orderLabel)
        
        contentView.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 0.8)
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myImage.translatesAutoresizingMaskIntoConstraints = false
        myImage.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor,paddingTop: 5,paddingLeft: 10,paddingBottom: 5,paddingRight: 5,width: 100,height: 100)
        myLabel.anchor(top: myImage.topAnchor,left: myImage.rightAnchor,paddingTop: 8,paddingLeft: 10)
        orderLabel.anchor(left: myLabel.leftAnchor,bottom: myImage.bottomAnchor,paddingBottom: 8)
        myImage.layer.cornerRadius = 12
        setUpImageView()
    }
    
    
    func setUpImageView(){
        contentView.addSubview(primaryTypeImage)
        contentView.addSubview(secondryTypeImage)
        primaryTypeImage.anchor(right: contentView.rightAnchor,paddingRight: 8,width: 40,height: 40)
        primaryTypeImage.centerY(inView: contentView)
        secondryTypeImage.anchor(right: primaryTypeImage.leftAnchor,paddingRight: 4,width: 40,height: 40)
        secondryTypeImage.centerY(inView: contentView)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
