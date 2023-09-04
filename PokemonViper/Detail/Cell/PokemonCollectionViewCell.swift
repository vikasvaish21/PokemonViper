//
//  PokemonCollectionViewCell.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 18/10/22.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    static var reuseIdentifier = "PokemonCollectionViewCell"
    
    var label = MyLabel(textSize: 18, color: .white, alignment: .center)
    var myImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .black
        contentView.addSubview(label)
        contentView.addSubview(myImage)
        setupContent()
    }
    
    func setupContent(){
        label.translatesAutoresizingMaskIntoConstraints = false
        label.anchor(top: contentView.topAnchor,left: contentView.leftAnchor,right: contentView.rightAnchor,height: 20)
        myImage.translatesAutoresizingMaskIntoConstraints = false
        myImage.anchor(top: label.bottomAnchor,left: label.leftAnchor,bottom: contentView.bottomAnchor,right: label.rightAnchor,paddingTop: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
