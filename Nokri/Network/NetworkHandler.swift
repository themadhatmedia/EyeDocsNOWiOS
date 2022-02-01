//
//  NetworkHandler.swift
//  AdForest
//
//  Created by apple on 3/8/18.
//  Copyright © 2018 apple. All rights reserved.
//


import Foundation
import Alamofire

class NetworkHandler {
    
    
    class func postRequest(url: String, parameters: Parameters?, success: @escaping (Any) -> Void, failure: @escaping (NetworkError) -> Void) {
        
        
        var langCode = UserDefaults.standard.string(forKey: "langCode")
        if langCode == nil {
            langCode = "en"
        }
        
        if Network.isAvailable {
            
            var headers: HTTPHeaders
            
            if UserDefaults.standard.bool(forKey: "isSocial") == true {
                print("Social Login")
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
                
                print(base64String)
                
                headers = [
                    "Content-Type": "application/json",
                    "Authorization" : "Basic \(base64String)",
                    "NOKRI-LOGIN-TYPE": "social",
                    "Purchase-Code" : Constants.customCodes.purchaseCode,
                    "Custom-Security": Constants.customCodes.securityCode,
                    "Nokri-Request-From" : Constants.customCodes.requestFrom,
                    "Nokri-Lang-Locale" : "\(langCode!)"
                ]
            }
            else {
                var email = ""
                var password = ""
                if let userEmail = UserDefaults.standard.string(forKey: "email") {
                    email = userEmail
                }
                if let userPassword = UserDefaults.standard.string(forKey: "password") {
                    password = userPassword
                }
                print(email, password)
                let emailPass = "\(email):\(password)"
                let encodedString = emailPass.data(using: String.Encoding.utf8)!
                let base64String = encodedString.base64EncodedString(options: [])
                
                print(base64String)
                
                headers = [
                    "Content-Type": "application/json",
                    "Authorization" : "Basic \(base64String)",
                    "Purchase-Code" : Constants.customCodes.purchaseCode,
                    "Custom-Security": Constants.customCodes.securityCode,
                    "Nokri-Request-From" : Constants.customCodes.requestFrom,
                    "Nokri-Lang-Locale" : "\(langCode!)"
                ]
            }
            print(headers)
           
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = Constants.NetworkError.timeOutInterval
            print(Parameters.self)
            manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200..<600).responseJSON
                { (response) -> Void in
                
                debugPrint(response)
                print(response)
                
                if let userToken = response.response?.allHeaderFields["Authorization"] as? String {
                    print(userToken)
                    debugPrint(userToken)
                    UserDefaults.standard.setValue(userToken, forKey: "userAuthToken")
                    debugPrint("\(UserDefaults.standard.value(forKey: "userAuthToken")!)")
                }
                
                guard let statusCode = response.response?.statusCode else {
                    var networkError = NetworkError()
                    
                    networkError.status = Constants.NetworkError.timout
                    networkError.message = Constants.NetworkError.timoutError
                    
                    failure(networkError)
                    return
                    
                }
                
                if statusCode == 422 {
                    var networkError = NetworkError()
                    
                    let response = response.result.value!
                    let dictionary = response as! [String: AnyObject]
                    
                    guard let message = dictionary["error"] as! String? else {
                        networkError.status = statusCode
                        networkError.message = "Validation Error"
                        
                        failure(networkError)
                        
                        return
                    }
                    networkError.status = statusCode
                    networkError.message = message
                    
                    failure(networkError)
                    
                    
                }else{
                    switch (response.result) {
                    case .success:
                        let response = response.result.value!
                        success(response)
                        break
                    case .failure(let error):
                        var networkError = NetworkError()
                        
                        if error._code == NSURLErrorTimedOut {
                            networkError.status = Constants.NetworkError.timout
                            networkError.message = Constants.NetworkError.timoutError
                            
                            failure(networkError)
                        } else {
                            networkError.status = Constants.NetworkError.generic
                            networkError.message = Constants.NetworkError.genericError
                            
                            failure(networkError)
                        }
                        break
                    }
                }
            }
        } else {
            let networkError = NetworkError(status: Constants.NetworkError.internet, message: Constants.NetworkError.internetError)
            failure(networkError)
        }
    }
    
    
    class func getRequest(url: String, parameters: Parameters?, success: @escaping (Any?) -> Void, failure: @escaping (NetworkError) -> Void) {
        
        var langCode = UserDefaults.standard.string(forKey: "langCode")
        if langCode == nil {
            langCode = "en"
        }
        
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = Constants.NetworkError.timeOutInterval
        
       var headers: HTTPHeaders

        if UserDefaults.standard.bool(forKey: "isSocial") {
            
            print("Social Login")
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
            
            print(base64String)
            
            headers = [
                "Accept": "application/json",
                "Authorization" : "Basic \(base64String)",
                "NOKRI-LOGIN-TYPE": "social",
                "Purchase-Code" : Constants.customCodes.purchaseCode,
                "Custom-Security": Constants.customCodes.securityCode,
                "Nokri-Request-From" : Constants.customCodes.requestFrom,
                "Nokri-Lang-Locale" : "\(langCode!)"
            ]
        }
        else {
            
            var email = ""
            var password = ""
            if let userEmail = UserDefaults.standard.string(forKey: "email") {
                email = userEmail
            }
            if let userPassword = UserDefaults.standard.string(forKey: "password") {
                password = userPassword
            }
            print(email, password)
            let emailPass = "\(email):\(password)"
            let encodedString = emailPass.data(using: String.Encoding.utf8)!
            let base64String = encodedString.base64EncodedString(options: [])
            print(base64String)
          headers = [
                "Content-Type": "application/json",
                "Authorization" : "Basic \(base64String)",
                "Purchase-Code" : Constants.customCodes.purchaseCode,
                "Custom-Security": Constants.customCodes.securityCode,
                "Nokri-Request-From" : Constants.customCodes.requestFrom,
                "Nokri-Lang-Locale" : "\(langCode!)"
            ]
        }
       
        print(headers)
        
        manager.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) -> Void in
      
            debugPrint(response)
            print(response)
            switch response.result{
            //Case 1
            case .success:
                let response = response.result.value!
                print(response)
                success(response)
               
                
                break
            case .failure (let error):
            
                var networkError = NetworkError()
                
                if error._code == NSURLErrorTimedOut {
                    networkError.status = Constants.NetworkError.timout
                    networkError.message = Constants.NetworkError.timoutError
                    
                    failure(networkError)
                } else {
                    networkError.status = Constants.NetworkError.generic
                    networkError.message = Constants.NetworkError.genericError
                    
                    failure(networkError)
                }
                break
            }
        }
    }
    
    
    class func getRequestNew(url: String, parameters: Parameters?, success: @escaping (Any?) -> Void, failure: @escaping (NetworkError) -> Void) {
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = Constants.NetworkError.timeOutInterval
        
        var headers: HTTPHeaders
        
        if UserDefaults.standard.bool(forKey: "isSocial") {
            print("Social Login")
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
            
            print(base64String)
            
            headers = [
                "Accept": "application/json",
                "Authorization" : "Basic \(base64String)",
                "NOKRI-LOGIN-TYPE": "social",
                //just add security
                "Purchase-Code" : Constants.customCodes.purchaseCode,
                "Custom-Security": Constants.customCodes.securityCode,
                 "Nokri-Request-From" : Constants.customCodes.requestFrom
            ]
        }
        else {
            
            var email = ""
            var password = ""
            if let userEmail = UserDefaults.standard.string(forKey: "email") {
                email = userEmail
            }
            if let userPassword = UserDefaults.standard.string(forKey: "password") {
                password = userPassword
            }
            
            print(email, password)
            
            let emailPass = "\(email):\(password)"
            let encodedString = emailPass.data(using: String.Encoding.utf8)!
            let base64String = encodedString.base64EncodedString(options: [])
            
            print(base64String)
            
            
            headers = [
                "Content-Type": "application/json",
                
                "Authorization" : "Basic \(base64String)",
                //just add security
                "Purchase-Code" : Constants.customCodes.purchaseCode,
                "Custom-Security": Constants.customCodes.securityCode,
                "Nokri-Request-From" : Constants.customCodes.requestFrom
            ]
        }
        
        print(headers)
        
        manager.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseString { (response) in
            print(response)
        }
        
        
        
//        responseJSON { (response) -> Void in
//
//            debugPrint(response)
//            print(response)
//            switch response.result{
//            //Case 1
//            case .success:
//                let response = response.result.value!
//                print(response)
//                success(response)
//
//
//                break
//            case .failure (let error):
//
//                var networkError = NetworkError()
//
//                if error._code == NSURLErrorTimedOut {
//                    networkError.status = Constants.NetworkError.timout
//                    networkError.message = Constants.NetworkError.timoutError
//
//                    failure(networkError)
//                } else {
//                    networkError.status = Constants.NetworkError.generic
//                    networkError.message = Constants.NetworkError.genericError
//
//                    failure(networkError)
//                }
//                break
//            }
//        }
    }
    
    // MARK: Upload Multipart File
    
    class func upload(url: String, fileUrl: URL, fileName: String, params: Parameters?, uploadProgress: @escaping (Int) -> Void, success: @escaping (Any?) -> Void, failure: @escaping (NetworkError) -> Void) {
        
        var headers: HTTPHeaders
        
        if UserDefaults.standard.bool(forKey: "isSocial") {
            print("Social Login")
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
            
            print(base64String)
            
            headers = [
               // "Content-Type": "application/json",
                "Authorization" : "Basic \(base64String)",
                "NOKRI-LOGIN-TYPE": "social",
                "Purchase-Code" : Constants.customCodes.purchaseCode,
                "Custom-Security": Constants.customCodes.securityCode,
                "Nokri-Request-From" : Constants.customCodes.requestFrom
            ]
        }
        else {
            var email = ""
            var password = ""
            if let userEmail = UserDefaults.standard.string(forKey: "email") {
                email = userEmail
            }
            if let userPassword = UserDefaults.standard.string(forKey: "password") {
                password = userPassword
            }
            print(email, password)
            let emailPass = "\(email):\(password)"
            let encodedString = emailPass.data(using: String.Encoding.utf8)!
            let base64String = encodedString.base64EncodedString(options: [])
            
            print(base64String)
            
            headers = [
                //"Content-Type": "application/json",
                "Authorization" : "Basic \(base64String)",
                "Purchase-Code" : Constants.customCodes.purchaseCode,
                "Custom-Security": Constants.customCodes.securityCode,
                "Nokri-Request-From" : Constants.customCodes.requestFrom
            ]
        }
        print(headers)
        
        Alamofire.upload(multipartFormData:{ multipartFormData in
            multipartFormData.append(fileUrl, withName: fileName)

            if let parameters = params {
                for (key, value) in parameters {
                    multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
                }
            }

        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers, encodingCompletion: { encodingResult in
    
        
            switch encodingResult {
                
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    let progress = Int(progress.fractionCompleted * 100)
                    uploadProgress(progress)
                })
                
                upload.responseJSON { response in
                    print(response)
                    
                    let returnValue = response.result.value!
                    
                    if let userToken = response.response?.allHeaderFields["Authorization"] as? String {
                        
                        print("User Token is \(userToken)")
                        UserDefaults.standard.set(userToken, forKey: "userAuthToken")
                        UserDefaults.standard.synchronize()
                        
                    }
                    success(returnValue)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                var networkError = NetworkError()
                
                if error._code == NSURLErrorTimedOut {
                    networkError.status = Constants.NetworkError.timout
                    networkError.message = Constants.NetworkError.timoutError
                     // self.stopActivityIndicator()
                    failure(networkError)
                } else {
                    networkError.status = Constants.NetworkError.generic
                    networkError.message = Constants.NetworkError.genericError
                    
                    failure(networkError)
                }
            }
        })
    }
    
    class func uploadVideo(url: String, fileUrl: URL, fileName: String, params: Parameters?, uploadProgress: @escaping (Int) -> Void, success: @escaping (Any?) -> Void, failure: @escaping (NetworkError) -> Void) {
        
        var headers: HTTPHeaders
        
        if UserDefaults.standard.bool(forKey: "isSocial") {
            print("Social Login")
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
            
            print(base64String)
            
            headers = [
               // "Content-Type": "application/json",
                "Authorization" : "Basic \(base64String)",
                "NOKRI-LOGIN-TYPE": "social",
                "Purchase-Code" : Constants.customCodes.purchaseCode,
                "Custom-Security": Constants.customCodes.securityCode,
                "Nokri-Request-From" : Constants.customCodes.requestFrom
            ]
        }
        else {
            var email = ""
            var password = ""
            if let userEmail = UserDefaults.standard.string(forKey: "email") {
                email = userEmail
            }
            if let userPassword = UserDefaults.standard.string(forKey: "password") {
                password = userPassword
            }
            print(email, password)
            let emailPass = "\(email):\(password)"
            let encodedString = emailPass.data(using: String.Encoding.utf8)!
            let base64String = encodedString.base64EncodedString(options: [])
            
            print(base64String)
            
            headers = [
                //"Content-Type": "application/json",
                "Authorization" : "Basic \(base64String)",
                "Purchase-Code" : Constants.customCodes.purchaseCode,
                "Custom-Security": Constants.customCodes.securityCode,
                "Nokri-Request-From" : Constants.customCodes.requestFrom
            ]
        }
        print(headers)
        
        
      
        Alamofire.upload( multipartFormData: { multipartFormData in
                    multipartFormData.append(fileUrl, withName: "resume_video", fileName: "resume_video.MOV", mimeType: "video/MOV")

                }, to: url,headers: headers, encodingCompletion: { encodingResult in
                    switch encodingResult {
                    
                    case .success(let upload, _, _):
                        upload.uploadProgress(closure: { (progress) in
                            let progress = Int(progress.fractionCompleted * 85)
                            uploadProgress(progress)
                        })
                        upload.responseJSON { response in
                             let JSON = response.result.value as? NSDictionary
                               // completion(true)
                            //} else {
                                //completion(false)
                            
                                print(response)
                            //}
            
                            success(JSON)
                            
                        }
                    case .failure(let encodingError):
                        print(encodingError)
                        //completion(false)
                    }
                })
        
        
        
      
        
    }
    
    
    
    class func uploadImageArray(url: String, imagesArray: [UIImage], fileName: String, params: Parameters?, uploadProgress: @escaping (Int) -> Void, success: @escaping (Any?) -> Void, failure: @escaping (NetworkError) -> Void) {
        
        var headers: HTTPHeaders
        
        
        if UserDefaults.standard.bool(forKey: "isSocial") {
            print("Social Login")
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
            print(base64String)
            headers = [
                //"Accept": "application/json",
                "Authorization" : "Basic \(base64String)",
                "NOKRI-LOGIN-TYPE": "social",
                "Purchase-Code" : Constants.customCodes.purchaseCode,
                "Custom-Security": Constants.customCodes.securityCode,
                "Nokri-Request-From" : Constants.customCodes.requestFrom
            ]
        }
        else {
            var email = ""
            var password = ""
            if let userEmail = UserDefaults.standard.string(forKey: "email") {
                email = userEmail
            }
            if let userPassword = UserDefaults.standard.string(forKey: "password") {
                password = userPassword
            }
            print(email, password)
            let emailPass = "\(email):\(password)"
            let encodedString = emailPass.data(using: String.Encoding.utf8)!
            let base64String = encodedString.base64EncodedString(options: [])
            headers = [
            
                "Authorization" : "Basic \(base64String)",
                "Purchase-Code" : Constants.customCodes.purchaseCode,
                "Custom-Security": Constants.customCodes.securityCode,
                "Nokri-Request-From" : Constants.customCodes.requestFrom
            ]
        }
        print(headers)
        
        Alamofire.upload(multipartFormData:{ multipartFormData in
            var i = 0
            print(imagesArray.count)
            
            for image in imagesArray {
                print(image.description)
                
                let imageData = image.resize()
                print(imageData)
                multipartFormData.append(imageData,  withName: "nverness\(i).jpg", fileName: "Inverness\(i).jpg" , mimeType: "image/jpeg")
                    
                    i = i + 1
                print(fileName)
                print(image.description)
                
            }
            
            if let parameters = params {
                for (key, value) in parameters {
                    print("Key \(key), Value\(value)")

                    multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
                }
            }
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers, encodingCompletion: { encodingResult in
            
            
            switch encodingResult {
                
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    let progress = Int(progress.fractionCompleted * 100)
                    uploadProgress(progress)
                })
                
                upload.responseJSON { response in
                    print(response)
                    
                    let returnValue = response.result.value!
                    
                    if let userToken = response.response?.allHeaderFields["Authorization"] as? String {
                        
                        print("User Token is \(userToken)")
                        UserDefaults.standard.set(userToken, forKey: "userAuthToken")
                        UserDefaults.standard.synchronize()
                        
                    }
                    
                    success(returnValue)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                var networkError = NetworkError()
                
                if error._code == NSURLErrorTimedOut {
                    networkError.status = Constants.NetworkError.timout
                    networkError.message = Constants.NetworkError.timoutError
                    
                    failure(networkError)
                } else {
                    networkError.status = Constants.NetworkError.generic
                    networkError.message = Constants.NetworkError.genericError
                    
                    failure(networkError)
                }
            }
        })
    }
    
    class func uploadImageArrayNew(url: String, imagesArray: [UIImage], fileName: String, params: Parameters?, uploadProgress: @escaping (Int) -> Void, success: @escaping (Any?) -> Void, failure: @escaping (NetworkError) -> Void) {
        
        var headers: HTTPHeaders
        if UserDefaults.standard.bool(forKey: "isSocial") {
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
            print(base64String)
            headers = [
                //"Accept": "application/json",
                "Authorization" : "Basic \(base64String)",
                "NOKRI-LOGIN-TYPE": "social",
                //just add security
                "Purchase-Code" : Constants.customCodes.purchaseCode,
                "Custom-Security": Constants.customCodes.securityCode,
                "Nokri-Request-From" : Constants.customCodes.requestFrom
            ]
        }
        else {
            var email = ""
            var password = ""
            if let userEmail = UserDefaults.standard.string(forKey: "email") {
                email = userEmail
            }
            if let userPassword = UserDefaults.standard.string(forKey: "password") {
                password = userPassword
            }
            print(email, password)
            let emailPass = "\(email):\(password)"
            let encodedString = emailPass.data(using: String.Encoding.utf8)!
            let base64String = encodedString.base64EncodedString(options: [])
            headers = [
                //  "Accept": "application/json",
                
                "Authorization" : "Basic \(base64String)",
                //just add security
                "Purchase-Code" : Constants.customCodes.purchaseCode,
                "Custom-Security": Constants.customCodes.securityCode,
                "Nokri-Request-From" : Constants.customCodes.requestFrom
            ]
        }
        print(headers)
        
        Alamofire.upload(multipartFormData:{ multipartFormData in
            var i = 0
            for image in imagesArray {
                 let imageData = image.resize()
                    print(imageData)
                    multipartFormData.append(imageData,  withName: "portfolio_upload[]", fileName: "Inverness\(i).jpg" , mimeType: "image/jpeg")
                    i = i + 1
                    print(fileName)
                    print(image.description)
                
              
            }
            if let parameters = params {
                for (key, value) in parameters {
                    print("Key \(key), Value\(value)")
                    multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
                }
            }
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers, encodingCompletion: { encodingResult in
            
            
            switch encodingResult {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    let progress = Int(progress.fractionCompleted * 100)
                    uploadProgress(progress)
                })
                upload.responseJSON { response in
                    
                    let returnValue = response.result.value as? [String:Any]
                    if let userToken = response.response?.allHeaderFields["Authorization"] as? String {
                        UserDefaults.standard.set(userToken, forKey: "userAuthToken")
                        UserDefaults.standard.synchronize()
                    }
                    success(returnValue)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                var networkError = NetworkError()
                
                if error._code == NSURLErrorTimedOut {
                    networkError.status = Constants.NetworkError.timout
                    networkError.message = Constants.NetworkError.timoutError
                    
                    failure(networkError)
                } else {
                    networkError.status = Constants.NetworkError.generic
                    networkError.message = Constants.NetworkError.genericError
                    
                    failure(networkError)
                }
            }
        })
    }
    
    class func postRequestNew(url: String, parameters: Parameters?, success: @escaping (Any) -> Void, failure: @escaping (NetworkError) -> Void) {
        
        if Network.isAvailable {
            
            var headers: HTTPHeaders
            
            if UserDefaults.standard.bool(forKey: "isSocial") {
                print("Social Login")
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
                
                print(base64String)
                
                headers = [
                    "Content-Type": "application/json",
                    "Authorization" : "Basic \(base64String)",
                    "NOKRI-LOGIN-TYPE": "social",
                    //just add security
                    "Purchase-Code" : Constants.customCodes.purchaseCode,
                    "Custom-Security": Constants.customCodes.securityCode,
                    "Nokri-Request-From" : Constants.customCodes.requestFrom
                ]
            }
            else {
                var email = ""
                var password = ""
                if let userEmail = UserDefaults.standard.string(forKey: "email") {
                    email = userEmail
                }
                if let userPassword = UserDefaults.standard.string(forKey: "password") {
                    password = userPassword
                }
                print(email, password)
                let emailPass = "\(email):\(password)"
                let encodedString = emailPass.data(using: String.Encoding.utf8)!
                let base64String = encodedString.base64EncodedString(options: [])
                
                print(base64String)
                
                headers = [
                    "Content-Type": "application/json",
                    "Authorization" : "Basic \(base64String)",
                    "Purchase-Code" : Constants.customCodes.purchaseCode,
                    "Custom-Security": Constants.customCodes.securityCode,
                    "Nokri-Request-From" : Constants.customCodes.requestFrom
                ]
            }
            print(headers)
            
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = Constants.NetworkError.timeOutInterval
            print(Parameters.self)
            manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200..<600).responseString
                { (response) -> Void in
                    
                    debugPrint(response)
                    print(response)
                    
                    if let userToken = response.response?.allHeaderFields["Authorization"] as? String {
                        print(userToken)
                        debugPrint(userToken)
                        UserDefaults.standard.setValue(userToken, forKey: "userAuthToken")
                        debugPrint("\(UserDefaults.standard.value(forKey: "userAuthToken")!)")
                    }
                    
                    guard let statusCode = response.response?.statusCode else {
                        var networkError = NetworkError()
                        
                        networkError.status = Constants.NetworkError.timout
                        networkError.message = Constants.NetworkError.timoutError
                        
                        failure(networkError)
                        return
                    }
                    
                    if statusCode == 422 {
                        var networkError = NetworkError()
                        
                       // let response = response.result.value!
                        //let dictionary = response 
                        
//                        guard let message = dictionary["error"] as! String? else {
                        guard let message = networkError.message as String? else {
                            networkError.status = statusCode
                            networkError.message = "Validation Error"
                            
                            failure(networkError)
                            
                            return
                        }
                        networkError.status = statusCode
                        networkError.message = message
                        
                        failure(networkError)
                        
                        
                    }else{
                        switch (response.result) {
                        case .success:
                            let response = response.result.value!
                            success(response)
                            break
                        case .failure(let error):
                            var networkError = NetworkError()
                            
                            if error._code == NSURLErrorTimedOut {
                                networkError.status = Constants.NetworkError.timout
                                networkError.message = Constants.NetworkError.timoutError
                                
                                failure(networkError)
                            } else {
                                networkError.status = Constants.NetworkError.generic
                                networkError.message = Constants.NetworkError.genericError
                                
                                failure(networkError)
                            }
                            break
                        }
                    }
            }
        } else {
            let networkError = NetworkError(status: Constants.NetworkError.internet, message: Constants.NetworkError.internetError)
            failure(networkError)
        }
    }
    
    
}

struct NetworkError {
    var status: Int = Constants.NetworkError.generic
    var message: String = Constants.NetworkError.genericError
}

struct NetworkSuccess {
    var status: Int = Constants.NetworkError.generic
    var message: String = Constants.NetworkError.genericError
}

extension UIImage {
    
    func resize() -> Data {
        var actualHeight = Float(self.size.height)
        var actualWidth = Float(self.size.width)
        let maxHeight: Float = 300.0
        let maxWidth: Float = 400.0
        var imgRatio: Float = actualWidth / actualHeight
        let maxRatio: Float = maxWidth / maxHeight
        let compressionQuality: Float = 1
        //50 percent compression
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            }
            else if imgRatio > maxRatio {
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            }
            else {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }
        let rect = CGRect(x: 0.0, y: 0.0, width: CGFloat(actualWidth), height: CGFloat(actualHeight))
        UIGraphicsBeginImageContext(rect.size)
        self.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        let imageData = img!.jpegData(compressionQuality: CGFloat(compressionQuality))

        UIGraphicsEndImageContext()
        return imageData!
   
    }
    
}
