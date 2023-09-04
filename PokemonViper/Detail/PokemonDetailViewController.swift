//
//  PokemonDetailViewController.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 14/10/22.
//

import Foundation
import UIKit
import Kingfisher

class PokemonDetailViewController : UIViewController,PokemonDetailViewProtocol{
    
    var presenter: PokemonDetailPresenterProtocol!
    private let toolbarHeight: CGFloat = 320
    
    
    private lazy var pokemonTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.cornerRadius = 45
        tableView.estimatedRowHeight = 50
        tableView.separatorStyle = .none
        tableView.register(pokemonDescriptionCell.self, forCellReuseIdentifier: pokemonDescriptionCell.reuseIdentifier)
        tableView.register(StatiticsTableCell.self, forCellReuseIdentifier: StatiticsTableCell.reuseIdentifier)
        tableView.register(EvolutionTableCell.self, forCellReuseIdentifier: EvolutionTableCell.reuseIdentifier)
        return tableView
    }()
    
    private lazy var headerContainerView: CustomHeaderView = {
        let headerView = CustomHeaderView(frame: CGRect.zero, backgroundImage: "pokeball", title: "Artículos", iconImage: "article", bgBackgroundColor: UIColor.clear)
        headerView.clipsToBounds = true
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setupViewContent()
        tabBarController?.tabBar.isHidden = true
        
    }
    
    private lazy var headerHeightConstraint: NSLayoutConstraint = {
        let headerHeightConstraint = headerContainerView.heightAnchor.constraint(equalToConstant: 320)
        headerHeightConstraint.isActive = true
        return headerHeightConstraint
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pokemonTableView.reloadData()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        headerContainerView.removeFromSuperview()
        
    }
    
    func setupViewContent(){
        view.addSubview(headerContainerView)
        view.addSubview(pokemonTableView)
        constraintsSetUp()
    }

    private func constraintsSetUp() {
        NSLayoutConstraint.activate([
            headerContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pokemonTableView.topAnchor.constraint(equalTo: headerContainerView.bottomAnchor),
            pokemonTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pokemonTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pokemonTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func animateHeader() {
        headerHeightConstraint.constant = toolbarHeight
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: { [weak self] in
            self?.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func setNavigationBarColor(_ type: PokemonType) {
        switch type{
        case .Bug:
            setNaviagtionBar(firstColor: UIColor.bugFirstColor, secondColor: UIColor.bugSecondColor)
            setGradientOnView(view,UIColor.bugFirstColor,UIColor.bugSecondColor)
            setGradientOnView(headerContainerView.colorView,UIColor.bugFirstColor,UIColor.bugSecondColor)
            
        case .Electric:
            setNaviagtionBar(firstColor: UIColor.electricFirstColor, secondColor: UIColor.electricSecondColor)
            setGradientOnView(headerContainerView.colorView,UIColor.electricFirstColor,UIColor.electricSecondColor)
            setGradientOnView(view,UIColor.electricFirstColor,UIColor.electricSecondColor)
        case .Grass:
            setNaviagtionBar(firstColor: UIColor.grassFirstColor, secondColor: UIColor.grassSecondColor)
            setGradientOnView(headerContainerView.colorView,UIColor.grassFirstColor,UIColor.grassSecondColor)
            setGradientOnView(view,UIColor.grassFirstColor,UIColor.grassSecondColor)
            
        case .Dragon:
            setNaviagtionBar(firstColor: UIColor.dragonFirstColor, secondColor: UIColor.dragonSecondColor)
            setGradientOnView(headerContainerView.colorView,UIColor.dragonFirstColor,UIColor.dragonSecondColor)
            setGradientOnView(view,UIColor.dragonFirstColor,UIColor.dragonSecondColor)
        case .Fight:
            setNaviagtionBar(firstColor: UIColor.fightFirstColor, secondColor: UIColor.fightSecondColor)
            setGradientOnView(headerContainerView.colorView,UIColor.fightFirstColor,UIColor.fightSecondColor)
            setGradientOnView(view,UIColor.fightFirstColor,UIColor.fightSecondColor)
        case .Flying:
            setNaviagtionBar(firstColor: UIColor.flyingFirstColor, secondColor: UIColor.flyingSecondColor)
            setGradientOnView(headerContainerView.colorView,UIColor.flyingFirstColor,UIColor.flyingSecondColor)
            setGradientOnView(view,UIColor.flyingFirstColor,UIColor.flyingSecondColor)
        case .Fairy:
            setNaviagtionBar(firstColor: UIColor.fairyFirstColor, secondColor: UIColor.fairySecondColor)
            setGradientOnView(headerContainerView.colorView,UIColor.fairyFirstColor,UIColor.fairySecondColor)
            setGradientOnView(view,UIColor.fairyFirstColor,UIColor.fairySecondColor)
        case .Ghost:
            setNaviagtionBar(firstColor: UIColor.ghostFirstColor, secondColor: UIColor.ghostSecondColor)
            setGradientOnView(headerContainerView.colorView,UIColor.ghostFirstColor,UIColor.ghostSecondColor)
            setGradientOnView(view,UIColor.ghostFirstColor,UIColor.ghostSecondColor)
        case .Fire:
            setNaviagtionBar(firstColor: UIColor.fireFirstColor, secondColor: UIColor.fireSecondColor)
            setGradientOnView(headerContainerView.colorView,UIColor.fireFirstColor,UIColor.fireSecondColor)
            setGradientOnView(view,UIColor.fireFirstColor,UIColor.fireSecondColor)
        case .Ground:
            setNaviagtionBar(firstColor: UIColor.groundFirstColor, secondColor: UIColor.groundSecondColor)
            setGradientOnView(headerContainerView.colorView,UIColor.groundFirstColor,UIColor.groundSecondColor)
            setGradientOnView(view,UIColor.groundFirstColor,UIColor.groundSecondColor)
        case .Poison:
            setNaviagtionBar(firstColor: UIColor.poisonfirstColor, secondColor: UIColor.poisonSecondColor)
            setGradientOnView(headerContainerView.colorView,UIColor.poisonfirstColor,UIColor.poisonSecondColor)
            setGradientOnView(view,UIColor.poisonfirstColor,UIColor.poisonSecondColor)
        case .Normal:
            setNaviagtionBar(firstColor: UIColor.normalFirstColor, secondColor: UIColor.normalSecondColor)
            setGradientOnView(headerContainerView.colorView,UIColor.normalFirstColor,UIColor.normalSecondColor)
            setGradientOnView(view,UIColor.normalFirstColor,UIColor.normalSecondColor)
        case .Psychic:
            setNaviagtionBar(firstColor: UIColor.psychicFirstColor, secondColor: UIColor.psychicSecondColor)
            setGradientOnView(headerContainerView.colorView,UIColor.psychicFirstColor,UIColor.psychicSecondColor)
            setGradientOnView(view,UIColor.psychicFirstColor,UIColor.psychicSecondColor)
        case .Steel:
            setNaviagtionBar(firstColor: UIColor.steelFirstColor, secondColor: UIColor.steelSecondColor)
            setGradientOnView(headerContainerView.colorView,UIColor.steelFirstColor,UIColor.steelSecondColor)
            setGradientOnView(view,UIColor.steelFirstColor,UIColor.steelSecondColor)
        case .Rock:
            setNaviagtionBar(firstColor: UIColor.rockFirstColor, secondColor: UIColor.rockSecondColor)
            setGradientOnView(headerContainerView.colorView,UIColor.rockFirstColor,UIColor.rockSecondColor)
            setGradientOnView(view,UIColor.rockFirstColor,UIColor.rockSecondColor)
        case .Water:
            setNaviagtionBar(firstColor: UIColor.waterFirstColor, secondColor: UIColor.waterSecondColor)
            setGradientOnView(headerContainerView.colorView,UIColor.waterFirstColor,UIColor.waterSecondColor)
            setGradientOnView(view,UIColor.waterFirstColor,UIColor.waterSecondColor)
        case .Dark:
            setNaviagtionBar(firstColor: UIColor.darkFirstColor, secondColor: UIColor.darkSecondColor)
            setGradientOnView(headerContainerView.colorView,UIColor.darkFirstColor,UIColor.darkSecondColor)
            setGradientOnView(view,UIColor.darkFirstColor,UIColor.darkSecondColor)
        case .Ice:
            setNaviagtionBar(firstColor: UIColor.IceFirstColor, secondColor: UIColor.IceSecondColor)
            setGradientOnView(headerContainerView.colorView,UIColor.IceFirstColor,UIColor.IceSecondColor)
            setGradientOnView(view,UIColor.IceFirstColor,UIColor.IceSecondColor)
        }
    }
    
   
    
    
    func setNaviagtionBar(firstColor: UIColor,secondColor: UIColor){
        navigationItem.title = "Pokemon Detail"
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
    
    
    func setUpImageView(_ url: URL){
        headerContainerView.headerIcon.kf.setImage(with: url)
    }
    
    func setHeaderContentData(name: String){
        headerContainerView.titleLabel.text = name
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
    
    
    
    func reloadData(){
        pokemonTableView.reloadData()
    }


}

extension PokemonDetailViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let cell = pokemonTableView.dequeueReusableCell(withIdentifier: pokemonDescriptionCell.reuseIdentifier, for: indexPath) as! pokemonDescriptionCell
            cell.descri.text = presenter.setPokemonDescription()
            cell.name.text = presenter.setPokemonName().capitalized
            cell.typeView1.image = UIImage(named: presenter.setPokemonType1())
            cell.typeView2.image = UIImage(named: presenter.setPokemonType2())
            return cell
        }
        if indexPath.row == 1{
            let cell = pokemonTableView.dequeueReusableCell(withIdentifier: StatiticsTableCell.reuseIdentifier, for: indexPath) as! StatiticsTableCell
            cell.statLabel.text = "Statistics"
            cell.progressBarHP.color = presenter.statiticColorType()
            cell.prograssBarATK.color = presenter.statiticColorType()
            cell.prograssBarDEF.color = presenter.statiticColorType()
            cell.prograssBarSATK.color = presenter.statiticColorType()
            cell.prograssBarSDEF.color = presenter.statiticColorType()
            cell.prograssBarSPD.color = presenter.statiticColorType()
            if let statData = presenter.pokemonStatData(){
                cell.setupStatData(statData)
                cell.setUpStatLabels(statData)
            }
            
            return cell
        } else if indexPath.row == 2{
            let cell = pokemonTableView.dequeueReusableCell(withIdentifier: EvolutionTableCell.reuseIdentifier, for: indexPath) as! EvolutionTableCell
            cell.titleLabel.text = "Evolutions"
            var megaPokemon = ([""],[""])
            presenter.numberOfEvolutions { [self] data in
                cell.totalEvolutions = data
                cell.evolutionNames = presenter.evolutionNames
                cell.secondEvolutionName = presenter.secondEvolutionName
                cell.evolutionStone = presenter.evolutionStone
                cell.secondEvolutionStone = presenter.secondEvolutionStone
                cell.evolutionHappinessLevel = presenter.evolutionHappinessLevel
                cell.secondEvolutionHappinessLavel = presenter.secondEvolutionHappinessLavel
                cell.firstEvolutionSpecie = presenter.firstEvolutionSpecie
                cell.secondEvolutionSpecie = presenter.secondEvolutionSpecie
                cell.evolutionSequence = presenter.setUpPokemonSequence()
                var value = presenter.setBasePokemon(presenter.secondEvolutionName.values.count)
                if !value.0.isEmpty && !value.1.isEmpty{
                   megaPokemon = getAllEvolutionPokemon(value)
                }else if !presenter.setBasePokemon(presenter.evolutionNames.values.count).0.isEmpty && !presenter.setBasePokemon(presenter.evolutionNames.values.count).1.isEmpty && !presenter.totalMegaPokemons.isEmpty{
                    megaPokemon = getAllEvolutionPokemon(([presenter.evolutionNames.keys.first!],Array(presenter.totalMegaPokemons)))
                }else if !presenter.totalMegaPokemons.isEmpty{
                    megaPokemon = getAllEvolutionPokemon(([presenter.setPokemonName()],Array(presenter.totalMegaPokemons)))
                }else{
                    megaPokemon = value
                }
            }
            if !megaPokemon.0.isEmpty && !megaPokemon.1.isEmpty{
                cell.baseEvolutionArray = megaPokemon.0
                cell.evolutionArray = megaPokemon.1
                
            }else{
                cell.baseEvolutionArray = megaPokemon.0
                cell.evolutionArray = megaPokemon.1
            }
            var imageValue = presenter.setEvolutionPokmonImages((presenter.mainBasePokemonArray,presenter.mainEvolutionPokemonArray))
            cell.basePokemonImgaeArray = imageValue.0
            cell.evolutionPokemonImageArray = imageValue.1
            cell.reloadTableView()
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2{
            if !presenter.mainBasePokemonArray.isEmpty && !presenter.mainEvolutionPokemonArray.isEmpty{
                let height = (presenter.mainBasePokemonArray.count) * 120
                return CGFloat(height)+80.0
            }
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func getAllEvolutionPokemon(_ value:([String],[String])) -> ([String],[String]){
        let megaValue = presenter.setMegaEvolutionPokemon(presenter.totalMegaPokemons, value)
        return megaValue
    }
    
}

extension PokemonDetailViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // If we are pulling downwards we want to stretch the header view
        if scrollView.contentOffset.y < 0 {
            // We use the addition assignment operator in our headerHeightConstraint variable every time we scroll up (abs to get the absolute number).
            headerHeightConstraint.constant += abs(scrollView.contentOffset.y)
            // Make the color lighter and the icon appear when scrolling up
            headerContainerView.incrementColorAlpha(offset: headerHeightConstraint.constant)
            headerContainerView.incrementHeaderIconAlpha(offset: headerHeightConstraint.constant)
            headerContainerView.titleLabel.isHidden = true
            // If we are pulling downwards we want to collapsable the header view
            // The last check ensures that if we scroll up too quickly the header view will stay at 64 points (the standard navigation controller height is 64 points).
        } else if scrollView.contentOffset.y > 0 && headerHeightConstraint.constant >= 65 {
            // We dont want the header view to move up too quickly, that's why we divide by 100.
            headerHeightConstraint.constant -= scrollView.contentOffset.y/100
            // Make the color darker and the icon desapear when scrolling down
            headerContainerView.decrementColorAlpha(offset: scrollView.contentOffset.y)
            headerContainerView.decrementHeaderIconAlpha(offset: headerHeightConstraint.constant)
            // Stop the headerView to being smaller than 65 when scrolling down a lot
            if headerHeightConstraint.constant < 65 {
                headerContainerView.titleLabel.isHidden = false
                headerHeightConstraint.constant = 65
            }
        }
    }
    
    // We set the height constraint back to our original height of 150 and animate the view with damping over 0.4 seconds in this 2 functions.
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if headerHeightConstraint.constant > toolbarHeight {
            animateHeader()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if headerHeightConstraint.constant > toolbarHeight {
            animateHeader()
        }
    }
}
