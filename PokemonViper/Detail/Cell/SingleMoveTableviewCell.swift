//
//  SingleMoveTableviewCell.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 08/09/23.
//

import UIKit

class SingleMoveTableviewCell: UITableViewCell {
    
    static var reuseIdentifier = "SingleMoveTableviewCell"
    let attackLabel = MyLabel(textSize: 16, color: .black, alignment: .center)
    let levelLabel = MyLabel(textSize: 13, color: .gray, alignment: .center)
    
    let moveType: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    
    let mainView: UIView = {
        let view = UIView()
        return view
    }()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.addSubview(mainView)
        mainView.addSubview(attackLabel)
        mainView.addSubview(moveType)
        mainView.addSubview(levelLabel)
        setUpContraint()
        // Configure the view for the selected state
    }
    
    
    func setUpContraint(){
        mainView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 5, paddingLeft: 10,paddingBottom: 5, paddingRight: 10, height: 60)
        attackLabel.anchor(top: mainView.topAnchor, left: mainView.leftAnchor, paddingTop: 10)
        moveType.anchor(top: mainView.topAnchor, right: mainView.rightAnchor, paddingTop: 10, paddingRight: 10, width: 40, height: 40)
        levelLabel.anchor(top:attackLabel.bottomAnchor,left: attackLabel.leftAnchor,paddingTop: 8)
        
        
    }
    

}
