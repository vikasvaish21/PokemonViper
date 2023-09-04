//
//  StatiticsTableCell.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 29/11/22.
//

import Foundation
import UIKit
class StatiticsTableCell: UITableViewCell{
    static var reuseIdentifier = "StatiticsTableCell"
    var statLabel = MyLabel(textSize: 26, color: .black, alignment: .center)
//    var pokemonData = SinglePokemon()
    var hpLabel = UILabel()
    var ATKLabel = UILabel()
    var defLabel = UILabel()
    var satkLabel = UILabel()
    var sdefLabel = UILabel()
    var spdLabel = UILabel()
    var progressBarHP = GradientHorizontalProgressBar()
    var prograssBarATK = GradientHorizontalProgressBar()
    var prograssBarDEF = GradientHorizontalProgressBar()
    var prograssBarSATK = GradientHorizontalProgressBar()
    var prograssBarSDEF = GradientHorizontalProgressBar()
    var prograssBarSPD = GradientHorizontalProgressBar()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)  {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        statLabel.translatesAutoresizingMaskIntoConstraints = false
        hpLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubViews(view: statLabel)
        setUpContraints()
        setUpProgressBarStack()
        setUpLabeltext()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpContraints()  {
        statLabel.anchor(top: contentView.topAnchor, paddingTop: 10,width: 150,height: 60)
        statLabel.centerX(inView: contentView)
    }
    
    func setUpLabeltext(){
        hpLabel.setProgessBarLabeltext()
        ATKLabel.setProgessBarLabeltext()
        defLabel.setProgessBarLabeltext()
        satkLabel.setProgessBarLabeltext()
        sdefLabel.setProgessBarLabeltext()
        spdLabel.setProgessBarLabeltext()
    }
    
    func setUpProgressBarStack() {
        let progressBarStack = UIStackView(arrangedSubviews: [progressBarHP,prograssBarATK,prograssBarDEF,prograssBarSATK,prograssBarSDEF,prograssBarSPD])
        progressBarStack.axis = .vertical
        progressBarStack.distribution = .fillEqually
        progressBarStack.spacing = 10
        contentView.addSubview(progressBarStack)
        progressBarStack.translatesAutoresizingMaskIntoConstraints = false
        progressBarStack.anchor(top: statLabel.bottomAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 10 ,paddingBottom: 20, paddingRight: 10, height: 120)
        let statLabelStack = UIStackView(arrangedSubviews: [hpLabel,ATKLabel,defLabel,satkLabel,sdefLabel,spdLabel])
        statLabelStack.axis = .vertical
        statLabelStack.distribution = .fillEqually
        statLabelStack.spacing = 10
        contentView.addSubview(statLabelStack)
        statLabelStack.anchor(top: progressBarStack.topAnchor, left: contentView.leftAnchor, bottom: progressBarStack.bottomAnchor, right: progressBarStack.leftAnchor,paddingLeft: 10,width: 75)
    }
    
    func setUpStatLabels(_ stat:[Stat]) {
        hpLabel.text   = "HP       \(stat[0].baseStat)"
        ATKLabel.text  = "ATK     \(stat[1].baseStat)"
        defLabel.text  = "DEF     \(stat[2].baseStat)"
        satkLabel.text = "SATK   \(stat[3].baseStat)"
        sdefLabel.text = "SDEF   \(stat[4].baseStat)"
        spdLabel.text  = "SPD     \(stat[5].baseStat)"
    }
    
    func setupStatData(_ stat : [Stat]) {
        progressBarHP.setProgress(to: CGFloat(CGFloat(stat[0].baseStat)/200))
        prograssBarATK.setProgress(to: CGFloat(CGFloat(stat[1].baseStat)/200))
        prograssBarDEF.setProgress(to: CGFloat(CGFloat(stat[2].baseStat)/200))
        prograssBarSATK.setProgress(to: CGFloat(CGFloat(stat[3].baseStat)/200))
        prograssBarSDEF.setProgress(to: CGFloat(CGFloat(stat[4].baseStat)/200))
        prograssBarSPD.setProgress(to: CGFloat(CGFloat(stat[5].baseStat)/200))
    }
}
