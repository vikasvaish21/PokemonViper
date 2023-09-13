//
//  MovesViewController.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 11/09/23.
//

import Foundation
import UIKit
class MovesViewController : UIViewController,MovesListViewProtocol{
    
    
    var presenter: MovesListPresenterProtocol?
    private let MovesTableView = UITableView()
    private let MovesSearchBar = UISearchBar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBar()
        setUpTableview()
        SetNaviagtionBar()
        MovesSearchBar.delegate = self
        MovesTableView.delegate = self
        MovesTableView.dataSource = self
        presenter?.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SetNaviagtionBar()
        tabBarController?.tabBar.isHidden = false
    }
    
    
    
    func setUpTableview() {
        view.addSubview(MovesTableView)
        MovesTableView.backgroundColor = UIColor(red: 210/255, green: 248/255, blue: 210/255, alpha: 1)
        MovesTableView.backgroundColor = .white
        MovesTableView.register(MovesTableViewCell.self, forCellReuseIdentifier: MovesTableViewCell.reuseId)
        MovesTableView.anchor(top: MovesSearchBar.bottomAnchor,left: MovesSearchBar.leftAnchor,bottom: view.bottomAnchor,right: view.rightAnchor)
        
    }
    
    func setUpSearchBar() {
        view.addSubview(MovesSearchBar)
        MovesSearchBar.backgroundColor = .white
        MovesSearchBar.showsCancelButton = false
        MovesSearchBar.anchor(top: view.layoutMarginsGuide.topAnchor,left: view.leftAnchor,right: view.rightAnchor)
        MovesSearchBar.barTintColor = UIColor.primaryColor
        MovesSearchBar.searchTextField.backgroundColor = .white
    }
    
    func SetNaviagtionBar(){
        navigationItem.title = "Moves"
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        let flareGradientImage = CAGradientLayer.primaryGradient(on: navigationController!.navigationBar,UIColor.primaryFirstColor,UIColor.primarySecondColor)

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
    
    func reloadData() {
        MovesTableView.reloadData()
    }
    
}


extension  MovesViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovesTableViewCell.reuseId, for: indexPath) as! MovesTableViewCell
        cell.myLabel.text = presenter?.setMoveNames(at: indexPath.row).replacingOccurrences(of: "-", with: " ").capitalized
        let imageName = presenter?.setMoveTypeImage(at: indexPath.row)
        cell.pokemonMoveType.image = UIImage(named: imageName ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectMove(at: indexPath.row)
    }
}


extension MovesViewController: UISearchBarDelegate{
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = true
        if searchText != ""{
            presenter?.getFilteredData(searchText)
        } else{
            presenter?.getFilteredData("")
            searchBar.showsCancelButton = false
            searchBar.endEditing(true)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter?.getFilteredData("")
        searchBar.text = nil
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }
}
