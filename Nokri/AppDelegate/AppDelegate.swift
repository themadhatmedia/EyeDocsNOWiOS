//
//  AppDelegate.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/8/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SlideMenuControllerSwift
import FBSDKCoreKit
import GoogleMaps
import GooglePlaces
import Firebase
import FirebaseAuth
import GoogleSignIn
import SwiftyStoreKit
import UserNotifications
import FirebaseCore
import FirebaseMessaging
import FirebaseInstanceID
 import RAMAnimatedTabBarController

//import Stripe
//com.bundleIdentifier.app

@UIApplicationMain
 class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate,MessagingDelegate {

    var window: UIWindow?
    var navigationBarAppearace = UINavigationBar.appearance()
    var tabBarAppearence = UITabBar.appearance()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
   static var notificationURL = ""
   static var deviceID = ""
   static var serverKEY = ""
   var deviceFcmToken = "0"
    var ad_id = 0
   
    
    
    //MARK:- AppDelegate Circle
    //ca-app-pub-4447917443706771/9721249685
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
       // UIApplication.shared.statusBarStyle = .lightContent
        var preferredStatusBarStyle: UIStatusBarStyle {
              return .lightContent
        }

        //-->> InApp Purchases
        inApp()
    
        //-->> Paypal
         //paypal()
        
        //-->> Keyboard
        IQKeyboardManager.shared.enable = true
      
        //-->> Google
        FirebaseApp.configure()
    
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        
        //-->> Google Map
        GMSServices.provideAPIKey(Constants.GooglePlacesApiKey.placeskey)
        GMSPlacesClient.provideAPIKey(Constants.GooglePlacesApiKey.placeskey)
        //GMSServices.provideAPIKey(Constants.GooglePlacesApiKey.mapkey)
        //GMSPlacesClient.provideAPIKey(Constants.GooglePlacesApiKey.mapkey)
        
        //-->> Facebook
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
    
        Messaging.messaging().delegate = self
       // Messaging.messaging().shouldEstablishDirectChannel = true
        
        if #available(iOS 11, *) {
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in
                print("Granted \(granted)")
            }
            UIApplication.shared.registerForRemoteNotifications()
        } else {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in}
            UIApplication.shared.registerForRemoteNotifications()
            application.registerForRemoteNotifications()
        }
        UIApplication.shared.registerForRemoteNotifications()
        
        //-->> Admob
        //GADMobileAds.configure(withApplicationID: "ca-app-pub-4447917443706771/9721249685")
        
        return true
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        //Messaging.messaging().shouldEstablishDirectChannel = true
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        //Messaging.messaging().shouldEstablishDirectChannel = false
        //Messaging.messaging().shouldEstablishDirectChannel = true
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
       // Messaging.messaging().shouldEstablishDirectChannel = true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        //connectToFcm()
        //Messaging.messaging().shouldEstablishDirectChannel = true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        UserDefaults.standard.set(false, forKey: "isFromNoti")
    }
    
    //    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    //
    //        let willHandleByFacebook = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    //
    //        let willHandleByGoogle =  GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    //
    //        let willHandleByLinkedIn  = LISDKCallbackHandler.application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String?, annotation: nil)
    //
    ////        if LISDKCallbackHandler.shouldHandle(url){
    ////
    ////        }
    //
    //        return willHandleByGoogle || willHandleByFacebook || willHandleByLinkedIn
    //    }
    
    //MARK:- InApp
   
    func inApp(){
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            for purchase in purchases {
                switch purchase.transaction.transactionState {
                case .purchased, .restored:
                    if purchase.needsFinishTransaction {
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                case .failed, .purchasing, .deferred:
                    break
                @unknown default:
                    return
                }
            }
        }
    }
    
    //MARK:- PayPal
    
    func paypal(){
        //-->> Paypal
        //PayPalMobile.initializeWithClientIds(forEnvironments: [
        //PayPalEnvironmentSandbox: "AZIN2bHCAK0AIE7VWwYrXXAPhAm_u1HcYEIrLY9wxmzjdOzsZIj558Hy6bO2BoAfzG29JS-pwWwujjL7"])
        //self.setupNotification(application: application)
        //        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { (isGranted, error) in
        //            if error != nil{
        //                print("Error \(error?.localizedDescription)")
        //            }else{
        //                UNUserNotificationCenter.current().delegate = self
        //                Messaging.messaging().delegate = self
        //                FirebaseApp.configure()
        //            }
        //
        //
        //        }
    }
    
    //MARK:- LinkedIN
    
