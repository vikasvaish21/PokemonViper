//
//  MoveTableViewCell.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 08/09/23.
//

import Foundation
import UIKit

class MoveTableViewCell: UITableViewCell {
    static var reuseIdentifier = "MoveTableViewCell"
    var titleLabel = MyLabel(textSize: 20, color: .black, alignment: .center)
    var movesLevel = [(String,String)]()
    var moveType = [String:String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpContraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private lazy var pokemonMoveTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.isScrollEnabled = false
        tableView.register(SingleMoveTableviewCell.self, forCellReuseIdentifier: SingleMoveTableviewCell.reuseIdentifier)
        return tableView
    }()
    
    func setUpContraint() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(pokemonMoveTableView)
        titleLabel.anchor(top: contentView.topAnchor,width: 150,height: 60)
        titleLabel.centerX(inView: contentView)
        pokemonMoveTableView.anchor(top: titleLabel.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor)
    }
    
    func reloadTableView() {
        pokemonMoveTableView.reloadData()
    }
    
    
    
}


extension MoveTableViewCell: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movesLevel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pokemonMoveTableView.dequeueReusableCell(withIdentifier: SingleMoveTableviewCell.reuseIdentifier, for: indexPath) as! SingleMoveTableviewCell
        cell.attackLabel.text = movesLevel[indexPath.row].0.replacingOccurrences(of: "-", with: " ").capitalized
        cell.levelLabel.text = "Level \(movesLevel[indexPath.row].1)"
        cell.moveType.image = UIImage(named: moveType[movesLevel[indexPath.row].0] ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }


}
