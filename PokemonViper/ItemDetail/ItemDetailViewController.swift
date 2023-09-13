//
//  ItemDetailViewController.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 13/09/23.
//

import Foundation
import UIKit
class ItemDetailViewController: UIViewController, ItemDetailViewControllerProtocol{
    var presenter: ItemDetailPresenterProtocol?
    
    
    private let toolbarHeight: CGFloat = 320
    var itemData : Pocket?
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
    let itemLabel = MyLabel(textSize: 40, color: .black, alignment: .center)
    let costLabel = MyLabel(textSize: 20, color: .gray, alignment: .center)
    let descriptionLabel = MyLabel(textSize: 16, color: .gray, alignment: .center)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setNaviagtionBar(firstColor: UIColor.bugFirstColor,secondColor: UIColor.bugSecondColor)
        setGradientOnView(view,UIColor.bugFirstColor,UIColor.bugSecondColor)
        view.addSubview(mainView)
        view.addSubview(typeImageView)
        mainView.addSubview(itemLabel)
        mainView.addSubview(costLabel)
        mainView.addSubview(descriptionLabel)
        setUpConstraint()
        tabBarController?.tabBar.isHidden = true
    }
    
    func setUpConstraint() {
        let height = (view.frame.size.height) * (3/4)
        mainView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor,height: height)
        typeImageView.anchor(top: mainView.topAnchor,paddingTop: -37.5,width: 75,height: 75)
        typeImageView.centerX(inView: mainView)
        itemLabel.anchor(top: typeImageView.bottomAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 10, paddingLeft: 10,paddingRight: 10)
        itemLabel.centerX(inView: mainView)
        costLabel.anchor(top: itemLabel.bottomAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 10, paddingLeft: 10,paddingRight: 10)
        costLabel.centerX(inView: mainView)
        descriptionLabel.anchor(top: costLabel.bottomAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 10, paddingLeft: 10,paddingRight: 10)
        descriptionLabel.centerX(inView: mainView)
    }
    
    
    func setNaviagtionBar(firstColor: UIColor,secondColor: UIColor){
        navigationItem.title = "Item Details"
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
    
    
    func setUpData(_ data: ItemDetailModel) {
        DispatchQueue.main.async {
            self.typeImageView.kf.setImage(with: URL(string: data.sprites.spritesDefault))
            self.itemLabel.text = data.name.replacingOccurrences(of: "-", with: " ").capitalized
            self.costLabel.text = "\(data.cost) $"
            self.descriptionLabel.text = "\(data.effectEntries.first?.effect ?? "")"
        }  
    }
    
    
    
}
