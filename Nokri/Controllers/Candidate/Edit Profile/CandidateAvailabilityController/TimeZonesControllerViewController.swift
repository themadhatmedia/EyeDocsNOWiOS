//
//  TimeZonesControllerViewController.swift
//  Nokri
//
//  Created by Apple on 16/12/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit

protocol TimeZonesDelegate: class {
    func sendTimeZone(timeZone: String, isSelected :Bool)
}



class TimeZonesControllerViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate,UISearchResultsUpdating {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var filteredArray = [CandidateAvailabilityTimeZones]()
    var dataArray = [CandidateAvailabilityTimeZones]()
    
    var searchController = UISearchController(searchResultsController: nil)
    var shouldShowSearchResults = false
    
    
    
//    var timeZones = [String]()
    var delegate : TimeZonesDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        candidateAvailablilityData()
        configureSearchController()
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    //MARK:- Table View Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults {
            return filteredArray.count
        }else{
            return dataArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeZonesTableViewCell", for: indexPath) as! TimeZonesTableViewCell
        if shouldShowSearchResults {
            
            if let name = filteredArray[indexPath.row].value {
                cell.lblTitle.text = name
                cell.btnClick.setTitle(name, for: .normal)

            }
        }else{
            
//            let timeZone  = timeZones[indexPath.row]
            //        let timeZone = TimeZOnes[indexPath.row]
        let objData  = dataArray[indexPath.row]
            cell.lblTitle.text = objData.value
            cell.btnClick.setTitle(dataArray[indexPath.row].value, for: .normal)
            
        }
        
        //cell.btnClick.addTarget(self, action: #selector(btnNext), for: .touchUpInside)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    //btnClick TimeZones
    @IBAction func buttonAction(_ sender: UIButton!) {
//        UserDefaults.standard.set(sender.currentTitle!, forKey:"timeZoneTitle")
//        
//        print(sender.currentTitle as Any)
        delegate?.sendTimeZone(timeZone: sender.currentTitle!,isSelected: true)
        self.perform(#selector(self.moveToParentController), with: nil, afterDelay: 1)
        
    }
    @objc func moveToParentController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Search Bar delegates
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.placeholder = ""
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        searchController.searchBar.searchBarStyle = UISearchBar.Style.prominent
//        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
//        } else {
//            tableView.tableHeaderView = searchController.searchBar
//        }

//        tableView.tableHeaderView = searchController.searchBar
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchController.searchBar.setValue("Done", forKey: "cancelButtonText")
        shouldShowSearchResults = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tableView.reloadData()
        }
        searchController.searchBar.resignFirstResponder()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        filteredArray = dataArray.filter({ (name) -> Bool in
            let nameText: NSString = name.value as NSString
            let range = nameText.range(of: searchString!, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if filteredArray.count == 0 {
            shouldShowSearchResults = false
        } else {
            shouldShowSearchResults = true
        }
        self.tableView.reloadData()
    }

    func candidateAvailablilityData(){
        self.showLoader()
        UserHandler.nokri_candidateAvailability(success: { [self] (successResponse) in
            
            self.stopAnimating()
            if successResponse.success {
                self.dataArray = successResponse.data.zones
                
                print(self.dataArray)
                self.tableView.reloadData()

            }
            else {
                let alert = Constants.showBasicAlert(message: "error")
                self.present(alert, animated: true, completion: nil)
                self.showLoader()
                
                
            }
        }) { (error) in
            self.showLoader()
            
            
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
        
    }

}
