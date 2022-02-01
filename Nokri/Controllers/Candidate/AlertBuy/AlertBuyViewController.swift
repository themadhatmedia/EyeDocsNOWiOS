//
//  AlertBuyViewController.swift
//  Nokri
//
//  Created by Apple on 12/10/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit
import SwiftyStoreKit
import JGProgressHUD

class AlertBuyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    //MARK:- IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnSubmit: UIButton!
    
    
    //MARK:- Proporties
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var data = [String]()
    var subData = [String]()
    var packageId :Int?
    var product = ""
    var price = ""
    var subTotal = ""
    var vat = ""
    var productVal = ""
    var priceVal = ""
    var subTotalVal = ""
    var vatVal = ""
    
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        btnSubmit.backgroundColor = UIColor(hex: appColorNew!)
        
        
        let alert_name = UserDefaults.standard.string(forKey:"alert_name")
        let alert_email = UserDefaults.standard.string(forKey:"alert_email")
        let alert_loc = UserDefaults.standard.integer(forKey:"alert_location")
        let alert_cat = UserDefaults.standard.integer(forKey:"alert_category")
        
        
        
        let param: [String: Any] = [
            "alert_name": alert_name!,
            "alert_email": alert_email!,
            "alert_location": alert_loc,
            "alert_category": alert_cat
        ]
        print(param)
        self.nokri_AlertGetPost(parameter: param as NSDictionary)
        
    }
    
    //MARK:- TableView
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlertBuyTableViewCell", for: indexPath) as! AlertBuyTableViewCell
        
        cell.lblTitle.text = "\(data[indexPath.row]):"
        cell.lblSubDetail.text = subData[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    @IBAction func btnBuyClicked(_ sender: UIButton) {
        self.purchaseProduct(productID: inApp_id)
    }
    
    //MARK:- InApp Purchase
    
    func nokri_MoveToInAppPurchases() {
        self.purchaseProduct(productID: inApp_id)
    }
    
    func getInfo() {
        NetworkActivityIndicatorManager.networkOperationStart()
        self.showLoader()
        SwiftyStoreKit.retrieveProductsInfo([inApp_id], completion: {
            result in
            NetworkActivityIndicatorManager.networkOperationFinish()
            self.stopAnimating()
            self.showAlert(alert: self.alertForProductRetrivalInfo(result: result))
        })
    }
    
    func purchaseProduct(productID: String) {
        NetworkActivityIndicatorManager.networkOperationStart()
        self.showLoader()
        print(productID)
        SwiftyStoreKit.purchaseProduct(productID, completion: {
            result in
          
            NetworkActivityIndicatorManager.networkOperationFinish()
            self.stopAnimating()
            if case .success(let product) = result {
                if product.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(product.transaction)
                }
                self.showAlert(alert: self.alertForPurchasedResult(result: result))
                let param: [String: Any] = [
                    "package_id": self.packageId!,
                    "payment_from": "cash_on_delivery"
                ]
                self.nokri_paymentPost(parameter: param as NSDictionary)
            }
            else{
                self.showAlert(alert: self.alertForPurchasedResult(result: result))
            }
        })
    }
    
    func restorePurchase() {
        NetworkActivityIndicatorManager.networkOperationStart()
        self.showLoader()
        SwiftyStoreKit.restorePurchases(atomically: true,  completion: {
            result in
            NetworkActivityIndicatorManager.networkOperationFinish()
            self.stopAnimating()
            for product in result.restoredPurchases {
                if product.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(product.transaction)
                }
            }
            self.showAlert(alert: self.alertForRestorePurchase(result: result))
        })
    }
    
    func verifyReceipt() {
        NetworkActivityIndicatorManager.networkOperationStart()
        self.showLoader()
        let validator = AppleReceiptValidator(service: .production, sharedSecret: sharedSecret)
        SwiftyStoreKit.verifyReceipt(using: validator, completion: {
            result in

            NetworkActivityIndicatorManager.networkOperationFinish()
            self.stopAnimating()
            self.showAlert(alert: self.alertForVerifyReceipt(result: result))
            if case .error(let error)  = result {
                if case .noReceiptData = error {
                    self.refreshReceipt()
                }
            }
        })
    }
    
    func verifyPurchase() {
        NetworkActivityIndicatorManager.networkOperationStart()
        self.showLoader()
        let validator = AppleReceiptValidator(service: .production, sharedSecret: sharedSecret)
        SwiftyStoreKit.verifyReceipt(using: validator, completion: {
            result in
            switch result {
            case .success(let receipt):
                let productID = inApp_id
                let purchaseResult = SwiftyStoreKit.verifyPurchase(productId: productID, inReceipt: receipt)
                self.showAlert(alert: self.alertForVerifyPurchase(result: purchaseResult))
                
            case .error(let error):
                self.showAlert(alert: self.alertForVerifyReceipt(result: result))
                
                if case .noReceiptData = error {
                    self.refreshReceipt()
                }
            }
        })
    }
    
    func refreshReceipt() {
        let validator = AppleReceiptValidator(service: .production, sharedSecret: sharedSecret)
        SwiftyStoreKit.verifyReceipt(using: validator, completion: {
            result in
            self.showAlert(alert: self.alertForRefreshReceipt(result: result))
        })
    }
    
    func nokri_paymentPost(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_payment(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true{
             
                    let hud = JGProgressHUD(style: .dark)
                    hud.textLabel.text = successResponse.message
                    hud.detailTextLabel.text = nil
                    hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                    hud.position = .bottomCenter
                    hud.show(in: self.view)
                    hud.dismiss(afterDelay: 2.0)
                    self.perform(#selector(self.backScreen), with: nil, afterDelay: 2)

            }
            else {
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
            }
        }) { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }
    
    @objc func backScreen(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func nokri_AlertGetPost(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_buyAlertGet(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true{

                self.product = successResponse.data.product
                self.price = successResponse.data.price
                self.productVal = successResponse.data.productValue
                self.priceVal = successResponse.data.priceValue
                inApp_id = "com.alert"
                self.packageId = Int(successResponse.data.id)
                self.btnSubmit.setTitle(successResponse.data.buy, for: .normal)
                self.title = successResponse.data.title
                self.data.append(self.product)
                self.data.append(self.price)
                self.subData.append(self.productVal)
                self.subData.append(self.priceVal)
                self.tableView.reloadData()
                
                
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
    
    
    
}

extension AlertBuyViewController {
    func alertWithTitle(title: String, message: String)-> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alert
    }
    
    func showAlert(alert: UIAlertController) {
        guard let _ = self.presentedViewController else {
            self.present(alert, animated: true, completion: nil)
            return
        }
    }
    
    func alertForProductRetrivalInfo(result: RetrieveResults)-> UIAlertController {
        if let product = result.retrievedProducts.first {
            let priceString = product.localizedPrice!
            return alertWithTitle(title: product.localizedTitle, message: "\(product.localizedDescription) - \(priceString)")
        }
        else if let invalidProductID = result.invalidProductIDs.first {
            return alertWithTitle(title: "Could Not retrieve Info", message: "Invalid Product ID: \(invalidProductID)")
        }
        else {
            let errorString = result.error?.localizedDescription ?? "Unknown Error. Please Contact Support"
            return alertWithTitle(title: "Could not retrieve info", message: errorString)
        }
    }
    
    func alertForPurchasedResult(result: PurchaseResult)-> UIAlertController {
        
        switch result {
        case .success(let purchase):
            print("Purchase SuccessFfull: \(purchase.productId)")
            //verifyReceipt()
            return alertWithTitle(title: "Thank You", message: "Purchase Completed")
        case .error(let error):
            return alertWithTitle(title: "Error", message: "\(error)")
        }
    }
    
    func alertForRestorePurchase(result: RestoreResults)-> UIAlertController {
        
        if result.restoredPurchases.count > 0 {
            print("restore Failed \(result.restoredPurchases)")
            return alertWithTitle(title: "Restore Failed", message: "Error. Please Contact Support")
        }
        else if result.restoredPurchases.count > 0 {
            return alertWithTitle(title: "Purchase Restored", message: "All Purchases Have been restored")
        }
        else {
            return alertWithTitle(title: "Nothing to restore", message: "No previous purchases were made")
        }
    }
    
    
    func alertForVerifyReceipt(result: VerifyReceiptResult)-> UIAlertController {
        
        switch result {
        case .success( _):
            return alertWithTitle(title: "Receipt Verified", message: "Receipt Verified Remotely")
        case .error(let error):
            switch error {
            case .noReceiptData:
                return alertWithTitle(title: "Receipt Verification", message: "No receipt data found, application will try to get a new one. Try again")
            default:
                return alertWithTitle(title: "Receipt Verification", message: "Receipt Verification Failed.")
            }
        }
    }
    
    
    func alertForVerifySubscription(result: VerifySubscriptionResult)-> UIAlertController {
        switch result {
        case .purchased(let expiryDate):
            return alertWithTitle(title: "Product is Purchased", message: "Product is valid until \(expiryDate)")
        case .notPurchased:
            return alertWithTitle(title: "Not Purchased", message: "This product has never been purchased")
        case .expired(let expiryDate):
            return alertWithTitle(title: "Product Expired", message: "Product is expire since \(expiryDate)")
        }
    }
    
    
    func alertForVerifyPurchase(result: VerifyPurchaseResult)-> UIAlertController {
        switch result {
        case .purchased:
            return alertWithTitle(title: "Product is purchased", message: "Product will not expire")
        case .notPurchased:
            return alertWithTitle(title: "Product not purchased", message: "Product has never been purchased")
        }
    }
    
    func alertForRefreshReceipt(result: VerifyReceiptResult) -> UIAlertController {
        switch result {
        case .success( _):
            return alertWithTitle(title: "Receipt refresh", message: "receipt refresh successfully")
        case .error( _):
            return alertWithTitle(title: "Receipt refresh failed", message: "Receipt refresh failed")
        }
    }
}