//    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
//        if LISDKCallbackHandler.shouldHandle(url) {
//            return LISDKCallbackHandler.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
//        }
//        return true
//    }

    //MARK:- Push Notification
    /*
    func setupNotification(application:UIApplication){
        if #available(iOS 10.0, *){
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { (granted, error) in
                if granted {
                    DispatchQueue.main.async {
                        application.registerForRemoteNotifications()
                    }
                }else{
                    print("Permission denied : \(error?.localizedDescription ?? "error")")
                }
            }
        }else{
        }
    }


    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        print("faild to register for remote notification : \(error.localizedDescription)")
    }

    func application(_ application: UIApplication, didrequestAuthorizationRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        #if PROD_BUILD
        Messaging.messaging().setAPNSToken(deviceToken, type: .prod)
        #else
        Messaging.messaging().setAPNSToken(deviceToken, type: .sandbox)
        #endif
        
        Messaging.messaging().apnsToken = deviceToken
        
        let token = deviceToken.base64EncodedString()
        
        let fcmToken = Messaging.messaging().fcmToken
        print("Firebase: FCM token: \(fcmToken ?? "")")
        
        print("Firebase: found token \(token)")
        
        print("Firebase: found token \(deviceToken)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        print(userInfo)
        Messaging.messaging().appDidReceiveMessage(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
        
    }

    func tokenString(_ deviceToken:Data)-> String{
        let bytes = [UInt8](deviceToken)
        var token = ""
        for byte in bytes{
            token += String(format:"&02x",byte)
        }
        return token
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        completionHandler(.alert)
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
        
        
    }
    */
    
    //MARK:- Stripe
    
    //    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    //        let stripeHandled = Stripe.handleURLCallback(with: url)
    //
    //        if (stripeHandled) {
    //            return true
    //        }
    //        else {
    //            // This was not a stripe url, do whatever url handling your app
    //            // normally does, if any.
    //        }
    //
    //        return false
    //    }
    
    // This method is where you handle URL opens if you are using univeral link URLs (eg "https://example.com/stripe_ios_callback")
    //    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
    //        if userActivity.activityType == NSUserActivityTypeBrowsingWeb {
    //            if let url = userActivity.webpageURL {
    //                let stripeHandled = Stripe.handleURLCallback(with: url)
    //
    //                if (stripeHandled) {
    //                    return true
    //                }
    //                else {
    //                    // This was not a stripe url, do whatever url handling your app
    //                    // normally does, if any.
    //                }
    //            }
    //
    //        }
    //        return false
    //    }
    
    
    var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    func nokri_appearance(){
        // UIApplication.shared.statusBarStyle = .lightContent
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        let colorNormal : UIColor = UIColor(hex: "101024 ")
        let colorSelected : UIColor = UIColor.white
        let titleFontNormal : UIFont = UIFont(name: "Helvetica", size: 12.0)!
        let titleFontSelected : UIFont = UIFont.boldSystemFont(ofSize: 15.0)
        let attributesNormal = [
            NSAttributedString.Key.foregroundColor : colorNormal,
            NSAttributedString.Key.font : titleFontNormal
        ]
        let attributesSelected = [
            NSAttributedString.Key.foregroundColor : colorSelected,
            NSAttributedString.Key.font : titleFontSelected
        ]
        UITabBarItem.appearance().setTitleTextAttributes(attributesNormal, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(attributesSelected, for: .selected)
         UITabBar.appearance().unselectedItemTintColor = .black
        //tabBarItem.image = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
    }
    
    
    //MARK:- Navigation Method
    
    func nokri_showLandingPage() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let controller = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LandingViewController")
        appDelegate.window?.rootViewController = controller
    }
    
    func nokri_moveToSignUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
        let navi : UINavigationController = UINavigationController(rootViewController: controller)
        let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
        self.window?.rootViewController = slideMenuController
        self.window?.makeKeyAndVisible()
    }
    
    func nokri_moveToSignUpCustom() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomSignupViewController") as! CustomSignupViewController
        let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
        let navi : UINavigationController = UINavigationController(rootViewController: controller)
        let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
        self.window?.rootViewController = slideMenuController
        self.window?.makeKeyAndVisible()
    }
    
    func nokri_moveToSplash() {
        let HomeVC = storyboard.instantiateViewController(withIdentifier: "SaplashViewController") as! SaplashViewController
        if UserDefaults.standard.string(forKey: "isRtl") == "0" {
            let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
            self.window?.rootViewController = slideMenuController
        } else {
            
            let rightViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi: UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, rightMenuViewController: rightViewController)
            self.window?.rootViewController = slideMenuController
        }
        
        let joI = UserDefaults.standard.integer(forKey: "notijobId")
        HomeVC.adId = joI
        self.window?.makeKeyAndVisible()
    }
    
    func nokri_moveToLang() {
           
           let HomeVC = storyboard.instantiateViewController(withIdentifier: "LanguageViewController") as! LanguageViewController
           if UserDefaults.standard.string(forKey: "isRtl") == "0" {
               let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
               let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
               let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
               self.window?.rootViewController = slideMenuController
           } else {
               
               let rightViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
               let navi: UINavigationController = UINavigationController(rootViewController: HomeVC)
               let slideMenuController = SlideMenuController(mainViewController: navi, rightMenuViewController: rightViewController)
               self.window?.rootViewController = slideMenuController
           }
           self.window?.makeKeyAndVisible()
           
       }
    
    func nokri_moveToSignIn() {
        
        let HomeVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        if UserDefaults.standard.string(forKey: "isRtl") == "0" {
            let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
            self.window?.rootViewController = slideMenuController
        } else {
            
            let rightViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi: UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, rightMenuViewController: rightViewController)
            self.window?.rootViewController = slideMenuController
        }
        self.window?.makeKeyAndVisible()
        
    }

    func nokri_moveToSetting() {
       
        let HomeVC = storyboard.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        if UserDefaults.standard.string(forKey: "isRtl") == "0" {
            let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
            self.window?.rootViewController = slideMenuController
        } else {
            
            let rightViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi: UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, rightMenuViewController: rightViewController)
            self.window?.rootViewController = slideMenuController
        }
        self.window?.makeKeyAndVisible()
    
    }
    
    
    func nokri_moveToHome1(){
        
//        let HomeVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//        //if UserDefaults.standard.string(forKey: "isRtl") == "0" {
//            let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
//            let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
//            let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
//            self.window?.rootViewController = slideMenuController
////
//        self.window?.makeKeyAndVisible()
        
        
        let HomeVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        if UserDefaults.standard.string(forKey: "isRtl") == "0" {
           
            let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
            navi.modalPresentationStyle = .fullScreen
            self.window?.rootViewController = slideMenuController
            
        } else {
            let rightViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi: UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, rightMenuViewController: rightViewController)
            navi.modalPresentationStyle = .fullScreen
            self.window?.rootViewController = slideMenuController
        }
        self.window?.makeKeyAndVisible()
        
    }

    func nokri_moveToHome2(){
        let HomeVC =  storyboard.instantiateViewController(withIdentifier:"HomeOrignalTabViewController") as!  HomeOrignalTabViewController
        
        if UserDefaults.standard.string(forKey: "isRtl") == "0" {
            let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
            self.window?.rootViewController = slideMenuController
        } else {
            
            let rightViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi: UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, rightMenuViewController: rightViewController)
            self.window?.rootViewController = slideMenuController
        }
        self.window?.makeKeyAndVisible()
    }
    
    func nokri_moveToDashBoard() {
        
        let HomeVC = storyboard.instantiateViewController(withIdentifier: "DashboardCompanyViewController") as! DashboardCompanyViewController
        if UserDefaults.standard.string(forKey: "isRtl") == "0" {
            let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
            self.window?.rootViewController = slideMenuController
        } else {
            
            let rightViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi: UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, rightMenuViewController: rightViewController)
            self.window?.rootViewController = slideMenuController
        }
        self.window?.makeKeyAndVisible()
        
    }
    
    func nokri_moveToJobDetail() {
      
           let HomeVC = storyboard.instantiateViewController(withIdentifier: "JobDetailViewController") as! JobDetailViewController
           if UserDefaults.standard.string(forKey: "isRtl") == "0" {
               let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
               let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
               let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
               self.window?.rootViewController = slideMenuController
           } else {

               let rightViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
               let navi: UINavigationController = UINavigationController(rootViewController: HomeVC)
               let slideMenuController = SlideMenuController(mainViewController: navi, rightMenuViewController: rightViewController)
               self.window?.rootViewController = slideMenuController
           }
        
        if ad_id != 0{
            HomeVC.jobId = ad_id
            UserDefaults.standard.set(true, forKey: "isFromNoti")
        }
           self.window?.makeKeyAndVisible()
           
       }
    
    func nokri_moveToMyProfile() {
      
        let HomeVC = storyboard.instantiateViewController(withIdentifier: "MyProfileViewController") as! MyProfileViewController
        if UserDefaults.standard.string(forKey: "isRtl") == "0" {
            let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
            self.window?.rootViewController = slideMenuController
        } else {
            
            let rightViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi: UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, rightMenuViewController: rightViewController)
            self.window?.rootViewController = slideMenuController
        }
        self.window?.makeKeyAndVisible()
    }
    
    func nokri_moveToJobsList() {
       
        let HomeVC = storyboard.instantiateViewController(withIdentifier: "JobsListViewController") as! JobsListViewController
        if UserDefaults.standard.string(forKey: "isRtl") == "0" {
            let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
            self.window?.rootViewController = slideMenuController
        } else {
            
            let rightViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi: UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, rightMenuViewController: rightViewController)
            self.window?.rootViewController = slideMenuController
        }
        self.window?.makeKeyAndVisible()
        
        
        
        
        
        
    }
    
    func nokri_moveToJobsAppliedList() {
       
        let HomeVC = storyboard.instantiateViewController(withIdentifier: "JobsAppliedListViewController") as! JobsAppliedListViewController
        if UserDefaults.standard.string(forKey: "isRtl") == "0" {
            let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
            self.window?.rootViewController = slideMenuController
        } else {
            
            let rightViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi: UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, rightMenuViewController: rightViewController)
            self.window?.rootViewController = slideMenuController
        }
        self.window?.makeKeyAndVisible()
        
    }
    
    func nokri_moveToJobsForYouList() {
        
        let HomeVC = storyboard.instantiateViewController(withIdentifier: "JobsForYouViewController") as! JobsForYouViewController
        if UserDefaults.standard.string(forKey: "isRtl") == "0" {
            let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
            self.window?.rootViewController = slideMenuController
        } else {
            
            let rightViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi: UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, rightMenuViewController: rightViewController)
            self.window?.rootViewController = slideMenuController
        }
        self.window?.makeKeyAndVisible()
        
    }
    
    func nokri_moveToJobsSavedList() {
     
        let HomeVC = storyboard.instantiateViewController(withIdentifier: "JobsSavedListViewController") as! JobsSavedListViewController
        if UserDefaults.standard.string(forKey: "isRtl") == "0" {
            let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
            self.window?.rootViewController = slideMenuController
        } else {
            
            let rightViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi: UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, rightMenuViewController: rightViewController)
            self.window?.rootViewController = slideMenuController
        }
        self.window?.makeKeyAndVisible()
        
    }
    
    func nokri_moveToFollowedCompany() {
     
        let HomeVC = storyboard.instantiateViewController(withIdentifier: "FollowedCompanyListViewController") as! FollowedCompanyListViewController
        if UserDefaults.standard.string(forKey: "isRtl") == "0" {
            let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
            self.window?.rootViewController = slideMenuController
        } else {
            
            let rightViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi: UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, rightMenuViewController: rightViewController)
            self.window?.rootViewController = slideMenuController
        }
        self.window?.makeKeyAndVisible()
        
    }
    
    func nokri_moveToJobNotification() {
       
          let HomeVC = storyboard.instantiateViewController(withIdentifier: "JobNotificationViewController") as! JobNotificationViewController
          if UserDefaults.standard.string(forKey: "isRtl") == "0" {
              let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
              let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
              let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
              self.window?.rootViewController = slideMenuController
          } else {
              
              let rightViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
              let navi: UINavigationController = UINavigationController(rootViewController: HomeVC)
              let slideMenuController = SlideMenuController(mainViewController: navi, rightMenuViewController: rightViewController)
              self.window?.rootViewController = slideMenuController
          }
          self.window?.makeKeyAndVisible()
          
      }
    
    func nokri_moveToJobAlertCompany() {
     
        let HomeVC = storyboard.instantiateViewController(withIdentifier: "JobAlertViewController") as! JobAlertViewController
        if UserDefaults.standard.string(forKey: "isRtl") == "0" {
            let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
            self.window?.rootViewController = slideMenuController
        } else {
            
            let rightViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi: UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, rightMenuViewController: rightViewController)
            self.window?.rootViewController = slideMenuController
        }
        self.window?.makeKeyAndVisible()
        
    }
    
    func nokri_moveTocandPkg() {
        
           let HomeVC = storyboard.instantiateViewController(withIdentifier: "CandPackagesViewController") as! CandPackagesViewController
           if UserDefaults.standard.string(forKey: "isRtl") == "0" {
               let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
               let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
               let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
               self.window?.rootViewController = slideMenuController
           } else {
               
               let rightViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
               let navi: UINavigationController = UINavigationController(rootViewController: HomeVC)
               let slideMenuController = SlideMenuController(mainViewController: navi, rightMenuViewController: rightViewController)
               self.window?.rootViewController = slideMenuController
           }
           self.window?.makeKeyAndVisible()
           
       }
    
    func nokri_moveTocandPkgDetail() {
          
             let HomeVC = storyboard.instantiateViewController(withIdentifier: "CandPkjDetailViewController") as! CandPkjDetailViewController
             if UserDefaults.standard.string(forKey: "isRtl") == "0" {
                 let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
                 let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
                 let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
                 self.window?.rootViewController = slideMenuController
             } else {
                 
                 let rightViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
                 let navi: UINavigationController = UINavigationController(rootViewController: HomeVC)
                 let slideMenuController = SlideMenuController(mainViewController: navi, rightMenuViewController: rightViewController)
                 self.window?.rootViewController = slideMenuController
             }
             self.window?.makeKeyAndVisible()
             
         }
    
    func nokri_moveToBlog() {
      
        let HomeVC = storyboard.instantiateViewController(withIdentifier: "BlogViewController") as! BlogViewController
        if UserDefaults.standard.string(forKey: "isRtl") == "0" {
            let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
            self.window?.rootViewController = slideMenuController
        } else {
            
            let rightViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi: UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, rightMenuViewController: rightViewController)
            self.window?.rootViewController = slideMenuController
        }
        self.window?.makeKeyAndVisible()
        
    }

    func nokri_moveToCompanyDashboard() {
        
        let HomeVC = storyboard.instantiateViewController(withIdentifier: "DashboarCompanyViewController") as! DashboarCompanyViewController
        if UserDefaults.standard.string(forKey: "isRtl") == "0" {
            let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
            self.window?.rootViewController = slideMenuController
        } else {
            
            let rightViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi: UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, rightMenuViewController: rightViewController)
            self.window?.rootViewController = slideMenuController
        }
        self.window?.makeKeyAndVisible()
        
    }
    
    func nokri_moveToTabBarCompanyEditProfile(){
       
        let HomeVC = storyboard.instantiateViewController(withIdentifier: "EditProfileCompanyTabBarController") as! EditProfileCompanyTabBarController
        if UserDefaults.standard.string(forKey: "isRtl") == "0" {
            let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
            self.window?.rootViewController = slideMenuController
        } else {
            
            let rightViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi: UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, rightMenuViewController: rightViewController)
            self.window?.rootViewController = slideMenuController
        }
        self.window?.makeKeyAndVisible()
        
    }
    
    func nokri_moveToTabBarCompanyJob(){
     
        let HomeVC = storyboard.instantiateViewController(withIdentifier: "JobTabBarViewController") as! JobTabBarViewController
        if UserDefaults.standard.string(forKey: "isRtl") == "0" {
            let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
            self.window?.rootViewController = slideMenuController
        } else {
            
            let rightViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi: UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, rightMenuViewController: rightViewController)
            self.window?.rootViewController = slideMenuController
        }
        self.window?.makeKeyAndVisible()
    }
    
    func nokri_moveToCompanyFollower(){
       
        let HomeVC = storyboard.instantiateViewController(withIdentifier: "CompanyFollowerViewController") as! CompanyFollowerViewController
        if UserDefaults.standard.string(forKey: "isRtl") == "0" {
            let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
            self.window?.rootViewController = slideMenuController
        } else {
            
            let rightViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi: UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, rightMenuViewController: rightViewController)
            self.window?.rootViewController = slideMenuController
        }
        self.window?.makeKeyAndVisible()

    }
    
    func nokri_matchResumeCtrl(){
          
           let HomeVC = storyboard.instantiateViewController(withIdentifier: "MatchedResumeViewController") as! MatchedResumeViewController
           if UserDefaults.standard.string(forKey: "isRtl") == "0" {
               let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
               let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
               let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
               self.window?.rootViewController = slideMenuController
           } else {
               
               let rightViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
               let navi: UINavigationController = UINavigationController(rootViewController: HomeVC)
               let slideMenuController = SlideMenuController(mainViewController: navi, rightMenuViewController: rightViewController)
               self.window?.rootViewController = slideMenuController
           }
           self.window?.makeKeyAndVisible()

       }
    
    func nokri_moveToSaveResume(){
          
           let HomeVC = storyboard.instantiateViewController(withIdentifier: "SaveResumeViewController") as! SaveResumeViewController
           if UserDefaults.standard.string(forKey: "isRtl") == "0" {
               let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
               let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
               let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
               self.window?.rootViewController = slideMenuController
           } else {
               
               let rightViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
               let navi: UINavigationController = UINavigationController(rootViewController: HomeVC)
               let slideMenuController = SlideMenuController(mainViewController: navi, rightMenuViewController: rightViewController)
               self.window?.rootViewController = slideMenuController
           }
           self.window?.makeKeyAndVisible()

       }
    
    func nokri_moveToPackageDetail(){
       
        let HomeVC = storyboard.instantiateViewController(withIdentifier: "PackageDetailViewController") as! PackageDetailViewController
        if UserDefaults.standard.string(forKey: "isRtl") == "0" {
            let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
            self.window?.rootViewController = slideMenuController
        } else {
            
            let rightViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi: UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, rightMenuViewController: rightViewController)
            self.window?.rootViewController = slideMenuController
        }
        self.window?.makeKeyAndVisible()
        
    }
    
    func nokri_moveToPackage(){
       
        let HomeVC = storyboard.instantiateViewController(withIdentifier: "PackagesViewController") as! PackagesViewController
        if UserDefaults.standard.string(forKey: "isRtl") == "0" {
            let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
            self.window?.rootViewController = slideMenuController
        } else {
            
            let rightViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi: UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, rightMenuViewController: rightViewController)
            self.window?.rootViewController = slideMenuController
        }
        self.window?.makeKeyAndVisible()
        
    }
    
    func nokri_moveToEmailTemplate(){
   
        let HomeVC = storyboard.instantiateViewController(withIdentifier: "EmailTemplateViewController") as! EmailTemplateViewController
        if UserDefaults.standard.string(forKey: "isRtl") == "0" {
            let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
            self.window?.rootViewController = slideMenuController
        } else {
            
            let rightViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi: UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, rightMenuViewController: rightViewController)
            self.window?.rootViewController = slideMenuController
        }
        self.window?.makeKeyAndVisible()
        
    }
    
    func nokri_moveToJobPost(){
       
        let HomeVC = storyboard.instantiateViewController(withIdentifier: "JobPostViewController") as! JobPostViewController
        if UserDefaults.standard.string(forKey: "isRtl") == "0" {
            let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
            self.window?.rootViewController = slideMenuController
        } else {
            
            let rightViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi: UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, rightMenuViewController: rightViewController)
            self.window?.rootViewController = slideMenuController
        }
        self.window?.makeKeyAndVisible()
    }
    
    func nokri_moveToJobPostCustom(){
          
           let HomeVC = storyboard.instantiateViewController(withIdentifier: "JobPostCustomViewController") as! JobPostCustomViewController
           if UserDefaults.standard.string(forKey: "isRtl") == "0" {
               let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
               let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
               let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
               self.window?.rootViewController = slideMenuController
           } else {
               
               let rightViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
               let navi: UINavigationController = UINavigationController(rootViewController: HomeVC)
               let slideMenuController = SlideMenuController(mainViewController: navi, rightMenuViewController: rightViewController)
               self.window?.rootViewController = slideMenuController
           }
           self.window?.makeKeyAndVisible()
       }
    
 
    func nokri_moveToFaqs(){
      
        let HomeVC = storyboard.instantiateViewController(withIdentifier: "Faq_sViewController") as! Faq_sViewController
        if UserDefaults.standard.string(forKey: "isRtl") == "0" {
            let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
            self.window?.rootViewController = slideMenuController
        } else {
            
            let rightViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi: UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, rightMenuViewController: rightViewController)
            self.window?.rootViewController = slideMenuController
        }
        self.window?.makeKeyAndVisible()
        
    }
    
    func nokri_moveToTabBarEmployeEditProfile(){
       
        let HomeVC = storyboard.instantiateViewController(withIdentifier: "EditProfileEmployeTabBar") as! EditProfileEmployeTabBar
        if UserDefaults.standard.string(forKey: "isRtl") == "0" {
            let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
            self.window?.rootViewController = slideMenuController
        } else {
            
            let rightViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi: UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, rightMenuViewController: rightViewController)
            self.window?.rootViewController = slideMenuController
        }
        self.window?.makeKeyAndVisible()
        
    }
    
  
    func nokri_moveToAdvanceSearch(){
      
        let HomeVC = storyboard.instantiateViewController(withIdentifier: "AdvanceSearchViewController") as! AdvanceSearchViewController
        if UserDefaults.standard.string(forKey: "isRtl") == "0" {
            let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
            self.window?.rootViewController = slideMenuController
        } else {
            
            let rightViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi: UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, rightMenuViewController: rightViewController)
            self.window?.rootViewController = slideMenuController
        }
        self.window?.makeKeyAndVisible()
        
    }
    
    func nokri_moveToEmployerSearch(){
         
           let HomeVC = storyboard.instantiateViewController(withIdentifier: "EmployerSearchViewController") as! EmployerSearchViewController
           if UserDefaults.standard.string(forKey: "isRtl") == "0" {
               let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
               let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
               let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
               self.window?.rootViewController = slideMenuController
           } else {
               
               let rightViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
               let navi: UINavigationController = UINavigationController(rootViewController: HomeVC)
               let slideMenuController = SlideMenuController(mainViewController: navi, rightMenuViewController: rightViewController)
               self.window?.rootViewController = slideMenuController
           }
           self.window?.makeKeyAndVisible()
           
       }
    
    func nokri_moveToCandidateSearch(){
      
        let HomeVC = storyboard.instantiateViewController(withIdentifier: "CandSearchViewController") as! CandSearchViewController
        if UserDefaults.standard.string(forKey: "isRtl") == "0" {
            let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
            self.window?.rootViewController = slideMenuController
        } else {
            
            let rightViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi: UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, rightMenuViewController: rightViewController)
            self.window?.rootViewController = slideMenuController
        }
        self.window?.makeKeyAndVisible()
        
    }
    
    func nokri_moveToMyResume(){
       
        let HomeVC = storyboard.instantiateViewController(withIdentifier: "MyResumeViewController") as! MyResumeViewController
        if UserDefaults.standard.string(forKey: "isRtl") == "0" {
            let leftVC = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi : UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
            self.window?.rootViewController = slideMenuController
        } else {
            
            let rightViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let navi: UINavigationController = UINavigationController(rootViewController: HomeVC)
            let slideMenuController = SlideMenuController(mainViewController: navi, rightMenuViewController: rightViewController)
            self.window?.rootViewController = slideMenuController
        }
        self.window?.makeKeyAndVisible()
        
    }

}

