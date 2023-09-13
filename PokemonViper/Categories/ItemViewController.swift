//
//  ItemViewController.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 13/09/23.
//

import Foundation
import UIKit
class ItemViewController: UIViewController,ItemViewProtocol{
    
    var presenter: ItemPresenterProtocol?
    private let ItemTableView = UITableView()
    private let itemSearchBar = UISearchBar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetNaviagtionBar()
        setUpSearchBar() 
        setUpTableview()
        presenter?.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SetNaviagtionBar()
        tabBarController?.tabBar.isHidden = false
    }
    
    
    func SetNaviagtionBar(){
        navigationItem.title = "Item Categories"
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
        view.addSubview(ItemTableView)
        ItemTableView.backgroundColor = UIColor(red: 210/255, green: 248/255, blue: 210/255, alpha: 1)
        ItemTableView.backgroundColor = .white
        ItemTableView.delegate = self
        ItemTableView.dataSource = self
        ItemTableView.register(ItemTableViewCell.self, forCellReuseIdentifier: ItemTableViewCell.reuseId)
        ItemTableView.anchor(top: itemSearchBar.bottomAnchor,left: itemSearchBar.leftAnchor,bottom: view.bottomAnchor,right: view.rightAnchor)
        
    }
    
    func setUpSearchBar() {
        view.addSubview(itemSearchBar)
        itemSearchBar.backgroundColor = .white
        itemSearchBar.showsCancelButton = false
        itemSearchBar.delegate = self
        itemSearchBar.anchor(top: view.layoutMarginsGuide.topAnchor,left: view.leftAnchor,right: view.rightAnchor)
        itemSearchBar.barTintColor = UIColor.primaryColor
        itemSearchBar.searchTextField.backgroundColor = .white
    }
    
    func reloadData() {
        ItemTableView.reloadData()
    }
    
}

extension ItemViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ItemTableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.reuseId, for: indexPath) as! ItemTableViewCell
        cell.myLabel.text = presenter?.setUpText(indexPath.row).replacingOccurrences(of: "-", with: " ").capitalized
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectCategory(at: indexPath.row)
    }
    
    
}

extension ItemViewController: UISearchBarDelegate{
    
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
