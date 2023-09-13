//
//  MovesDetailViewController.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 12/09/23.
//

import Foundation
import UIKit

class MovesDetailViewController :UIViewController,MovesDetailViewProtocol{
   
    
    var presenter : MovesDetailPresenterProtocol!
    private let toolbarHeight: CGFloat = 320
    
    let mainView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 48
        view.layer.maskedCorners =  [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return view
    }()
    
    let typeImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = view.frame.size.height/2
        return view
    }()
    
    let secondryTypeImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = view.frame.size.height/2
        return view
    }()
    
    let basePowerLabel = MyLabel(textSize: 16, color: .gray, alignment: .center)
    let accuracyLabel = MyLabel(textSize: 16, color: .gray, alignment: .center)
    let PPLabel = MyLabel(textSize: 16, color: .gray, alignment: .center)
    let basePowerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    let accuracyView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let PPView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    
    
    let statsStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = UIStackView.Distribution.fillEqually
        stackView.spacing = 1
        stackView.backgroundColor = UIColor.lightGray
        return stackView
    }()
    
    
    let descriptionLabel = MyLabel(textSize: 16, color: .gray, alignment: .center)
    let typeLabel = MyLabel(textSize: 40, color: .black, alignment: .center)
    let basePowerValue = MyLabel(textSize: 20, color: .black, alignment: .center)
    let accuracyValue = MyLabel(textSize: 20, color: .black, alignment: .center)
    let PPValue = MyLabel(textSize: 20, color: .black, alignment: .center)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        view.addSubview(mainView)
        view.addSubview(typeImageView)
        mainView.addSubview(typeLabel)
        mainView.addSubview(secondryTypeImageView)
        mainView.addSubview(descriptionLabel)
        mainView.addSubview(statsStackView)
        statsStackView.addArrangedSubview(basePowerView)
        statsStackView.addArrangedSubview(accuracyView)
        statsStackView.addArrangedSubview(PPView)
        basePowerView.addSubview(basePowerLabel)
        accuracyView.addSubview(accuracyLabel)
        accuracyView.addSubview(accuracyValue)
        basePowerView.addSubview(basePowerValue)
        PPView.addSubview(PPValue)
        PPView.addSubview(PPLabel)
        setUpConstraint()
        statLabelText()
        tabBarController?.tabBar.isHidden = true
        
    }
   
    
    func setUpConstraint() {
        let height = (view.frame.size.height) * (3/4)
        mainView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor,height: height)
        typeImageView.anchor(top: mainView.topAnchor,paddingTop: -37.5,width: 75,height: 75)
        typeImageView.centerX(inView: mainView)
        typeLabel.anchor(top: typeImageView.bottomAnchor, paddingTop: 10)
        typeLabel.centerX(inView: mainView)
        secondryTypeImageView.anchor(top: typeLabel.bottomAnchor, paddingTop: 10,width: 110,height: 40)
        secondryTypeImageView.centerX(inView: mainView)
        descriptionLabel.anchor(top: secondryTypeImageView.bottomAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 10, paddingLeft: 10,paddingRight: 10)
        descriptionLabel.centerX(inView: mainView)
        statsStackView.anchor(top: descriptionLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20,paddingLeft: 10, paddingRight: 10, height: 100)
        basePowerLabel.anchor(top: basePowerView.topAnchor, left: basePowerView.leftAnchor, right:  basePowerView.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingRight: 10, height: 20)
        accuracyLabel.anchor(top: accuracyView.topAnchor, left: accuracyView.leftAnchor, right:  accuracyView.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingRight: 10, height: 20)
        PPLabel.anchor(top: PPView.topAnchor, left: PPView.leftAnchor, right:  PPView.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingRight: 10, height: 20)
        PPValue.anchor(top: PPLabel.bottomAnchor, paddingTop: 30)
        PPValue.centerX(inView: PPView)
//        accuracyValue.anchor(top: accuracyView.topAnchor, left: accuracyView.leftAnchor, right:  accuracyView.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingRight: 10, height: 20)
        accuracyValue.anchor(top: accuracyLabel.bottomAnchor, paddingTop: 30)
        accuracyValue.centerX(inView: accuracyView)