public extension UIColor {
    convenience init(hex: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        var hex:   String = hex
        
        if hex.hasPrefix("#") {
            let index = hex.index(hex.startIndex, offsetBy: 1)
            hex = hex.substring(from: index)
        }
        
        let scanner = Scanner(string: hex)
        var hexValue: CUnsignedLongLong = 0
        if scanner.scanHexInt64(&hexValue) {
            switch (hex.count) {
            case 3:
                red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                blue  = CGFloat(hexValue & 0x00F)              / 15.0
            case 4:
                red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                alpha = CGFloat(hexValue & 0x000F)             / 15.0
            case 6:
                red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
            case 8:
                red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
            default:
                print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8", terminator: "")
            }
        } else {
            print("Scan hex error")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}



extension AppDelegate  {
    
    // MARK: UNUserNotificationCenter Delegate
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        //let content = notification.request.content
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        if ad_id == 0{
//            nokri_moveToSplash()
//        }else{
//             nokri_moveToJobDetail()
//        }
//        let okk = UserDefaults.standard.bool(forKey: "isFromNoti")
//        if okk == false{
//            nokri_moveToJobDetail()
//        }else{
//            nokri_moveToSplash()
//        }
     
        nokri_moveToSplash()
       
        completionHandler()
    }
    
    
     func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            #if PROD_BUILD
            Messaging.messaging().setAPNSToken(deviceToken, type: .prod)
            #else
            Messaging.messaging().setAPNSToken(deviceToken, type: .sandbox)
            #endif
            
            Messaging.messaging().apnsToken = deviceToken
        
            InstanceID.instanceID().instanceID { (result, error) in
                if let error = error {
                    print("Error fetching remote instange ID: \(error)")
                } else if let result = result {
                    print("Remote instance ID token: \(result.token)")
                    self.deviceFcmToken = result.token
                    let defaults =  UserDefaults.standard
                    defaults.setValue(deviceToken, forKey: "fcmToken")
                    defaults.synchronize()
                     let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
                     print(token)
                }
            }
 
        }
        
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("failed to register for remote notifications with with error: \(error)")
    }
    
