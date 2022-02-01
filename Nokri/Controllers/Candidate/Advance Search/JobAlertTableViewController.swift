//
//  JobAlertTableViewController.swift
//  Nokri
//
//  Created by apple on 3/26/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit
import DropDown
import JGProgressHUD
import Alamofire
import GooglePlaces

class JobAlertTableViewController: UITableViewController,UITextFieldDelegate,GMSAutocompleteViewControllerDelegate {
    
    @IBOutlet weak var lblJobAlert: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblAlertName: UILabel!
    @IBOutlet weak var txtFieldAlertName: UITextField!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblSelectEmailFreq: UILabel!
    @IBOutlet weak var btnEmailFreq: UIButton!
    @IBOutlet weak var lblJobCategory: UILabel!
    @IBOutlet weak var btnJobCategory: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var lblJobExp: UILabel!
    @IBOutlet weak var btnJobExp: UIButton!
    @IBOutlet weak var lblJobType: UILabel!
    @IBOutlet weak var btnJobtype: UIButton!
    @IBOutlet weak var heightConstFreq: NSLayoutConstraint!
    @IBOutlet weak var heightConstCat: NSLayoutConstraint!
    @IBOutlet weak var heightConstExp: NSLayoutConstraint!
    @IBOutlet weak var heightConstType: NSLayoutConstraint!
    @IBOutlet weak var viewCat: UIView!
    @IBOutlet weak var viewExp: UIView!
    @IBOutlet weak var viewType: UIView!
    @IBOutlet weak var viewFreq: UIView!
    @IBOutlet weak var lblCountryKey: UILabel!
    @IBOutlet weak var lblCountryValue: UILabel!
    @IBOutlet weak var btnCountry: UIButton!
    @IBOutlet weak var viewCountry: UIView!
    @IBOutlet weak var heightConstViewCountry: NSLayoutConstraint!
    @IBOutlet weak var lblLoc: UILabel!
    @IBOutlet weak var txtLoc: UITextField!
    @IBOutlet weak var viewLoc: UIView!
    @IBOutlet weak var heightConstViewLoc: NSLayoutConstraint!
    @IBOutlet weak var topConstViewGeoLoc: NSLayoutConstraint!
    
    var dropDownJobType = DropDown()
    var dropDownJobExp = DropDown()
    var dropDownFreq = DropDown()
    var dropDownFreqInt = 0
    var dropDownJobExpInt = 0
    var dropDownJobTypeInt = 0
    var catInt = 0
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var jobFrequencyKey = [Int]()
    var jobFrequencyValue = [String]()
    var jobCatArr = [String]()
    var childArr = [Bool]()
    var keyArray = [Int]()
    var jobtypeKey = [Int]()
    var jobtypeValuerr = [String]()
    var jobExpKeyArr = [Int]()
    var jobExpValArr = [String]()
    var jobExpText = ""
    var jobTypeText = ""
    
    var jobCatArr2 = [String]()
    var childArr2 = [Bool]()
    var keyArray2 = [Int]()
    
    var isShowCategory = "false"
    var isShowjobType = "false"
    var isShowExp = "false"
    var isShowCustomLoc = "false"
    
    var countryArray = NSMutableArray()
    var stateArray = NSMutableArray()
    var cityArray = NSMutableArray()
    var townArray = NSMutableArray()
    
