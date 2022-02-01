//
//  HomeOrignalTabViewController.swift
//  Nokri
//
//  Created by Furqan Nadeem on 21/03/2019.
//  Copyright © 2019 Furqan Nadeem. All rights reserved.
//

import UIKit
import JGProgressHUD

class HomeOrignalTabViewController: UITabBarController,UITabBarControllerDelegate {

    //IBOutlets

    var withOutLogin = UserDefaults.standard.string(forKey: "aType")
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        delegate = self
        //nokri_ltrRtl()
        addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
    }
    
    func setupMiddleButton() {
        let menuButton = UIButton(frame: CGRect(x: 0, y: 5, width: 64, height: 64))
        
        let imageViewCustom = UIImageView()
        imageViewCustom.image = UIImage(named: "delete")
        imageViewCustom.image = imageViewCustom.image?.withRenderingMode(.alwaysTemplate)
        imageViewCustom.tintColor = UIColor.white
        imageViewCustom.backgroundColor = UIColor.white
        
        var menuButtonFrame = menuButton.frame
        menuButtonFrame.origin.y = view.bounds.height - 77
        menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
        menuButton.frame = menuButtonFrame
        menuButton.backgroundColor = UIColor.white
        menuButton.tintColor = UIColor(hex: appColorNew!)
        menuButton.layer.cornerRadius =  0.5 * menuButton.bounds.size.width
        menuButton.clipsToBounds = true
        view.addSubview(menuButton)
        menuButton.setImage(imageViewCustom.image, for: .normal)
        menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)
        
        view.layoutIfNeeded()
    }
    
    @objc private func menuButtonAction(sender: UIButton) {
        selectedIndex = 2
    }
    
    func nokri_ltrRtl(){
        let isRtl = UserDefaults.standard.string(forKey: "isRtl")
        if isRtl == "0"{
            self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        }else{
            self.addRightBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected view controller", viewController)
        print("index", tabBarController.selectedIndex )
        
        if tabBarController.selectedIndex == 2{
            if withOutLogin == "5"{
                
                var login = ""
                if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                    let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                    let dataTabs = SplashRoot(fromDictionary: objData)
                    let obj = dataTabs.data.extra
                    login = (obj?.isLogin)!
                }
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = login
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 2.0)
                //self.view.makeToast(login, duration: 1.5, position: .bottom)
             
            }else{
            
                let type = UserDefaults.standard.integer(forKey: "usrTyp")
                if type == 1{
            
                }else{
                    var login1 = ""
                    if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                        let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                        let dataTabs = SplashRoot(fromDictionary: objData)
                        let obj = dataTabs.data.extra
                        login1 = (obj?.isEmployerLogin)!
                    }
                    let hud = JGProgressHUD(style: .dark)
                    hud.textLabel.text = login1
                    hud.detailTextLabel.text = nil
                    hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                    hud.position = .bottomCenter
                    hud.show(in: self.view)
                    hud.dismiss(afterDelay: 2.0)
                    //self.view.makeToast(login1, duration: 1.5, position: .center)
                    
                }
        
            }
            
        }
        
        
    }
    
   
//    private var bounceAnimation: CAKeyframeAnimation = {
//        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
//        bounceAnimation.values = [1.0, 1.4, 0.9, 1.02, 1.0]
//        bounceAnimation.duration = TimeInterval(1.5)
//        bounceAnimation.calculationMode = kCAAnimationCubic
//        return bounceAnimation
//    }()
//
//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//
//        guard let idx = tabBar.items?.index(of: item), tabBar.subviews.count == idx, let imageView = tabBar.subviews[idx].subviews.first as? UIImageView else {
//            return
//        }
//
//        imageView.layer.add(bounceAnimation, forKey: nil)
//    }
//
    
    
    


}


//extension HomeOrignalTabViewController: UITabBarControllerDelegate  {
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//
//        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
//            return false // Make sure you want this as false
//        }
//
//        if fromView != toView {
//            UIView.transition(from: fromView, to: toView, duration: 0.8, options: [.transitionCrossDissolve], completion: nil)
//        }
//
//        return true
//    }
//}