    func application(_ application: UIApplication, didrequestAuthorizationRemoteNotificationsWithDeviceToken deviceToken: Data) {
        #if PROD_BUILD
        Messaging.messaging().setAPNSToken(deviceToken, type: .prod)
        #else
        Messaging.messaging().setAPNSToken(deviceToken, type: .sandbox)
        #endif
        Messaging.messaging().apnsToken = deviceToken
        let token = deviceToken.base64EncodedString()
        let fcmToken = Messaging.messaging().fcmToken
        print("Firebase: FCM token: \(fcmToken ?? "")")
        print("Firebase: found token \(token)")
        print("Firebase: found token \(deviceToken)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("Firebase: user info \(userInfo)")
        switch application.applicationState {
        case .active:
            break
        case .background, .inactive:
            break 
        @unknown default:
            break
        }
        let gcmMessageIDKey = "gcm.message_id"
        if let messageID = userInfo[gcmMessageIDKey] {
            print("mtech Message ID: \(messageID)")
        }
        Messaging.messaging().appDidReceiveMessage(userInfo)
        let adIDDS = userInfo[AnyHashable("ad_Id")] as? String
        if adIDDS != nil {
            UserDefaults.standard.set(true, forKey: "isFromNoti")
            ad_id = Int(adIDDS!)!
            UserDefaults.standard.set(ad_id, forKey: "notijobId")
        }else{
            UserDefaults.standard.set(false, forKey: "isFromNoti")
        }

        completionHandler(UIBackgroundFetchResult.newData)
    }
   
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        let fcmToken = Messaging.messaging().fcmToken
        let defaults = UserDefaults.standard
        defaults.set(fcmToken, forKey: "fcmToken")
        defaults.synchronize()
    }
 
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
   
 

}