    let paidAlert = UserDefaults.standard.string(forKey: "isPaidAlert")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtLoc.delegate = self
        btnSubmit.backgroundColor = UIColor(hex: appColorNew!)
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            lblJobAlert.text = dataTabs.data.extra.jobalert
            lblDetail.text = dataTabs.data.extra.jobalertdetail
            lblEmail.text = dataTabs.data.extra.yourEmail
            txtEmail.placeholder = dataTabs.data.extra.yourEmail
            lblAlertName.text = dataTabs.data.extra.alertName
            txtFieldAlertName.placeholder = dataTabs.data.extra.alertName
            lblSelectEmailFreq.text = dataTabs.data.extra.selectEmailFreq
            lblJobCategory.text = dataTabs.data.extra.jobCat
            self.title = dataTabs.data.extra.jobalert
            btnSubmit.setTitle(dataTabs.data.feedBackSaplash.data.btnSubmit, for: .normal)
        }
        lblJobExp.text = jobExpText
        lblJobType.text = jobTypeText
        //txtEmail.layer.borderColor = UIColor.lightGray.cgColor
        //txtFieldAlertName.layer.borderColor = UIColor.lightGray.cgColor
        viewCat.layer.cornerRadius = 5
        viewExp.layer.cornerRadius = 5
        viewType.layer.cornerRadius = 5
        viewFreq.layer.cornerRadius = 5
        btnSubmit.layer.cornerRadius = 5
        nokri_jobLoctData()
        let userData = UserDefaults.standard.object(forKey: "settingsData")
        let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
        let dataTabs = SplashRoot(fromDictionary: objData)
        let objExtraTxt = dataTabs.data.extra
        lblLoc.text = objExtraTxt?.customLocation
        txtLoc.placeholder = objExtraTxt?.customLocation
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let catName  = UserDefaults.standard.string(forKey: "caName")
        let cat2Name  = UserDefaults.standard.string(forKey: "caName")
        let cat3Name  = UserDefaults.standard.string(forKey: "caName")
        let cat4Name  = UserDefaults.standard.string(forKey: "caName")
        let catKey = UserDefaults.standard.integer(forKey: "caKey")
        let cat2Key = UserDefaults.standard.integer(forKey: "ca2Key")
        let cat3Key = UserDefaults.standard.integer(forKey: "ca3Key")
        let cat4Key = UserDefaults.standard.integer(forKey: "ca4Key")
        
        btnJobCategory.setTitle(catName, for: .normal)
        btnJobCategory.setTitle(cat2Name, for: .normal)
        btnJobCategory.setTitle(cat3Name, for: .normal)
        btnJobCategory.setTitle(cat4Name, for: .normal)
        
        if catKey != 0 {
            btnJobCategory.tag = catKey
        }
        if cat2Key != 0 {
            btnJobCategory.tag = cat2Key
        }
        if cat3Key != 0 {
            btnJobCategory.tag = cat3Key
        }
        if cat4Key != 0 {
            btnJobCategory.tag = cat4Key
        }
        
        dropDownFreq.anchorView = btnEmailFreq
        dropDownJobExp.anchorView = btnJobExp
        dropDownJobType.anchorView = btnJobtype
                
        if paidAlert == "1"{
            heightConstExp.constant = 0
            viewExp.isHidden = true
            heightConstType.constant = 0
            viewType.isHidden = true
            heightConstViewLoc.constant = 0
            viewLoc.isHidden = true
        }
        else{
            
            if isShowCategory == "false"{
                heightConstCat.constant = 0
                viewCat.isHidden = true
            }
            if isShowExp == "false"{
                heightConstExp.constant = 0
                viewExp.isHidden = true
            }
            if isShowjobType == "false"{
                heightConstType.constant = 0
                viewType.isHidden = true
            }
            if isShowCustomLoc == "false"{
                heightConstViewLoc.constant = 0
                viewLoc.isHidden = true
                
            }
            topConstViewGeoLoc.constant -= 40
        }
        
        let cotName  = UserDefaults.standard.string(forKey: "coName")
        let cot2Name  = UserDefaults.standard.string(forKey: "coName")
        let cot3Name  = UserDefaults.standard.string(forKey: "coName")
        let cot4Name  = UserDefaults.standard.string(forKey: "coName")
        let cotKey = UserDefaults.standard.integer(forKey: "coKey")
        let cot2Key = UserDefaults.standard.integer(forKey: "co2Key")
        let cot3Key = UserDefaults.standard.integer(forKey: "co3Key")
        let cot4Key = UserDefaults.standard.integer(forKey: "co4Key")
        
        if cotKey != 0{
            btnCountry.tag = cotKey
            self.lblCountryValue.text = cotName
        }
        if cot2Key != 0{
            btnCountry.tag = cotKey
            self.lblCountryValue.text = cot2Name
        }
        if cot3Key != 0{
            btnCountry.tag = cotKey
            self.lblCountryValue.text = cot3Name
        }
        if cot4Key != 0{
            btnCountry.tag = cotKey
            self.lblCountryValue.text = cot4Name
        }
        
    }
    
    @IBAction func btnDropDownCountryClicked(_ sender: UIButton) {
        var countryArr = [String]()
        var countryChildArr = [Bool]()
        var countryKeyArr = [Int]()
        let country = self.countryArray as? [NSDictionary]
        for itemDict in country! {
            if let catObj = itemDict["value"] as? String{
                if catObj == ""{
                    continue
                }
                countryArr.append(catObj)
            }
            if let keyObj = itemDict["key"] as? Int{
                countryKeyArr.append(keyObj)
            }
            if let hasChild = itemDict["has_child"] as? Bool{
                print(hasChild)
                countryChildArr.append(hasChild)
            }
        }
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "JobPostCountryViewController") as? JobPostCountryViewController
        vc!.jobCatArr = countryArr
        vc!.childArr = countryChildArr
        vc!.keyArray = countryKeyArr
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    
    @IBAction func txtLocClicked(_ sender: UITextField) {
        let autoComplete = GMSAutocompleteViewController()
        autoComplete.delegate = self
        autoComplete.primaryTextHighlightColor = UIColor(hex:"FFC400")
        self.present(autoComplete, animated: true, completion: nil)
    }
    
    
    @IBAction func btnEmailFreqClicked(_ sender: UIButton) {
        dropDownFreq.anchorView = btnEmailFreq
        dropDownFreq.dataSource = jobFrequencyValue
        dropDownFreq.show()
        print(jobFrequencyValue)
        dropDownFreq.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.btnEmailFreq.setTitle(item, for: .normal)
            self.dropDownFreqInt = self.jobFrequencyKey[index]
        }
    }
    
    @IBAction func btnJobCatClicked(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "JobCatOneViewController") as? JobCatOneViewController
        vc!.jobCatArr = jobCatArr
        vc!.childArr = childArr
        vc!.keyArray = keyArray
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func btnJobExpClicked(_ sender: UIButton) {
        dropDownJobExp.anchorView = btnJobExp
        dropDownJobExp.dataSource = jobExpValArr
        print(jobExpValArr)
        dropDownJobExp.show()
        dropDownJobExp.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.btnJobExp.setTitle(item, for: .normal)
            self.dropDownJobExpInt = self.jobExpKeyArr[index]
        }
    }
    
    @IBAction func btnJobTypeClicked(_ sender: UIButton) {
        dropDownJobType.anchorView = btnJobtype
        dropDownJobType.dataSource = jobtypeValuerr
        dropDownJobType.show()
        dropDownJobType.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.btnJobtype.setTitle(item, for: .normal)
            self.dropDownJobTypeInt = self.jobExpKeyArr[index]
        }
    }
    
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
        
        if paidAlert == "1"{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AlertBuyViewController") as! AlertBuyViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
            UserDefaults.standard.set(txtFieldAlertName.text, forKey: "alert_name")
            UserDefaults.standard.set(txtEmail.text, forKey: "alert_email")
            UserDefaults.standard.set(btnCountry.tag, forKey: "alert_location")
            UserDefaults.standard.set(btnJobCategory.tag, forKey: "alert_category")
        }else{
            
            var field:String = ""
            var validEmail:String = ""
            
            if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                let dataTabs = SplashRoot(fromDictionary: objData)
                field = dataTabs.data.extra.allField
                validEmail = dataTabs.data.extra.validEmail
            }
            
            if txtFieldAlertName.text == ""{
                let alert = Constants.showBasicAlert(message: field)
                self.present(alert, animated: true, completion: nil)
            }else if txtEmail.text == ""{
                let alert = Constants.showBasicAlert(message: field)
                self.present(alert, animated: true, completion: nil)
            }else if isValidEmail(testStr: txtEmail.text!) == false{
                let alert = Constants.showBasicAlert(message: validEmail)
                self.present(alert, animated: true, completion: nil)
            }else{
                let param: [String: Any] = [
                    "alert_email": txtEmail.text!,
                    "alert_name": txtFieldAlertName.text!,
                    "alert_frequency": dropDownFreqInt,
                    "alert_type": dropDownJobTypeInt,
                    "alert_experience": dropDownJobExpInt,
                    "alert_category": btnJobCategory.tag,
                    "sb_user_address2": txtLoc.text!
                ]
                print(param)
                self.nokri_EmailAlertPost(parameter: param as NSDictionary)
            }
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }

