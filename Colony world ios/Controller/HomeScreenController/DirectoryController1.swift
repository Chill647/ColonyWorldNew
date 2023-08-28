//
//  DirectoryController1.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 29/05/23.
//

import UIKit

class DirectoryController1: UIViewController {
   
    @IBOutlet weak var cornerView: UIView!
    @IBOutlet var mainView: UIView!
    var hiddenSections: Set<Int> = Set([0, 1, 2])
    var sectionHeader = ["Society Resident List","Society Incharge List","Block Incharge List"]
  
    var directoryModel:DirectoryModal?
    var residentArray = [ResidentList]()
  //  var ownerArray = [OwnerList]()
    var blockArray = [InchargeList]()
    var soceityArray = [InchargeList]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateScreen()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: "DirectoryCell", bundle: nil), forCellReuseIdentifier: "DirectoryCell")
        tableView.register(UINib(nibName: "SectionHeaderCell", bundle: nil), forCellReuseIdentifier: "SectionHeaderCell")
        DirectoryApi()
    }
   
    func updateScreen(){
        cornerView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        mainView.backgroundColor = getepayYellowColor
        
        cornerView.CornerRadious  = 20
    }
    
    
    
    func DirectoryApi(){
        
        let tag:String = "society_directory"
        var UserEmail = UserDefaults.standard.string(forKey: "userEmail") ?? ""
        var userPass = UserDefaults.standard.string(forKey: "userPass") ?? ""
        var loggedRole =  UserDefaults.standard.string(forKey: "loggedRole") ?? ""
        let parameters: [String: Any] = [
            "tag" : tag,
            "userEmail" : UserEmail,
            "userPass"  : userPass,
            "society_id" :societyId,
            "loggedRole": loggedRole
        ]
        print("DirectoryApiRequestbody-->\(parameters)")
    
        var url : String = baseSeverUrl
        WebParamsApiManager.perFormRequest(url: url, params: parameters) { [self](res, error, errorcode) in
          
            print("DirectoryApiResponse--->\(res)")
           
            if error == nil{
               
                if let obj:NSDictionary =  res as? NSDictionary{
                    print(obj)
                    if let status:Int = 1 as? Int{
                        print(status)
                        if status == 1{
                            self.removeSpinner_N()
                            if res != nil{
                                do {
                                    if let jsonData = WebAPIManager.jsonToString(json: res as Any).data(using: .utf8) {
                                        let decoder = JSONDecoder()
                                        self.directoryModel = try decoder.decode(DirectoryModal.self, from: jsonData)
                                      
                                        
                                    if self.directoryModel?.residentList.count != 0 {
                                    self.residentArray.append(contentsOf: (self.directoryModel?.residentList)!)
                                    print("residentArraylist--->\(self.residentArray)")
                                        
                                        self.soceityArray.append(contentsOf: (self.directoryModel?.societyInchargeList)!)
                                        print("soceityArraylist--->\(self.soceityArray)")
                                 
                                        self.blockArray.append(contentsOf: (self.directoryModel?.blockInchargeList)!)
                                        print("blockArraylist--->\(self.blockArray)")
                                        
                                    } else{
                                      self.removeSpinner_N()
                                                                           
                                     }
                                        
                                    } else {
                                        // Handle the case when jsonData is nil
                                    }
                                } catch {
                                    print("Error decoding JSON: \(error)")
                                    // Handle the decoding error, such as displaying an error message to the user
                                }
                              
                             
                            } else {
                                self.removeSpinner_N()
                                self.displayMessage("Something went Wrong, pls try again!!")
                            }
                      
                        }else{
                            self.removeSpinner_N()
                            if let msg :String = obj["message"] as? String{
                                self.displayMessage(msg)
                            }
                        }
                    }else{
                        self.removeSpinner_N()
                        if let msg :String = obj["message"] as? String{
                            self.displayMessage(msg)
                        }
                        
                    }
                }else{
                    self.removeSpinner_N()
                    self.displayMessage("Something Went Wrong,Pls Try agian")
                }
            }else{
                self.removeSpinner_N()
                self.displayMessage("Something Went Wrong,Pls Try agian")
            }
          

        }
        
    
        
    }
}


extension DirectoryController1:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.hiddenSections.contains(section) {
               return 1 // Return 1 row for the section header cell when the section is hidden
           }

           if section == 0 {
             //  return self.tableViewData[section].count + 1  // Return count for section 0 (including the section header cell)
               return residentArray.count
           } else if section == 1 {
               return soceityArray.count
           } else if section == 2 {
               return  blockArray.count
           }

           return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let sectionHeaderCell = tableView.dequeueReusableCell(withIdentifier: "SectionHeaderCell", for: indexPath) as! SectionHeaderCell
            sectionHeaderCell.titleLabel.text = sectionHeader[indexPath.section]
            sectionHeaderCell.expandButton.isSelected = !self.hiddenSections.contains(indexPath.section)
            sectionHeaderCell.expandButton.tag = indexPath.section
            sectionHeaderCell.expandButton.addTarget(self, action: #selector(self.toggleSection(sender:)), for: .touchUpInside)

            return sectionHeaderCell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DirectoryCell", for: indexPath) as! DirectoryCell
            if indexPath.section == 0 {
//                let list = self.tableViewData[indexPath.section]
//                cell.titleLbl.text = list[indexPath.row - 1]
                cell.titleLbl.text = residentArray[indexPath.row].firstName
                cell.emailLbl.text = residentArray[indexPath.row].email
                cell.contactlbl.text = residentArray[indexPath.row].mobile
            } else if indexPath.section == 1 {
                cell.titleLbl.text = soceityArray[indexPath.row].firstName
                cell.emailLbl.text = soceityArray[indexPath.row].email
                cell.contactlbl.text = soceityArray[indexPath.row].mobile
            } else if indexPath.section == 2 {
                cell.titleLbl.text = blockArray[indexPath.row].firstName
                cell.emailLbl.text = blockArray[indexPath.row].email
                cell.contactlbl.text = blockArray[indexPath.row].mobile
            }

            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 80 // Height for section header cell
        } else {
            return 230  // Height for data cell
        }
    }
    


    @objc private func toggleSection(sender: UIButton) {
        let section = sender.tag

        if self.hiddenSections.contains(section) {
            self.hiddenSections.remove(section)
        } else {
            self.hiddenSections.insert(section)
        }

        tableView.reloadSections(IndexSet(integer: section), with: .fade)
    }
}
