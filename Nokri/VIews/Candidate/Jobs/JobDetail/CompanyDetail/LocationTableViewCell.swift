//
//  LocationTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/1/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import JGProgressHUD


class LocationTableViewCell: UITableViewCell,GMSMapViewDelegate,UITextFieldDelegate ,UITextViewDelegate{

    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSubject: UITextField!
    @IBOutlet weak var txtViewMsg: UITextView!
    @IBOutlet weak var btnSendMsg: UIButton!
    @IBOutlet weak var viewBg: UIView!
   
    
    var sender_name = ""
    var sender_email = ""
    var sender_subject = ""
    var sender_message = ""
    var receiver_id = 0
    var receiver_name = ""
    var receiver_email = ""
    var btn_txt = ""
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var withOutLogin = UserDefaults.standard.string(forKey: "aType")
    
    var markerDict: [Int: GMSMarker] = [:]
    var zoom: Float = 10
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // map()
        txtName.delegate = self
        txtEmail.delegate = self
        txtSubject.delegate = self
        txtViewMsg.delegate = self
        

        sender_name = UserDefaults.standard.string(forKey: "sender_name")!
        sender_email = UserDefaults.standard.string(forKey: "sender_email")!
        sender_subject = UserDefaults.standard.string(forKey: "sender_subject")!
        sender_message = UserDefaults.standard.string(forKey: "sender_message")!
        receiver_id = UserDefaults.standard.integer(forKey: "receiver_id")
        receiver_name = UserDefaults.standard.string(forKey: "receiver_name")!
        receiver_email = UserDefaults.standard.string(forKey: "receiver_email")!
        btn_txt = UserDefaults.standard.string(forKey: "btn_txt")!
        self.btnSendMsg.layer.cornerRadius = 15
        self.btnSendMsg.backgroundColor = UIColor(hex:appColorNew!)
        self.lblName.text = receiver_name
        txtName.placeholder = sender_name
        txtEmail.placeholder = sender_email
        txtSubject.placeholder = sender_subject
        txtViewMsg.text = sender_message
        txtViewMsg.textColor = UIColor.lightGray
        btnSendMsg.setTitle(btn_txt, for: .normal)
        txtViewMsg.layer.borderWidth = 0.5
        txtViewMsg.layer.borderColor = UIColor.lightGray.cgColor

    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = sender_message
            textView.textColor = UIColor.lightGray
        }
    }
    
    
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
      
        if  withOutLogin == "5"{
            self.viewBg.makeToast("Please Login First", duration: 1.5, position: .bottom)
        }else{
            if txtName.text == ""{
                let alert = Constants.showBasicAlert(message: "Please Enter Name")
                self.window?.rootViewController!.present(alert, animated: true, completion: nil)
                
            }else if txtEmail.text == ""{
                let alert = Constants.showBasicAlert(message: "Please Enter Email")
                
                self.window?.rootViewController!.present(alert, animated: true, completion: nil)
                
            }else if isValidEmail(testStr: txtEmail.text!) == false{
                let alert = Constants.showBasicAlert(message: "Please Enter Valid Email")
                
                self.window?.rootViewController!.present(alert, animated: true, completion: nil)
            }
            else if txtSubject.text == ""{
                let alert = Constants.showBasicAlert(message: "Please Enter Subject")
                self.window?.rootViewController!.present(alert, animated: true, completion: nil)
            }else if txtViewMsg.text == ""{
                let alert = Constants.showBasicAlert(message: "Please Enter Message")
                self.window?.rootViewController!.present(alert, animated: true, completion: nil)
            }else{
                
                let param: [String: Any] = [
                    "sender_name": txtName.text!,
                    "sender_email": txtEmail.text!,
                    "sender_subject": txtSubject.text!,
                    "sender_message": txtViewMsg.text!,
                    "receiver_id": receiver_id,
                    "receiver_name": receiver_name,
                    "receiver_email":receiver_email,
                    
                    ]
                print(param)
                self.nokri_ContactPost(parameter: param as NSDictionary)
                
            }

        }
        
       
    }
    
    
    
    
    func nokri_ContactPost(parameter: NSDictionary) {
        //self.showLoader()
        UserHandler.nokri_CandidateContactPost(parameter: parameter as NSDictionary, success: { (successResponse) in
            // self.stopAnimating()
            if successResponse.success == true{
                self.btnSendMsg.isEnabled = true
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = successResponse.message
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.viewBg)
                hud.dismiss(afterDelay: 2.0)
            }
            else {
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.window?.rootViewController!.present(alert, animated: true, completion: nil)
                //self.stopAnimating()
            }
        }) { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.window?.rootViewController!.present(alert, animated: true, completion: nil)
            //self.stopAnimating()
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    //MARKL:- Map
//
//    struct Place {
//        let id: Int
//        let name: String
//        let lat: CLLocationDegrees
//        let lng: CLLocationDegrees
//        let icon: String
//    }
//
//    func map(){
//
//        let camera = GMSCameraPosition.camera(withLatitude: 34.1381168, longitude: -118.3555723, zoom: zoom)
//        self.mapView.camera = camera
//
//        do {
//            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
//                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
//            } else {
//                NSLog("Unable to find style.json")
//            }
//        } catch {
//            NSLog("One or more of the map styles failed to load. \(error)")
//        }
//
//        let places = [
//            Place(id: 0, name: "MrMins", lat: 34.1331168, lng: -118.3550723, icon: "i01"),
//            ]
//
//        for place in places {
//            let marker = GMSMarker()
//            marker.position = CLLocationCoordinate2D(latitude: place.lat, longitude: place.lng)
//            marker.title = place.name
//            marker.snippet = "Custom snipet message \(place.name)"
//
//            //marker.icon = self.imageWithImage(image: UIImage(named: place.icon)!, scaledToSize: CGSize(width: 35.0, height: 35.0))
//            marker.map = self.mapView
//            markerDict[place.id] = marker
//        }
//
//    }

}
