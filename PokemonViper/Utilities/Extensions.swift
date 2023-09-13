//
//  Extensions.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 12/10/22.
//

import Foundation
import UIKit
extension UIView{
    func anchor(top: NSLayoutYAxisAnchor?  = nil,left: NSLayoutXAxisAnchor? = nil,bottom: NSLayoutYAxisAnchor? = nil,right: NSLayoutXAxisAnchor? = nil,paddingTop: CGFloat = 0,paddingLeft:CGFloat = 0,paddingBottom:CGFloat = 0,paddingRight:CGFloat = 0,width: CGFloat? = nil,height : CGFloat? = nil){
        
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top,constant: paddingTop).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left,constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom,constant: -paddingBottom).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right,constant: -paddingRight).isActive = true
        }
        if let width = width {
            widthAnchor.constraint(equalToConstant : width).isActive = true
        }
        if let height = height {
            heightAnchor.constraint(equalToConstant : height).isActive = true
        }
    }
    
    
    func centerX(inView view: UIView) {
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    func centerY(inView view: UIView,constant:CGFloat = 0) {
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    func addSubViews(view: UIView...){
        view.forEach { view in
            addSubview(view)
        }
    }

    func pinToEdges(superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        anchor(top: superView.safeAreaLayoutGuide.topAnchor, left: superView.leftAnchor, bottom: superView.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }

    func pinToCentre(superView:  UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerX(inView: superView)
        centerY(inView: superView)
        anchor(width: 50, height: 50)
    }

}
extension UIImageView {
    /// Loads image from web asynchronosly and caches it, in case you have to load url
    /// again, it will be loaded from cache if available
    func load(url: URL , cache: URLCache? = nil) {
        let cache = cache ?? URLCache.shared
        let request = URLRequest(url: url)
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            self.image = image
        } else {
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    self.image = image
                }
            }).resume()
        }
    }
}

extension CAGradientLayer {

    class func primaryGradient(on view: UIView,_ firstColor:UIColor,_ secondColor: UIColor) -> UIImage? {
        let gradient = CAGradientLayer()
        

        var bounds = view.bounds
        bounds.size.height += UIApplication.shared.statusBarFrame.size.height
        gradient.frame = bounds
        gradient.colors = [firstColor.cgColor, secondColor.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        return gradient.createGradientImage(on: view)
    }

