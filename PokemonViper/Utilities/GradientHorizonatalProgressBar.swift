//
//  GradientHorizonatalProgressBar.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 29/11/22.
//

import Foundation
import UIKit

@IBDesignable
class GradientHorizontalProgressBar: UIView {
    @IBInspectable var color: UIColor = .gray {
        didSet { setNeedsDisplay() }
    }
    @IBInspectable var gradientColor: UIColor = .white {
        didSet { setNeedsDisplay() }
    }

    var progress: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
       
    }

    private let progressLayer = CALayer()
    private let gradientLayer = CAGradientLayer()
    private let backgroundMask = CAShapeLayer()
    var curProgress: CGFloat = 0.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
        createAnimation()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupLayers() {
        layer.addSublayer(gradientLayer)

        gradientLayer.mask = progressLayer
        gradientLayer.locations = [0.35, 0.5, 0.65]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        setProgress(to: progress)
    }

    func createAnimation() {
        let flowAnimation = CABasicAnimation(keyPath: "locations")
        flowAnimation.fromValue = [-0.3, -0.15, 0]
        flowAnimation.toValue = [1, 1.15, 1.3]

        flowAnimation.isRemovedOnCompletion = false
        flowAnimation.repeatCount = Float.infinity
        flowAnimation.duration = 1

        gradientLayer.add(flowAnimation, forKey: "flowAnimation")
        
    }
    

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let progressRect = CGRect(origin: .zero, size: CGSize(width: rect.width * curProgress , height: rect.height))
        
        progressLayer.frame = progressRect
        progressLayer.backgroundColor = UIColor.black.cgColor
        progressLayer.cornerRadius = 6.0
        
        gradientLayer.frame = rect
        gradientLayer.colors = [color.cgColor, gradientColor.cgColor, color.cgColor]
        gradientLayer.endPoint = CGPoint(x: curProgress, y: 0.5)
    }
    
    
    func setProgress(to percent : CGFloat)
    {
        
        progress = percent
        
        _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (t) in
            self.curProgress += 0.025
            
            if self.curProgress <= percent {
                self.progress = self.curProgress
            } else {
                t.invalidate()
            }

        }

        
    }
}


