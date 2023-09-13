//
//  CategoryItemsViewController.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 13/09/23.
//

import Foundation
import UIKit

class CategoryItemsViewController: UIViewController,CategoryItemsViewControllerProtocol{
    var presenter: CategoryItemsPresenterProtocol?
    private let categoryItemTableView = UITableView()
    private let categoryItemSearchBar = UISearchBar()
    var itemData : ItemResult? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        SetNaviagtionBar()
        setUpSearchBar()
        setUpTableview()
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SetNaviagtionBar()
        tabBarController?.tabBar.isHidden = false
    }
    
    func SetNaviagtionBar(){
        navigationItem.title = "\(itemData?.name.replacingOccurrences(of: "-", with: " ").capitalized ?? "") Items"
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backItem?.backButtonTitle = "Back"
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
    
    func setUpSearchBar() {
        view.addSubview(categoryItemSearchBar)
        categoryItemSearchBar.backgroundColor = .white
        categoryItemSearchBar.showsCancelButton = false
        categoryItemSearchBar.delegate = self
        categoryItemSearchBar.anchor(top: view.layoutMarginsGuide.topAnchor,left: view.leftAnchor,right: view.rightAnchor)
        categoryItemSearchBar.barTintColor = UIColor.primaryColor
        categoryItemSearchBar.searchTextField.backgroundColor = .white
    }
    
    
    
    func setUpTableview() {
        view.addSubview(categoryItemTableView)
        categoryItemTableView.backgroundColor = UIColor(red: 210/255, green: 248/255, blue: 210/255, alpha: 1)
        categoryItemTableView.backgroundColor = .white
        categoryItemTableView.delegate = self
        categoryItemTableView.dataSource = self
        categoryItemTableView.register(MovesTableViewCell.self, forCellReuseIdentifier: MovesTableViewCell.reuseId)
        categoryItemTableView.anchor(top: categoryItemSearchBar.bottomAnchor,left: categoryItemSearchBar.leftAnchor,bottom: view.bottomAnchor,right: view.rightAnchor)
        
    }
    
    func reloadData(){
        categoryItemTableView.reloadData()
    }
}
extension CategoryItemsViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categoryItemTableView.dequeueReusableCell(withIdentifier: MovesTableViewCell.reuseId, for: indexPath) as! MovesTableViewCell
        cell.myLabel.text = presenter?.setUpText(indexPath.row).replacingOccurrences(of: "-", with: " ").capitalized
        if let imageString = presenter?.setUpText(indexPath.row){
            if let imageURL = URL(string: Constants.pokemonItemImageUrl + imageString + ".png") {
                cell.pokemonMoveType.kf.setImage(with: imageURL)
            }
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectCategoryItem(at: indexPath.row)
    }
    
    
}

extension CategoryItemsViewController: UISearchBarDelegate{
    
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
