//
//  MainViewController.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 13/10/22.
//

import Foundation
import UIKit


class MainViewController: UITabBarController{
    
    let gradientlayer = CAGradientLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        UITabBar.appearance().barTintColor = .black
        UITabBar.appearance().tintColor = .black
        UITabBar.appearance().backgroundColor = .primaryColor
        let homeVC = UINavigationController(rootViewController: SpeciesListRouter.createModule())
        let favouriteVC = UINavigationController(rootViewController: FavouriteVC())
        let notifyVC = UINavigationController(rootViewController: NotifyVC())
        setupHomeTabBar()
        homeVC.title = "Pokemon"
        favouriteVC.title = "Favourite"
        notifyVC.title = "Items"
        self.setViewControllers([homeVC,favouriteVC,notifyVC], animated: false)
        guard let items = self.tabBar.items else{return}
        let image = ["home","star","Items"]
        for i in 0...2{
            items[i].image = UIImage(named: image[i])
        }
    }
    
    func setupHomeTabBar(){
        let firstColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        let secondColor = UIColor(red: 210/255, green: 248/255, blue: 210/255, alpha: 1)
        setGradientBackground(colorOne: secondColor, colorTwo: firstColor)

    }
    
    
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor)  {
        gradientlayer.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        gradientlayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientlayer.locations = [0, 1]
        gradientlayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientlayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        self.tabBar.layer.insertSublayer(gradientlayer, at: 0)
        
    }


    func FetchEmployee(){
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(path[0])
        do {
            guard let result =  try  PersistanceStorage.shared.context.fetch(SpeciesDataModel.fetchRequest()) as? [SpeciesDataModel] else {return}
            result.forEach ({ debugPrint($0.name)
            })
        } catch let error {
            debugPrint(error)
        }

    }
}



class FavouriteVC: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        title = "Moves"
    }
}

class NotifyVC: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        title = "Items"
    }
}
