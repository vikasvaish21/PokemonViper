//
//  pokemonDescriptionCell.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 04/11/22.
//

import UIKit

class pokemonDescriptionCell: UITableViewCell {
    static var reuseIdentifier = "pokemonDescriptionCell"
    var name = MyLabel(textSize: 40, color: .black, alignment: .center)
    var descri = MyLabel(textSize: 16, color: .gray, alignment: .center)
    var typeView1 = UIImageView()
    var typeView2 = UIImageView()
    var height :CGFloat = 0.0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)  {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        name.translatesAutoresizingMaskIntoConstraints = false
        descri.translatesAutoresizingMaskIntoConstraints = false
        typeView1.translatesAutoresizingMaskIntoConstraints = false
        typeView2.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubViews(view: descri)
        contentView.addSubViews(view: typeView1)
        contentView.addSubViews(view: typeView2)
        contentView.addSubViews(view: name)
        descri.numberOfLines = 0
        descri.textAlignment = .center
        name.textAlignment = .center
        setUpContraints()
    }
    
  
    func setUpContraints(){
        name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        name.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9).isActive = true
        name.centerX(inView: contentView)
        typeView1.topAnchor.constraint(equalTo: name.bottomAnchor,constant: 15).isActive = true
        typeView1.heightAnchor.constraint(equalToConstant: 35).isActive = true
        typeView1.widthAnchor.constraint(equalToConstant: 100).isActive = true
        typeView1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        typeView2.heightAnchor.constraint(equalToConstant: 35).isActive = true
        typeView2.widthAnchor.constraint(equalToConstant: 100).isActive = true
        typeView2.leadingAnchor.constraint(equalTo: typeView1.trailingAnchor, constant: 4).isActive = true
        typeView2.topAnchor.constraint(equalTo: typeView1.topAnchor).isActive = true
        typeView2.bottomAnchor.constraint(equalTo: typeView1.bottomAnchor).isActive = true
        descri.centerX(inView: contentView)
        descri.topAnchor.constraint(equalTo: typeView1.bottomAnchor, constant: 15).isActive = true
        descri.widthAnchor.constraint(equalTo: name.widthAnchor).isActive = true
        descri.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10).isActive = true
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
