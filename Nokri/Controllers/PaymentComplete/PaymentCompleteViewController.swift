//
//  PaymentCompleteViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 6/11/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import WebKit

class PaymentCompleteViewController: UIViewController {
    
    //MARK:- IBOutlets
  
    @IBOutlet weak var webView: WKWebView!
    
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nokri_paymentCompleteData()
    }

    //MARK:- API Calls
    
    func nokri_paymentCompleteData() {
        
        self.showLoader()
        UserHandler.nokri_paymentComplete(success: { (successResponse) in
            
            self.stopAnimating()
            if successResponse.success {
               self.webView.loadHTMLString(successResponse.data.data, baseURL: nil)
            }
            else { 
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
            }
        }) { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
}
