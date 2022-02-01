//
//  JobPostCountryViewController.swift
//  Nokri
//
//  Created by apple on 1/8/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit

protocol DataCountryDelegate: class {
    func sendLocationId(locationId: Int)
}


class JobPostCountryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,LocSecondLevelDelegate {
    
    

    @IBOutlet weak var tableView: UITableView!
    
    let appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var jobCatArr = [String]()
    var childArr = [Bool]()
    var keyArray = [Int]()
    var delegate : DataCountryDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobCatArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobPostCountryTableViewCell", for: indexPath) as! JobPostCountryTableViewCell
        
        let cat  = jobCatArr[indexPath.row]
        cell.lblTitle.text = cat
        let key = keyArray[indexPath.row]
        cell.btnNext.tag = key
        let child = childArr[indexPath.row]
        cell.btnNext.setTitle(child.description, for: .normal)
        
        if cell.btnNext.currentTitle == "true" {
            cell.imgView.image = UIImage(named: "next")
        }else{
            cell.imgView.image = UIImage(named: "")
        }
        
        cell.btnNext.addTarget(self, action: #selector(JobPostCountryViewController.btnNext), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func sendLocSecondLevelId(locId: Int) {
        print(locId)
        delegate?.sendLocationId(locationId: locId)
        self.perform(#selector(self.nokri_showNavController1), with: nil, afterDelay: 0)

    }
    @objc func btnNext(sender: UIButton!){
        
        UserDefaults.standard.set(sender.tag, forKey:"coKey")
        
        if sender.currentTitle == "false"{
            delegate?.sendLocationId(locationId: sender.tag)
           
            self.perform(#selector(self.nokri_showNavController1), with: nil, afterDelay: 1)
            UserDefaults.standard.set(0, forKey:"co2Key")
            UserDefaults.standard.set(0, forKey:"co3Key")
            UserDefaults.standard.set(0, forKey:"co4Key")
        }else{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "JobPostStateViewController") as? JobPostStateViewController
            vc?.key = sender.tag
            vc?.delegate = self
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
    }
    
    @objc func nokri_showNavController1(){
        UserDefaults.standard.set(true, forKey: "locationSelected")
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true)
    }
    
    
}