    private func createGradientImage(on view: UIView) -> UIImage? {
        var gradientImage: UIImage?
        UIGraphicsBeginImageContext(view.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
}

extension URLSession{
    
    enum CustomError:Error{
        case invalidURL
        case invalidData
    }
    
    func request<T:Codable>(url: URL?,expecting:T.Type,completion:@escaping (Result<T,Error>) -> Void) {
        guard let url = url else{
            completion(.failure(CustomError.invalidURL))
            return
        }
     
        
        let task = URLSession.shared.dataTask(with: url) { data, responseData, error in
            guard let data =  data else {
                if let error = error{
                    completion(.failure(error))
                }else {
                    completion(.failure(CustomError.invalidData))
                }
                return
            }
            do {
                let result = try JSONDecoder().decode(expecting.self,from: data)
                completion(.success(result))
            }
            catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

extension UIColor{
    static let primaryColor = UIColor(red: 210/255, green: 248/255, blue: 210/255, alpha: 1)
    static var primaryFirstColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    static var primarySecondColor = UIColor(red: 210/255, green: 248/255, blue: 210/255, alpha: 1)
    static var grassFirstColor = UIColor(red: 119/255, green: 186/255, blue: 95/255, alpha: 1)
    static var grassSecondColor = UIColor(red: 118/255, green: 190/255, blue: 126/255, alpha: 1)
    static var electricFirstColor = UIColor(red: 234/255, green: 214/255, blue: 94/255, alpha: 1)
    static var electricSecondColor = UIColor(red: 247/255, green: 226/255, blue: 130/255, alpha: 1)
    static var bugFirstColor = UIColor(red: 156/255, green: 187/255, blue: 72/255, alpha: 1)
    static var bugSecondColor = UIColor(red: 180/255, green: 199/255, blue: 81/255, alpha: 1)
    static var dragonFirstColor = UIColor(red: 48/225, green: 104/255, blue: 194/255, alpha: 1)
    static var dragonSecondColor = UIColor(red: 56/255, green: 126/255, blue: 194/255, alpha: 1)
    static var poisonfirstColor = UIColor(red: 159/255, green: 103/255, blue: 194/255, alpha: 1)
    static var poisonSecondColor = UIColor(red: 182/255, green: 102/255, blue: 206/255, alpha: 1)
    static var groundFirstColor = UIColor(red: 207/255, green: 123/255, blue: 81/255, alpha: 1)
    static var groundSecondColor = UIColor(red: 201/255, green: 150/255, blue: 106/255, alpha: 1)
    static var fireFirstColor = UIColor(red: 238/255, green: 160/255, blue: 95/255, alpha: 1)
    static var fireSecondColor = UIColor(red: 240/255, green: 197/255, blue: 91/255, alpha: 1)
    static var ghostFirstColor = UIColor(red: 88/255, green: 106/255, blue: 169/255, alpha: 1)
    static var ghostSecondColor = UIColor(red: 118/255, green: 115/255, blue: 205/255, alpha: 1)
    static var psychicFirstColor = UIColor(red: 230/255, green: 121/255, blue: 118/255, alpha: 1)
    static var psychicSecondColor = UIColor(red: 240/255, green: 162/255, blue: 149/255, alpha: 1)
    static var steelFirstColor = UIColor(red: 94/255, green: 133/255, blue: 155/255, alpha: 1)
    static var steelSecondColor = UIColor(red: 107/255, green: 163/255, blue: 168/255, alpha: 1)
    static var rockFirstColor = UIColor(red: 194/255, green: 182/255, blue: 142/255, alpha: 1)
    static var rockSecondColor = UIColor(red: 213/255, green: 204/255, blue: 151/255, alpha: 1)
    static var waterFirstColor = UIColor(red: 103/255, green: 156/255, blue: 218/255, alpha: 1)
    static var waterSecondColor = UIColor(red: 125/255, green: 183/255, blue: 223/255, alpha: 1)
    static var darkFirstColor = UIColor(red: 89/255, green: 87/255, blue: 97/255, alpha: 1)
    static var darkSecondColor = UIColor(red: 111/255, green: 116/255, blue: 133/255, alpha: 1)
    static var fightFirstColor = UIColor(red: 191/255, green: 77/255, blue: 102/255, alpha: 1)
    static var fightSecondColor = UIColor(red: 213/255, green: 80/255, blue: 78/255, alpha: 1)
    static var normalFirstColor = UIColor(red: 147/255, green: 152/255, blue: 163/255, alpha: 1)
    static var normalSecondColor = UIColor(red: 148/255, green: 149/255, blue: 145/255, alpha: 1)
    static var IceFirstColor = UIColor(red: 135/255, green: 202/255, blue: 190/255, alpha: 1)
    static var IceSecondColor = UIColor(red: 157/255, green: 218/255, blue: 211/255, alpha: 1)
    static var flyingFirstColor = UIColor(red: 149/255, green: 167/255, blue: 215/255, alpha: 1)
    static var flyingSecondColor = UIColor(red: 171/255, green: 192/255, blue: 237/255, alpha: 1)
    static var fairyFirstColor = UIColor(red: 223/255, green: 145/255, blue: 224/255, alpha: 1)
    static var fairySecondColor = UIColor(red: 231/255, green: 170/255, blue: 227/255, alpha: 1)
    
    
}

//extension UILabel {
//    func textHeight(withWidth width: CGFloat) -> CGFloat {
//        guard let text = text else {
//            return 0
//        }
//        return text.height(withWidth: width, font: font)
//    }
//
//    func attributedTextHeight(withWidth width: CGFloat) -> CGFloat {
//        guard let attributedText = attributedText else {
//            return 0
//        }
//        return attributedText.height(withWidth: width)
//    }
//}
extension UILabel{
    func setProgessBarLabeltext(){
        self.font = UIFont.init(name: "Avenir", size: 14)
    }
}