//        basePowerValue.anchor(top: basePowerView.topAnchor, left: basePowerView.leftAnchor, right:  basePowerView.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingRight: 10, height: 20)
        basePowerValue.anchor(top: basePowerLabel.bottomAnchor, paddingTop: 30)
        basePowerValue.centerX(inView: basePowerView)
    }
    
    func getTypeData(_ move: MovesDetailSavedData){
        typeImageView.image = UIImage(named: move.type ?? "")
        typeLabel.text = move.name?.replacingOccurrences(of: "-", with: " ").capitalized
        secondryTypeImageView.image = UIImage(named: move.type?.capitalized ?? "")
        PPValue.text = "\(move.pp ?? 0)"
        accuracyValue.text = "\(move.accuracy ?? 0)%"
        basePowerValue.text = "\(move.power ?? 0)"
    }
    
    func getDescriptionData(_ text: String){
        descriptionLabel.text = text.replacingOccurrences(of: "\n\n", with: "")
    }
    
    
    
    
    func setNavigationBarColor(_ type: PokemonType) {
        switch type{
        case .Bug:
            setNaviagtionBar(firstColor: UIColor.bugFirstColor, secondColor: UIColor.bugSecondColor)
            setGradientOnView(view,UIColor.bugFirstColor,UIColor.bugSecondColor)
            basePowerLabel.textColor = UIColor.bugFirstColor
            accuracyLabel.textColor = UIColor.bugFirstColor
            PPLabel.textColor = UIColor.bugFirstColor
            
        case .Electric:
            setNaviagtionBar(firstColor: UIColor.electricFirstColor, secondColor: UIColor.electricSecondColor)
            setGradientOnView(view,UIColor.electricFirstColor,UIColor.electricSecondColor)
            basePowerLabel.textColor = UIColor.electricFirstColor
            accuracyLabel.textColor = UIColor.electricFirstColor
            PPLabel.textColor = UIColor.electricFirstColor
        case .Grass:
            setNaviagtionBar(firstColor: UIColor.grassFirstColor, secondColor: UIColor.grassSecondColor)
            setGradientOnView(view,UIColor.grassFirstColor,UIColor.grassSecondColor)
            basePowerLabel.textColor = UIColor.grassFirstColor
            accuracyLabel.textColor = UIColor.grassFirstColor
            PPLabel.textColor = UIColor.grassFirstColor
            
        case .Dragon:
            setNaviagtionBar(firstColor: UIColor.dragonFirstColor, secondColor: UIColor.dragonSecondColor)
            setGradientOnView(view,UIColor.dragonFirstColor,UIColor.dragonSecondColor)
            basePowerLabel.textColor = UIColor.dragonFirstColor
            accuracyLabel.textColor = UIColor.dragonFirstColor
            PPLabel.textColor = UIColor.dragonFirstColor
        case .Fight:
            setNaviagtionBar(firstColor: UIColor.fightFirstColor, secondColor: UIColor.fightSecondColor)
            setGradientOnView(view,UIColor.fightFirstColor,UIColor.fightSecondColor)
            basePowerLabel.textColor = UIColor.fightFirstColor
            accuracyLabel.textColor = UIColor.fightFirstColor
            PPLabel.textColor = UIColor.fightFirstColor
        case .Flying:
            setNaviagtionBar(firstColor: UIColor.flyingFirstColor, secondColor: UIColor.flyingSecondColor)
            setGradientOnView(view,UIColor.flyingFirstColor,UIColor.flyingSecondColor)
            basePowerLabel.textColor = UIColor.flyingFirstColor
            accuracyLabel.textColor = UIColor.flyingFirstColor
            PPLabel.textColor = UIColor.flyingFirstColor
        case .Fairy:
            setNaviagtionBar(firstColor: UIColor.fairyFirstColor, secondColor: UIColor.fairySecondColor)
            setGradientOnView(view,UIColor.fairyFirstColor,UIColor.fairySecondColor)
            basePowerLabel.textColor = UIColor.fairyFirstColor
            accuracyLabel.textColor = UIColor.fairyFirstColor
            PPLabel.textColor = UIColor.fairyFirstColor
        case .Ghost:
            setNaviagtionBar(firstColor: UIColor.ghostFirstColor, secondColor: UIColor.ghostSecondColor)
            setGradientOnView(view,UIColor.ghostFirstColor,UIColor.ghostSecondColor)
            basePowerLabel.textColor = UIColor.ghostFirstColor
            accuracyLabel.textColor = UIColor.ghostFirstColor
            PPLabel.textColor = UIColor.ghostFirstColor
        case .Fire:
            setNaviagtionBar(firstColor: UIColor.fireFirstColor, secondColor: UIColor.fireSecondColor)
            setGradientOnView(view,UIColor.fireFirstColor,UIColor.fireSecondColor)
            basePowerLabel.textColor = UIColor.fireFirstColor
            accuracyLabel.textColor = UIColor.fireFirstColor
            PPLabel.textColor = UIColor.fireFirstColor
        case .Ground:
            setNaviagtionBar(firstColor: UIColor.groundFirstColor, secondColor: UIColor.groundSecondColor)
            setGradientOnView(view,UIColor.groundFirstColor,UIColor.groundSecondColor)
            basePowerLabel.textColor = UIColor.groundFirstColor
            accuracyLabel.textColor = UIColor.groundFirstColor
            PPLabel.textColor = UIColor.groundFirstColor
        case .Poison:
            setNaviagtionBar(firstColor: UIColor.poisonfirstColor, secondColor: UIColor.poisonSecondColor)
            setGradientOnView(view,UIColor.poisonfirstColor,UIColor.poisonSecondColor)
            basePowerLabel.textColor = UIColor.poisonfirstColor
            accuracyLabel.textColor = UIColor.poisonfirstColor
            PPLabel.textColor = UIColor.poisonfirstColor
        case .Normal:
            setNaviagtionBar(firstColor: UIColor.normalFirstColor, secondColor: UIColor.normalSecondColor)
            setGradientOnView(view,UIColor.normalFirstColor,UIColor.normalSecondColor)
            basePowerLabel.textColor = UIColor.normalFirstColor
            accuracyLabel.textColor = UIColor.normalFirstColor
            PPLabel.textColor = UIColor.normalFirstColor
        case .Psychic:
            setNaviagtionBar(firstColor: UIColor.psychicFirstColor, secondColor: UIColor.psychicSecondColor)
            setGradientOnView(view,UIColor.psychicFirstColor,UIColor.psychicSecondColor)
            basePowerLabel.textColor = UIColor.psychicFirstColor
            accuracyLabel.textColor = UIColor.psychicFirstColor
            PPLabel.textColor = UIColor.psychicFirstColor
        case .Steel:
            setNaviagtionBar(firstColor: UIColor.steelFirstColor, secondColor: UIColor.steelSecondColor)
            setGradientOnView(view,UIColor.steelFirstColor,UIColor.steelSecondColor)
            basePowerLabel.textColor = UIColor.steelFirstColor
            accuracyLabel.textColor = UIColor.steelFirstColor
            PPLabel.textColor = UIColor.steelFirstColor
        case .Rock:
            setNaviagtionBar(firstColor: UIColor.rockFirstColor, secondColor: UIColor.rockSecondColor)
            setGradientOnView(view,UIColor.rockFirstColor,UIColor.rockSecondColor)
            basePowerLabel.textColor = UIColor.rockFirstColor
            accuracyLabel.textColor = UIColor.rockFirstColor
            PPLabel.textColor = UIColor.rockFirstColor
        case .Water:
            setNaviagtionBar(firstColor: UIColor.waterFirstColor, secondColor: UIColor.waterSecondColor)
            setGradientOnView(view,UIColor.waterFirstColor,UIColor.waterSecondColor)
            basePowerLabel.textColor = UIColor.waterFirstColor
            accuracyLabel.textColor = UIColor.waterFirstColor
            PPLabel.textColor = UIColor.waterFirstColor
        case .Dark:
            setNaviagtionBar(firstColor: UIColor.darkFirstColor, secondColor: UIColor.darkSecondColor)
            setGradientOnView(view,UIColor.darkFirstColor,UIColor.darkSecondColor)
            basePowerLabel.textColor = UIColor.darkFirstColor
            accuracyLabel.textColor = UIColor.darkFirstColor
            PPLabel.textColor = UIColor.darkFirstColor
        case .Ice:
            setNaviagtionBar(firstColor: UIColor.IceFirstColor, secondColor: UIColor.IceSecondColor)
            setGradientOnView(view,UIColor.IceFirstColor,UIColor.IceSecondColor)
            basePowerLabel.textColor = UIColor.IceFirstColor
            accuracyLabel.textColor = UIColor.IceFirstColor
            PPLabel.textColor = UIColor.IceFirstColor
        }
    }
    
    
    
    func setGradientOnView(_ currentView: UIView,_ firstColor: UIColor,_ secondColor: UIColor){
        let gradientLayer = CAGradientLayer()
        view.backgroundColor = firstColor
        gradientLayer.frame = view.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        currentView.layer.addSublayer(gradientLayer)
    }
    
    
    func setNaviagtionBar(firstColor: UIColor,secondColor: UIColor){
        navigationItem.title = "Pokemon Moves Details"
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backItem?.backButtonTitle = "Back"
        let flareGradientImage = CAGradientLayer.primaryGradient(on: navigationController!.navigationBar, firstColor, secondColor)
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            appearance.backgroundColor = UIColor(patternImage: flareGradientImage!)
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,.font: UIFont(name: "Avenir", size:20)!]
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
        }
    }
    
    func statLabelText(){
        basePowerLabel.text = "Base Power"
        accuracyLabel.text = "Accuracy"
        PPLabel.text = "PP"
        
    }
    
    
}
