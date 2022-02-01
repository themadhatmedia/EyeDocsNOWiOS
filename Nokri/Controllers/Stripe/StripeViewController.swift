////
////  StripeViewController.swift
////  Opportunities
////
////  Created by Furqan Nadeem on 6/13/18.
////  Copyright © 2018 Furqan Nadeem. All rights reserved.
////
//
//import UIKit
//import Stripe
//
//class StripeViewController: UIViewController,STPPaymentCardTextFieldDelegate {
//
//    //MARK:- IBOutlets
//
//    @IBOutlet weak var checkOut: UIButton! {
//        didSet {
//            checkOut.isHidden = true
//          //  checkOut.roundCornors()
//
//        }
//    }
//
//    //MARK:- Proporties
//    var packageId = 0
//    var packageName = ""
//    //var stripeKey = ""
//    let payCardTextField = STPPaymentCardTextField()
//
//    //MARK:- View Life Cycle
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//        paymentTextField()
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    //MARK:- Custome Function
//
//    func paymentTextField() {
//        payCardTextField.frame = CGRect(x: 20, y: 140, width: self.view.frame.width - 40, height: 40)
//        payCardTextField.delegate = self
//        self.view.addSubview(payCardTextField)
//    }
//
//
//    //MARK:- Delegate
//
//    func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
//        if textField.isValid {
//            checkOut.isHidden = false
//        }
//        else {
//            checkOut.isHidden = true
//        }
//    }
//
//
//
//    @IBAction func actionCheckOut(_ sender: UIButton) {
//
//        let cardParms = payCardTextField.cardParams
//
//        STPAPIClient.shared().createToken(withCard: cardParms) { (token, error) in
//            if let error = error {
//                print(error)
//            }
//            else if let token = token {
//                print(token)
//                let params: [String: Any] = [
//                    "package_id" : String(self.packageId),
//                    "payment_from": self.packageName,
//                    "source_token": token.tokenId
//                ]
//                print(params)
//                self.paymentPost(parameter: params as NSDictionary)
//            }
//        }
//    }
//
//
//
//    //MARK:- API
//
//    func paymentPost(parameter: NSDictionary) {
//
//        self.startActivityIndicator()
//
//        UserHandler.payment(parameter: parameter as NSDictionary, success: { (successResponse) in
//            self.stopActivityIndicator()
//
//            if successResponse.success == true{
//                self.view.makeToast(successResponse.message, duration: 1.5, position: .bottom)
//                self.perform(#selector(self.showPaymentComplete), with: nil, afterDelay: 1.5)
//            }
//            else {
//                self.stopActivityIndicator()
//                let alert = Constants.showBasicAlert(message: successResponse.message)
//                self.present(alert, animated: true, completion: nil)
//            }
//        }) { (error) in
//            self.stopActivityIndicator()
//            let alert = Constants.showBasicAlert(message: error.message)
//            self.present(alert, animated: true, completion: nil)
//        }
//
//    }
//
//    @objc func showPaymentComplete(){
//
//        let paymentCompleteController = self.storyboard?.instantiateViewController(withIdentifier: "PaymentCompleteViewController") as! PaymentCompleteViewController
//        self.navigationController?.pushViewController(paymentCompleteController, animated: true)
//
//    }
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