func nokri_EmailAlertPost(parameter: NSDictionary) {
    self.showLoader()
    UserHandler.nokri_EmailAlertPost(parameter: parameter as NSDictionary, success: { (successResponse) in
        self.stopAnimating()
        if successResponse.success == true{
            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = successResponse.message
            hud.detailTextLabel.text = nil
            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
            hud.position = .bottomCenter
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 2.0)
        }
        else {
            let alert = Constants.showBasicAlert(message: successResponse.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }) { (error) in
        let alert = Constants.showBasicAlert(message: error.message)
        self.present(alert, animated: true, completion: nil)
        self.stopAnimating()
    }
}

func nokri_jobLoctData(){
    
    var langCode = UserDefaults.standard.string(forKey: "langCode")
    if langCode == nil {
        langCode = "en"
    }
    
    var email = ""
    var password = ""
    
    if let userEmail = UserDefaults.standard.string(forKey: "email") {
        email = userEmail
    }
    if let userPassword = UserDefaults.standard.string(forKey: "password") {
        password = userPassword
    }
    let emailPass = "\(email):\(password)"
    let encodedString = emailPass.data(using: String.Encoding.utf8)!
    let base64String = encodedString.base64EncodedString(options: [])
    
    let headers = [
        "Content-Type":Constants.customCodes.contentType,
        "Authorization" : "Basic \(base64String)",
        "Purchase-Code" : Constants.customCodes.purchaseCode,
        "Custom-Security": Constants.customCodes.securityCode,
        "Nokri-Request-From" : Constants.customCodes.requestFrom,
        "Nokri-Lang-Locale" : "\(langCode!)"
    ]
    Alamofire.request(Constants.URL.baseUrl+Constants.URL.location, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
        .responseJSON { response in
            
            guard let res = response.value else{return}
            let responseData = res as! NSDictionary
            let success = responseData["success"] as! Bool
            if success == true{
                let customLocation = responseData["custom_location"] as! NSDictionary
                let jobCountry = customLocation["job_country"] as! NSDictionary
                let jobCountryKey = jobCountry["key"] as! String
                self.lblCountryKey.text = jobCountryKey
                if let countryArr = jobCountry["value"] as? NSArray {
                    self.nokri_countryDataParser(countryArr: countryArr)
                }
                let jobState = customLocation["job_state"] as! NSDictionary
                let jobStateKey = jobState["key"] as! String
                //self.lblCountryKey.text = "jobCountryKey"
                if let stateArr = jobState["value"] as? NSArray {
                    self.nokri_stateDataParser(stateArr: stateArr)
                }
                
                let jobCity = customLocation["job_city"] as! NSDictionary
                let jobCityKey = jobCity["key"] as! String
                //self.lblCountryKey.text = jobCountryKey
                if let cityArr = jobCity["value"] as? NSArray {
                    self.nokri_cityDataParser(cityArr: cityArr)
                }
                
                let jobTown = customLocation["job_town"] as! NSDictionary
                let jobTownKey = jobTown["key"] as! String
                //self.lblCountryKey.text = jobCountryKey
                if let townArr = jobTown["value"] as? NSArray {
                    self.nokri_townDataParser(townArr: townArr)
                }
                self.lblCountryKey.text = "\(jobCountryKey),\(jobStateKey),\(jobCityKey),\(jobTownKey)"
                
                //self.nokri_populateData()
            }else{
            }
            self.stopAnimating()
        }
}

func nokri_countryDataParser(countryArr:NSArray){
    self.countryArray.removeAllObjects()
    for item in countryArr{
        self.countryArray.add(item)
    }
}

func nokri_stateDataParser(stateArr:NSArray){
    self.stateArray.removeAllObjects()
    for item in stateArr{
        self.stateArray.add(item)
    }
}

func nokri_cityDataParser(cityArr:NSArray){
    self.cityArray.removeAllObjects()
    for item in cityArr{
        self.cityArray.add(item)
    }
}

func nokri_townDataParser(townArr:NSArray){
    self.townArray.removeAllObjects()
    for item in townArr{
        self.townArray.add(item)
    }
}
    
    //MARK:- GMSAutocomplete Delegate
    
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
      
        txtLoc.text = place.name
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error Auto Complete \(error)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

}


