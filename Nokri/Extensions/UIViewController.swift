//
//  UIViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/10/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//
import Foundation
import UIKit
import NVActivityIndicatorView


  let appDelegate = UIApplication.shared.delegate as! AppDelegate

extension UIViewController:NVActivityIndicatorViewable{
    
    
    func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showLoader(){
        self.startAnimating(Constants.activitySize.size, message: Constants.loaderMessages.loadingMessage.rawValue,messageFont: UIFont.systemFont(ofSize: 14), type: NVActivityIndicatorType.orbit)
    }
    
}

extension UIViewController {
    
   
    
    func hideBackButton() {
        self.navigationItem.hidesBackButton = true
    }
    
    func showBackButton() {
        
    
        self.hideBackButton()
        let backButton = UIButton(type: .custom)
        backButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        if UserDefaults.standard.bool(forKey: "isRtl") {
            backButton.setBackgroundImage(UIImage(named: "LeftNarrow"), for: .normal)
        } else {
            backButton.setBackgroundImage(UIImage(named: "LeftNarrow"), for: .normal)
        }
        backButton.addTarget(self, action: #selector(onBackButtonClciked), for: .touchUpInside)
        let backBarButton = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backBarButton
    }
    
    func showSearchButton() {
        self.hideBackButton()
        let backButton = UIButton(type: .custom)
        backButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        backButton.setBackgroundImage(UIImage(named: "searchWhite"), for: .normal)
        //let backBarButton = UIBarButtonItem(customView: backButton)
        //if UserDefaults.standard.string(forKey: "isRtl") == "0" {
            backButton.setBackgroundImage(UIImage(named: "searchWhite"), for: .normal)
            let backBarButton = UIBarButtonItem(customView: backButton)
            self.navigationItem.rightBarButtonItem = backBarButton
            
//        } else {
//            backButton.setBackgroundImage(UIImage(named: "searchWhite"), for: .normal)
//            let backBarButton = UIBarButtonItem(customView: backButton)
//            self.navigationItem.leftBarButtonItem = backBarButton
//
//
//        }
        backButton.addTarget(self, action: #selector(onSearchButtonClciked), for: .touchUpInside)
        
    }
    
    @objc func onBackButtonClciked() {
        
        let fromNoti = UserDefaults.standard.bool(forKey: "isFromNoti")
        if fromNoti == true{
            
            let home = UserDefaults.standard.string(forKey: "home")
            if home == "1"{
                appDelegate.nokri_moveToHome1()
            }else{
                appDelegate.nokri_moveToHome2()
            }
            UserDefaults.standard.set(false, forKey: "isFromNoti")
            
        }else{
            
            navigationController?.popViewController(animated: true)
            }
        
    }
    
    @objc func onSearchButtonClciked() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AdvanceSearchViewController") as! AdvanceSearchViewController
        navigationController?.pushViewController(vc,
                                                 animated: false)
    }
}


extension Dictionary {
    mutating func merge(with dictionary: Dictionary) {
        dictionary.forEach { updateValue($1, forKey: $0) }
    }
    
    func merged(with dictionary: Dictionary) -> Dictionary {
        var dict = self
        dict.merge(with: dictionary)
        return dict
    }
}

extension Array where Element: Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        if let index = firstIndex(of: object) {
            remove(at: index)
        }
    }
}

extension UILabel {

    func flash() {
        // Take as snapshot of the button and render as a template
        let snapshot = self.snapshot?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: snapshot)
        // Add it image view and render close to white
        imageView.tintColor = UIColor(white: 0.9, alpha: 1.0)
        guard let image = imageView.snapshot  else { return }
        let width = image.size.width
        let height = image.size.height
        // Create CALayer and add light content to it
        let shineLayer = CALayer()
        shineLayer.contents = image.cgImage
        shineLayer.frame = bounds

        // create CAGradientLayer that will act as mask clear = not shown, opaque = rendered
        // Adjust gradient to increase width and angle of highlight
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor,
                                UIColor.clear.cgColor,
                                UIColor.red.cgColor,
                                UIColor.clear.cgColor,
                                UIColor.clear.cgColor]
        gradientLayer.locations = [0.0, 0.35, 0.50, 0.65, 0.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)

        gradientLayer.frame = CGRect(x: -width, y: 0, width: width, height: height)
        // Create CA animation that will move mask from outside bounds left to outside bounds right
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.byValue = width * 2
        // How long it takes for glare to move across button
        animation.duration = 3
        // Repeat forever
        animation.repeatCount = Float.greatestFiniteMagnitude
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)

        layer.addSublayer(shineLayer)
        shineLayer.mask = gradientLayer

        // Add animation
        gradientLayer.add(animation, forKey: "shine")
    }

    func stopFlash() {
        // Search all sublayer masks for "shine" animation and remove
        layer.sublayers?.forEach {
            $0.mask?.removeAnimation(forKey: "shine")
        }
    }
}

extension UIView {
    // Helper to snapshot a view
    var snapshot: UIImage? {
        let renderer = UIGraphicsImageRenderer(size: bounds.size)

        let image = renderer.image { context in
            layer.render(in: context.cgContext)
        }
        return image
    }
}

extension UIView {
    
    enum ViewSide {
        case Left, Right, Top, Bottom
    }
    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color
        switch side {
        case .Left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height); break
        case .Right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height); break
        case .Top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness); break
        case .Bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness); break
        }
        layer.addSublayer(border)
    }
}
