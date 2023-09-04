//
//  CustomHeaderView.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 29/10/22.
//

import Foundation
import UIKit

class CustomHeaderView: UIView {
    
    var backgroundImageName: String
    var titleLabelText: String
    var headerIconName: String
    var bgBackgroundColor: UIColor
    
    init(frame: CGRect, backgroundImage: String, title: String, iconImage: String, bgBackgroundColor: UIColor) {
        self.backgroundImageName = backgroundImage
        self.titleLabelText = title
        self.headerIconName = iconImage
        self.bgBackgroundColor = bgBackgroundColor
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "pokeball")
        image.alpha = 0.4
        image.contentMode = .scaleAspectFit
        return image
    }()
    
     lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = titleLabelText.uppercased()
        label.translatesAutoresizingMaskIntoConstraints = false
         label.font = UIFont(name: "Avenir", size: 26)
        label.textAlignment = .center
        return label
    }()
    
    lazy var headerIcon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: headerIconName)
        return image
    }()
    
     lazy var colorView: UIView = {
        let colorView = UIView()
        colorView.translatesAutoresizingMaskIntoConstraints = false
        colorView.backgroundColor = bgBackgroundColor
         colorView.alpha = 0.6
        return colorView
    }()
    
    private func setUpView() {
        addSubview(backgroundImage)
        addSubview(colorView)
        addSubview(titleLabel)
        addSubview(headerIcon)
        constraintsSetUp()
        titleLabel.isHidden = true
    }
    
    private func constraintsSetUp() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor,constant: -50),
//            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            colorView.topAnchor.constraint(equalTo: topAnchor),
            colorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            colorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            colorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            headerIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
            headerIcon.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            headerIcon.widthAnchor.constraint(equalToConstant: 280),
            headerIcon.heightAnchor.constraint(equalToConstant: 280),
        ])
    }
    
    func decrementColorAlpha(offset: CGFloat) {
        if colorView.alpha <= 1 {
            let alphaOffset = (offset/500)/85
            colorView.alpha += alphaOffset
        }
    }
    
    func decrementHeaderIconAlpha(offset: CGFloat) {
        if headerIcon.alpha >= 0 {
//            let alphaOffset = max((offset - 65)/85.0, 0)
            let alphaOffset = (offset/500)/85
            headerIcon.alpha -= alphaOffset
        }
    }
    
    func incrementColorAlpha(offset: CGFloat) {
        if colorView.alpha >= 0.6 {
            let alphaOffset = (offset/200)/85
            colorView.alpha -= alphaOffset
        }
    }
    
    func incrementHeaderIconAlpha(offset: CGFloat) {
        if headerIcon.alpha <= 1 {
//            let alphaOffset = max((offset - 65)/85, 0)
            let alphaOffset = (offset/200)/85
            headerIcon.alpha += alphaOffset
        }
    }
}
