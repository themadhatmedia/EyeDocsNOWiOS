//
//  AddQuestionairViewController.swift
//  Nokri
//
//  Created by apple on 4/15/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit


protocol questionProto {
    func questionDat(question:[String])
}

class AddQuestionairViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,questionsProtocol {
  
    

    //MARK:- IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnDone: UIButton!
    
    //MARK:- Proporties
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var questionsCount = [String]()
    var deletePlanetIndexPath: NSIndexPath? = nil
    var indexPa = 0
    var questionD = ""
    var questionsArray = [String]()
    var qLblText = ""
    var qPlacehoderText = ""
    var qTxt = ""
    var isFromEdit = 0
    var questionsFromEdit = [String]()
    
    var delegate : questionProto?
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        self.title = qTxt
        btnDone.backgroundColor = UIColor(hex: appColorNew!)
        
    }
    
    //MARK:- TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionsCount.count + questionsFromEdit.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddQuestionairTableViewCell", for: indexPath) as! AddQuestionairTableViewCell
        if isFromEdit == 0{
            cell.index = indexPath.row
            cell.delegate = self
            cell.lblQuestion.text = qLblText
            cell.txtFieldQuestion.placeholder = qPlacehoderText
            cell.txtFieldQuestion.text = questionsFromEdit[indexPath.row]
        }else{
            cell.index = indexPath.row
            cell.delegate = self
            cell.lblQuestion.text = qLblText
            cell.txtFieldQuestion.placeholder = qPlacehoderText
        }
     
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            deletePlanetIndexPath = indexPath as NSIndexPath
             let planetToDelete = questionsCount[indexPath.row]
             confirmDelete(planet: planetToDelete)
        }
    }
    
    @IBAction func btnDoneClicked(_ sender: UIButton) {
         delegate?.questionDat(question: questionsArray)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addBtnClicked(_ sender: UIButton) {
        questionsCount.append("2")
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: questionsCount.count-1, section: 0)], with: .automatic)
        tableView.endUpdates()
    }
    
    func confirmDelete(planet: String) {
        
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                 let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                 let dataTabs = SplashRoot(fromDictionary: objData)
                 let obj = dataTabs.data.genericTxts
            
            let alert = UIAlertController(title: obj?.confirm, message: nil , preferredStyle: .actionSheet)
                   
                   let DeleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: handleDeletePlanet)
                   let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelDeletePlanet)
                   alert.addAction(DeleteAction)
                   alert.addAction(CancelAction)
                   alert.popoverPresentationController?.sourceView = self.view
                   alert.popoverPresentationController?.sourceRect = tableView.frame
                   self.present(alert, animated: true, completion: nil)
            
        }
     
    }
    
    func handleDeletePlanet(alertAction: UIAlertAction!) -> Void {
        if let indexPath = deletePlanetIndexPath {
            tableView.beginUpdates()
            questionsCount.remove(at: indexPath.row)
            tableView.deleteRows(at: [(indexPath as IndexPath)], with: .automatic)
            deletePlanetIndexPath = nil
            tableView.endUpdates()
        }
    }
    
    func cancelDeletePlanet(alertAction: UIAlertAction!) {
        deletePlanetIndexPath = nil
    }
    
    func questionsData(indexP: Int, questionString: String) {
          indexPa = indexP
          questionD = questionString
          questionsArray.append(questionD)
          print(questionsArray)
        
      }
    
}
