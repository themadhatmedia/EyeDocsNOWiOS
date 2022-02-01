//
//  LanguageViewController.swift
//  Nokri
//
//  Created by Apple on 11/09/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit
import DropDown


class LanguageViewController: UIViewController{
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var btnDropDown: UIButton!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblChoose: UILabel!
    @IBOutlet weak var lblLang: UILabel!
    @IBOutlet weak var lblDes: UILabel!
    @IBOutlet weak var viewDropDown: UIView!
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    
    //MARK:- Proporties
    
    var langArr = [String]()
    var imageArr = [String]()
    let centeredDropDown = DropDown()
    let home = UserDefaults.standard.string(forKey: "home")
    var languages = UserHandler.sharedInstance.languagesData
    var languageCodes = [String]()
    var selectedLangCode = ""
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dropDownSetup()
        lblLang.flash()
        showSearchButton()
        UIView.animate(withDuration: 0.85, delay: 0, options: [.curveEaseOut], animations: {
            self.lblLang.center.x += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
        let isFirstTime = UserDefaults.standard.bool(forKey: "FirstTime")
        if isFirstTime == true{
           
            if languages.count == 0{
                nokri_ltrRtl()
                btnSkip.isHidden = true
            }else{
                btnSkip.isHidden = true
            }
            
            
        }else{
            nokri_ltrRtl()
            btnSkip.isHidden = false
        }
        UserDefaults.standard.set(true, forKey: "FirstTime")

        let userData = UserDefaults.standard.object(forKey: "settingsData")
        let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
        let dataTabs = SplashRoot(fromDictionary: objData)
        
        self.title = dataTabs.data.extra.lang
        lblChoose.text = dataTabs.data.extra.lang_choose
        lblLang.text = dataTabs.data.extra.lang
        lblDes.text = dataTabs.data.extra.lang_desc
        btnSubmit.setTitle(dataTabs.data.feedBackSaplash.data.btnSubmit, for: .normal)
        btnSkip.setTitle(dataTabs.data.extra.skip, for: .normal)
        imgLogo.sd_setImage(with:URL(string: dataTabs.data.logo) , completed: nil)
        
    }
    
    //MARK:- IBActions
    
    @IBAction func btnDropDownClicked(_ sender: UIButton) {
        centeredDropDown.show()
    }
    
    //MARK:- Custom Functions
    
    func nokri_ltrRtl(){
        let isRtl = UserDefaults.standard.string(forKey: "isRtl")
        if isRtl == "0"{
            self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        }else{
            self.addRightBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        }
    }
    
    func dropDownSetup(){
        
        for obj in languages{
            imageArr.append(obj.flag_url)
            langArr.append(obj.native_name)
            languageCodes.append(obj.code)
        }
        
        //imageArr = ["pak","turk","pak","turk","pak"]
        let appearance = DropDown.appearance()
        appearance.cellHeight = 60
        appearance.backgroundColor = UIColor(white: 1, alpha: 1)
        appearance.selectionBackgroundColor = UIColor(red: 0.6494, green: 0.8155, blue: 1.0, alpha: 0.2)
        appearance.cornerRadius = 10
        appearance.shadowColor = UIColor(white: 0.6, alpha: 1)
        appearance.shadowOpacity = 0.9
        appearance.shadowRadius = 25
        appearance.animationduration = 0.25
        appearance.textColor = .darkGray
        
        centeredDropDown.dataSource = langArr
        centeredDropDown.anchorView = btnDropDown
        centeredDropDown.cellNib = UINib(nibName: "MyCell", bundle: nil)
        centeredDropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? MyCell else { return }
            UserDefaults.standard.set(self.languageCodes[0], forKey: "langCode")
            self.btnDropDown.setTitle(self.langArr[0], for: .normal)
            
            cell.logoImageView.sd_setImage(with:URL(string: self.imageArr[index]) , completed: nil)
        }
        centeredDropDown.selectionAction = { [weak self] (index, item) in
            self!.btnDropDown.setTitle(item, for: .normal)
            self?.selectedLangCode = (self?.languageCodes[index])!
            UserDefaults.standard.set(self?.languageCodes[index], forKey: "langCode")
        }
    }
    
    @IBAction func btnSkipClicked(_ sender: UIButton) {
        self.perform(#selector(self.nokri_showSplash), with: nil, afterDelay: 0)
    }
    
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
        
        btnSubmit.isHighlighted = true
        btnSubmit.setTitleColor(UIColor.darkGray, for: .normal)
        btnSubmit.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        self.perform(#selector(self.nokri_showSplash), with: nil, afterDelay: 0)
        
    }
   
    @objc func nokri_showSplash(){
       // appDelegate.nokri_moveToSplash()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SaplashViewController") as! SaplashViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}

class MyCell: DropDownCell {
    @IBOutlet weak var logoImageView: UIImageView!
}


