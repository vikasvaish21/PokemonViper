//
//  SpeciesListViewController.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 08/10/22.
//


import UIKit
import Kingfisher
import CoreData


class SpeciesListViewController: UIViewController, SpeciesListViewProtocol{
 
    var presenter: SpeciesListPresenterProtocol?
    private let pokemonTableView = UITableView()
    private let pokemonSearchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpSearchBar()
        setUpTableview()
        pokemonSearchBar.delegate = self
        pokemonTableView.delegate = self
        pokemonTableView.dataSource = self
        pokemonTableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: PokemonTableViewCell.reuseId)
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SetNaviagtionBar()
        tabBarController?.tabBar.isHidden = false
    }
    
   
    
    func SetNaviagtionBar(){
        navigationItem.title = "Pokemon"
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
  
    
    
    func setUpTableview() {
        view.addSubview(pokemonTableView)
        pokemonTableView.backgroundColor = UIColor(red: 210/255, green: 248/255, blue: 210/255, alpha: 1)
        pokemonTableView.backgroundColor = .white
        pokemonTableView.anchor(top: pokemonSearchBar.bottomAnchor,left: pokemonSearchBar.leftAnchor,bottom: view.bottomAnchor,right: view.rightAnchor)
        
    }

    func setUpSearchBar() {
        view.addSubview(pokemonSearchBar)
        pokemonSearchBar.backgroundColor = .white
        pokemonSearchBar.showsCancelButton = false
        pokemonSearchBar.anchor(top: view.layoutMarginsGuide.topAnchor,left: view.leftAnchor,right: view.rightAnchor)
        pokemonSearchBar.barTintColor = UIColor.primaryColor
        pokemonSearchBar.searchTextField.backgroundColor = .white
    }
    

    
    func showLoadingIndicator() {
        
    }
    
    func hideLoadingIndicator() {
        
    }
    
    func reloadData() {
        pokemonTableView.reloadData()
    }
    
    func emptySpeciesList() {
        
    }
    
    func showErrorMessage(message: Error) {
        
    }
}


extension SpeciesListViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pokemonTableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.reuseId, for: indexPath) as! PokemonTableViewCell
        cell.myLabel.text = presenter?.getPokemonName(at: indexPath.row)
        if let urlString = presenter?.getPokemonImage(at: indexPath.row){
            if let imageURL = URL(string: urlString) {
                cell.myImage.kf.setImage(with: imageURL)
            }
        }
        cell.orderLabel.text = "#\(presenter?.getPokemonNumber(indexPath.row) ?? 0)"
        if let firstType = presenter?.setPokemonPrimaryType(indexPath.row){
            cell.primaryTypeImage.image = firstType
        }
        if let secondType = presenter?.setPokemonSecondryType(indexPath.row){
            cell.secondryTypeImage.image = secondType
        }
        cell.separatorInset = .zero
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectSpecies(at: indexPath.row)
    }
}


extension SpeciesListViewController: UISearchBarDelegate{
    
    
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


