//
//  VistorController.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 16/05/23.
//

import UIKit

class VistorController: UIViewController,VistorNamePass,VistorCountPass,DatePickerCellDelegate {

    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    var visitorsTag:String?
    var visitorModal:VisitorModel?
    var visitorLogModel:VisitorGetLogModel?
    var visitorName:String?
    var visitorCount:String?
    var username:String?
    var userCount:String?
    var empname:String?
    var empCount:String?
    var Visitordate:String?
    var visitorLogList = [Datum2]()
    var VistorToken:String?
    var VistorLogname:String?
    var vistorLogDate:String?
    var UnPlannedVistorModel:UnplannedModel?
    var UnplannedList = [Datum3]()
    override func viewDidLoad() {
        super.viewDidLoad()
        visitorsTag = "Visitors"
        segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        self.mTableView.delegate = self
        self.mTableView.dataSource = self
        mTableView.register(UINib(nibName: "VistorCell1", bundle: nil), forCellReuseIdentifier: "VistorCell1")
        mTableView.register(UINib(nibName: "VistorCell2", bundle: nil), forCellReuseIdentifier: "VistorCell2")
        mTableView.register(UINib(nibName: "ChildInfoDateCell", bundle: nil), forCellReuseIdentifier: "ChildInfoDateCell")
        mTableView.register(UINib(nibName: "ChilfInfoLogCell", bundle: nil), forCellReuseIdentifier: "ChilfInfoLogCell")
       mTableView.register(UINib(nibName: "UnplannedVistorCell1", bundle: nil), forCellReuseIdentifier: "UnplannedVistorCell1")
        UnplannedVisitorsLogsApi()
        plannedVisitorsLogsApi()
    }

    func textFieldDidEndEditing(cell: UITableViewCell, name: String) {
     visitorName = name
        print("visitorName\(visitorName)")
    }
    
    func textFieldDidEndEditing(cell: UITableViewCell, value: String) {
       visitorCount = value
        print("visitorCount\(value)")
    }
    
    func datePickerCellValueChanged(date: String) {
        
        Visitordate = date
        print("Visitordate--\(Visitordate)")
    }
    
    @IBAction func radioBtn(sender: UIButton){
        let indexPath = IndexPath(row: sender.tag, section: 0)
        if let cell = mTableView.cellForRow(at: indexPath) as? VistorCell1 {
            if sender == cell.VisitorsBtn{
                visitorsTag = "Visitors"
                cell.VisitorsBtn.isSelected = true
                cell.HouseHoldBtn.isSelected = false
                self.mTableView.reloadData()
            }else{
                visitorsTag = "HouseHold"
                cell.VisitorsBtn.isSelected = false
                cell.HouseHoldBtn.isSelected = true
                self.mTableView.reloadData()
            }
        }
    }
   
    @IBAction func generateRequest(_sender:UIButton){
       validation()
      
    }
 
    @IBAction func ReloadBtn(_sender:UIButton){
        visitorLogList = []
        plannedVisitorsLogsApi()
        self.mTableView.reloadData()
       
    }
    @IBAction func SegmentAction(_ sender: UISegmentedControl) {
        UnplannedList = []
        UnplannedVisitorsLogsApi()
        self.mTableView.reloadData()
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 4)
        if let cell = mTableView.cellForRow(at: indexPath) as? ChilfInfoLogCell {
            cell.messageView.isHidden = !cell.messageView.isHidden
            self.VistorToken = "\(visitorLogList[indexPath.row].visitToken)"
            self.VistorLogname = visitorLogList[indexPath.row].visitorName
            self.vistorLogDate = visitorLogList[indexPath.row].visitDate
            
            cell.WhatappBtn.tag = indexPath.row
            cell.EyeBtn.tag = indexPath.row
            cell.messageBtn.tag = indexPath.row
      
            cell.WhatappBtn.addTarget(self, action: #selector(Whatapp(sender:)), for: .touchUpInside)
            cell.EyeBtn.addTarget(self, action: #selector(EyeBtn(sender:)), for: .touchUpInside)
            cell.messageBtn.addTarget(self, action:  #selector (message),for: .touchUpInside)
        }
    }
    
    @IBAction func Whatapp(sender: Int){
       
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChildWhatappPopups") as! ChildWhatappPopups
               vc.modalPresentationStyle = .overCurrentContext
               vc.providesPresentationContextTransitionStyle = false
               vc.definesPresentationContext = false
               vc.modalTransitionStyle = .crossDissolve
               vc.date = vistorLogDate
               vc.tokenno = VistorToken
              self.present(vc, animated: true,completion: nil)
    }
    
    
    @objc func message(){
        let textToShare = "Hello,\(VistorLogname ?? "") is at the gate for which the child token is \(VistorToken ?? "")"
         shareText(textToShare)

    }

    func shareText(_ text: String) {
        let activityViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        self.present(activityViewController, animated: true,completion: nil)
        
    }
    
    @IBAction func EyeBtn(sender: Int){
       
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EventsPopup") as! EventsPopup
               vc.modalPresentationStyle = .overCurrentContext
               vc.providesPresentationContextTransitionStyle = false
               vc.definesPresentationContext = false
               vc.modalTransitionStyle = .crossDissolve
               vc.descData = "Visit Code is :\(VistorToken ?? "")"
        self.present(vc, animated: true,completion: nil)
    }
    
    
    
    @objc func UnplannedReload(_ sender: UIButton) {
        UnplannedList = []
        UnplannedVisitorsLogsApi()
        self.mTableView.reloadData()
    }
    
    
    func VisitorsApi(){
        showSpinner_N(onView: view)
        let tag:String = "genratevisitrequest"
        let userEmail:String = UserDefaults.standard.string(forKey: "userEmail") ?? ""
        let userPass:String =  UserDefaults.standard.string(forKey: "userPass") ?? ""
        let loggedRole:String = UserDefaults.standard.string(forKey: "loggedRole") ?? ""
        let userId = UserDefaults.standard.string(forKey: "UserID") ?? ""
        let flatId = UserDefaults.standard.string(forKey: "flatId") ?? ""
        let blockID = UserDefaults.standard.string(forKey: "BlockId") ?? ""
        if visitorsTag == "Visitors"{
            username = visitorName ?? ""
            userCount = visitorCount ?? ""
        }else if visitorsTag == "HouseHold"{
            empname = visitorName ?? ""
            empCount = visitorCount ?? ""
        }
        let parameters: [String: Any] = [
            "tag" : tag,
            "userEmail" : userEmail,
            "userPass"  : userPass,
            "society_id" : societyId,
            "loggedRole"  : loggedRole,
            "user_id":userId,
            "FlatId":flatId,
            "block_id":blockID,
            "visitor_name": username ?? "",
            "visitor_count":userCount ?? "",
            "emp_name":empname ?? "",
            "emp_count":empCount ?? "",
            "emp_visit_date": Visitordate ?? ""
            
        ]
        print("VisitorsApiParam--->\(parameters)")
        var url : String = baseSeverUrl
        WebParamsApiManager.perFormRequest(url: url, params: parameters) { [self](res, error, errorcode) in
        
                print("VisitorsApiRes--->\(res ?? "")")
                if error == nil{
                    if let obj:NSDictionary =  res as? NSDictionary{
                        print(obj)
                        if let status:Int = obj["success"] as? Int{
                            print(status)
                            if status == 1{
                                self.removeSpinner_N()
                                if res != nil{
                                    self.visitorModal = try! JSONDecoder().decode(VisitorModel.self, from: WebAPIManager.jsonToString(json: res as Any).data(using: .utf8)!)
                                   

                                    if let msg :String = obj["message"] as? String{
                                        self.displayMessage(msg)
                                        
                                    }
                                    visitorLogList = []
                                    plannedVisitorsLogsApi()
                                    self.mTableView.reloadData()
                                   
                                    print("Success-----")
                                }else{
                                    print("Data not found")
                                }
  
//
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
    
    
    
    
    
    
    
    func plannedVisitorsLogsApi(){
        //showSpinner_N(onView: view)
        let tag:String = "getPlannedVIsitLogs"
        let userEmail:String = UserDefaults.standard.string(forKey: "userEmail") ?? ""
        let userPass:String =  UserDefaults.standard.string(forKey: "userPass") ?? ""
        let loggedRole:String = UserDefaults.standard.string(forKey: "loggedRole") ?? ""
        let userId = UserDefaults.standard.string(forKey: "UserID") ?? ""
        let flatId = UserDefaults.standard.string(forKey: "flatId") ?? ""
        let blockID = UserDefaults.standard.string(forKey: "BlockId") ?? ""
        let parameters: [String: Any] = [
            "tag" : tag,
            "userEmail" : userEmail,
            "userPass"  : userPass,
            "society_id" : societyId,
            "loggedRole"  : loggedRole,
            "user_id":userId,
            "FlatId":flatId,
            "block_id":blockID
        ]
        print("plannedVisitorsApiParam--->\(parameters)")
        var url : String = baseSeverUrl
        WebParamsApiManager.perFormRequest(url: url, params: parameters) {(res, error, errorcode) in
        
                print("plannedVisitorsApiRes--->\(res ?? "")")
                if error == nil{
                    if let obj:NSDictionary =  res as? NSDictionary{
                        print(obj)
                        if let status:Int = obj["success"] as? Int{
                            print(status)
                            if status == 1{
                                self.removeSpinner_N()
                                if res != nil{
                                    self.visitorLogModel = try! JSONDecoder().decode(VisitorGetLogModel.self, from: WebAPIManager.jsonToString(json: res as Any).data(using: .utf8)!)
                                    if self.visitorLogModel?.data.count != 0 {
                                           self.visitorLogList.append(contentsOf: (self.visitorLogModel?.data) ?? [])
                                           print("visitorLogList--->\(self.visitorLogList)")
                                           print(msg.self)
                                        print("visitorLogList.count\(self.visitorLogList.count)")


                                           self.mTableView.reloadData()
                                       } else{
                                           self.removeSpinner_N()
                                           // self.displayMessage("Data Not found!")
                                       }
//
                                    print("Success-----")
                                }else{
                                    print("Data not found")
                                }
  
//
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
    
    
    func UnplannedVisitorsLogsApi(){
        showSpinner_N(onView: view)
        let tag:String = "getUnPlannedVIsitLogs"
        let userEmail:String = UserDefaults.standard.string(forKey: "userEmail") ?? ""
        let userPass:String =  UserDefaults.standard.string(forKey: "userPass") ?? ""
        let loggedRole:String = UserDefaults.standard.string(forKey: "loggedRole") ?? ""
        let userId = UserDefaults.standard.string(forKey: "UserID") ?? ""
        let flatId = UserDefaults.standard.string(forKey: "flatId") ?? ""
        let blockID = UserDefaults.standard.string(forKey: "BlockId") ?? ""
        let parameters: [String: Any] = [
            "tag" : tag,
            "userEmail" : userEmail,
            "userPass"  : userPass,
            "society_id" : societyId,
            "loggedRole"  : loggedRole,
            "user_id":userId,
            "FlatId":flatId,
            "block_id":blockID
        ]
        print("UnplannedVisitorsApiParam--->\(parameters)")
        var url : String = baseSeverUrl
        WebParamsApiManager.perFormRequest(url: url, params: parameters) {(res, error, errorcode) in
        
            print(" UnplannedVisitorsApiRes--->\(res ?? "")")
                if error == nil{
                    if let obj:NSDictionary =  res as? NSDictionary{
                        print(obj)
                        if let status:Int = obj["success"] as? Int{
                            print(status)
                            if status == 1{
                                self.removeSpinner_N()
                                if res != nil{
                                    self.UnPlannedVistorModel = try! JSONDecoder().decode(UnplannedModel.self, from: WebAPIManager.jsonToString(json: res as Any).data(using: .utf8)!)
                                    if self.UnPlannedVistorModel?.data.count != 0 {
                                           self.UnplannedList.append(contentsOf: (self.UnPlannedVistorModel?.data) ?? [])
                                           print("UnplannedList--->\(self.UnplannedList)")
                                           print(msg.self)
                                        print("UnplannedList.count\(self.UnplannedList.count)")

//

                                           self.mTableView.reloadData()
                                       } else{
                                           self.removeSpinner_N()
                                           self.displayMessage("Data Not found!")
                                       }
//
                                    print("Success-----")
                                }else{
                                    print("Data not found")
                                }
  
//
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
    
    func validation(){
        
        if visitorName == nil {
            if visitorsTag == "Visitors"{
                displayMessage("Enter Visitors name")
            }else if visitorsTag == "HouseHold"{
                displayMessage("Enter Employee name")
            }
        }else if visitorCount == nil {
            if visitorsTag == "Visitors"{
                displayMessage("Enter No. of Person")
            }else if visitorsTag == "HouseHold"{
                displayMessage("Enter No. of Employee")
            }
        }else if Visitordate == nil {
            displayMessage("Enter Date")
        }else{
            VisitorsApi()
            self.mTableView.reloadData()
        }
    }
}
extension VistorController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        switch segment.selectedSegmentIndex {
        case 0:
            return 5
        case 1:
            return 2
        default:
           break
        }
       return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch segment.selectedSegmentIndex {
        case 0:
            if section == 0{
                return 1
            }else if section == 1{
                return 1
            }else if section == 2{
                return 1
            }else if section == 3{
                return 1
            }else if section == 4{
                return visitorLogList.count
            }
            break
          
        case 1:
            if section == 0{
                return 1
            }else if section == 1{
                return UnplannedList.count
            }
            break
        default:
            break
        }

        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch segment.selectedSegmentIndex{
        case 0:
            
            if indexPath.section == 0{
                let cell = mTableView.dequeueReusableCell(withIdentifier: "VistorCell1", for: indexPath) as! VistorCell1
                           cell.delegate = self
                            if visitorsTag == "Visitors" {
                              cell.VisitorLbl.isHidden = true
                            //  cell.visitorHeight.constant = 0
                                cell.VistorTextFeild.placeholder = "Enter Visitor Name"
                                cell.VisitorPlaceholderLbl.text = "Vistor Name"
                                
                            } else if visitorsTag == "HouseHold"{
                              cell.VisitorLbl.isHidden = false
                              cell.VisitorLbl.text = "Household employee info:"
                      
                                cell.VistorTextFeild.placeholder = "Enter Employee Name"
                                cell.VisitorPlaceholderLbl.text = "Employee Name"
                          }
                cell.VisitorsBtn.addTarget(self, action: #selector(radioBtn(sender:)), for: .touchUpInside)
                cell.HouseHoldBtn.addTarget(self, action: #selector(radioBtn(sender:)), for: .touchUpInside)
                cell.VisitorsBtn.tag = indexPath.row
                cell.HouseHoldBtn.tag = indexPath.row
                
               
                return cell
            }else if  indexPath.section == 1{
                let cell = mTableView.dequeueReusableCell(withIdentifier: "VistorCell2", for: indexPath) as! VistorCell2
                cell.delegate = self
                if visitorsTag == "Visitors"{
                    if indexPath.row == 0{
                        cell.TextFeildLbl.placeholder = "No. of Person"
                        cell.placeHolderlabel.text = "No. of Person"
                    }

                }else{
                    if indexPath.row == 0{
                        cell.TextFeildLbl.placeholder = "Enter No. of Employee"
                        cell.placeHolderlabel.text = "No. of Employee"
                    }

                }
               
                return cell
            }else if  indexPath.section == 2{
                let cell = mTableView.dequeueReusableCell(withIdentifier: "ChildInfoDateCell", for: indexPath) as! ChildInfoDateCell
                cell.delegate = self
                cell.GenerateBtn.isHidden = false
                cell.GenerateBtn.addTarget(self, action: #selector(generateRequest(_sender:)), for: .touchUpInside)
                
                return cell
                //UnplannedVistorCell1
            }else if  indexPath.section == 3{
                let cell = mTableView.dequeueReusableCell(withIdentifier: "UnplannedVistorCell1", for: indexPath) as! UnplannedVistorCell1
                cell.UnplannedLbl.isHidden = true
                cell.RefreshBtn.addTarget(self, action: #selector(ReloadBtn(_sender:)), for: .touchUpInside)
                return cell
            }
           
            else if  indexPath.section == 4{
                let cell = mTableView.dequeueReusableCell(withIdentifier: "ChilfInfoLogCell", for: indexPath) as! ChilfInfoLogCell
                cell.VisitTokenLbel.isHidden = false
                cell.Name.text = visitorLogList[indexPath.row].visitorName
                cell.ChildCount.text = "Visitor Count:\(visitorLogList[indexPath.row].visitorCount)"
                cell.Time.text = visitorLogList[indexPath.row].visitDate
                cell.VisitTokenLbel.text = "Visitor Token:\(visitorLogList[indexPath.row].visitToken )"
                
                let originalText = visitorLogList[indexPath.row].visitToken
                let labelPrefix = NSAttributedString(string: "Vistor token:")
                let secureAttributedString = convertToSecureText(originalText: "\(originalText)")
                
                let combinedAttributedString = NSMutableAttributedString()
                combinedAttributedString.append(labelPrefix)
                combinedAttributedString.append(secureAttributedString)
                
                cell.VisitTokenLbel.attributedText = combinedAttributedString
                
                
                
                
                
                cell.shareButton.tag = indexPath.row
                cell.shareButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                if  visitorLogList[indexPath.row].status == 1{
                    cell.Status.text = "Pending"
                    cell.Status.textColor = getepayYellowColor
                   }else if visitorLogList[indexPath.row].status == 2{
                    cell.Status.text = "Approved"
                    cell.Status.textColor = hexStringToUIColor(hex: "#249B60")
                }else if visitorLogList[indexPath.row].status == 3{
                    cell.Status.text = "Rejected"
                    cell.Status.textColor = .red
                }
                return cell
            }
            break
        case 1:
            if indexPath.section == 0{
                let cell = mTableView.dequeueReusableCell(withIdentifier: "UnplannedVistorCell1", for: indexPath) as! UnplannedVistorCell1
                cell.RefreshBtn.addTarget(self, action: #selector(UnplannedReload(_:)), for: .touchUpInside)
                cell.UnplannedLbl.isHidden = false
                return cell
            }else if indexPath.section == 1{
                let cell = mTableView.dequeueReusableCell(withIdentifier: "ChilfInfoLogCell", for: indexPath) as! ChilfInfoLogCell
//                cell.VisitTokenLbel.isHidden = false
                cell.Name.text = UnplannedList[indexPath.row].visitorName
                cell.ChildCount.text = "\(UnplannedList[indexPath.row].visitorCount)"
                cell.Time.text = UnplannedList[indexPath.row].visitDate
                cell.VisitTokenLbel.text = "\(UnplannedList[indexPath.row].visitToken )"
                cell.shareButton.isHidden = true
                
                if  UnplannedList[indexPath.row].status == 1{
                    cell.Status.text = "Pending"
                    cell.Status.textColor = getepayYellowColor
                   }else if UnplannedList[indexPath.row].status == 2{
                    cell.Status.text = "Approved"
                    cell.Status.textColor = hexStringToUIColor(hex: "#249B60")
                }else if UnplannedList[indexPath.row].status == 3{
                    cell.Status.text = "Rejected"
                    cell.Status.textColor = .red
                }
                return cell
            }
           
        default:
            break
        }
      
      return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch segment.selectedSegmentIndex{
        case 0:
            if indexPath.section == 0{
                return 190
            }else if indexPath.section == 1{
                return 100
            }else if indexPath.section == 2{
                return 180
            }else if indexPath.section == 3{
                return 80
            }else if indexPath.section == 4{
                return 250
            }
            break
        case 1:
            if indexPath.section == 0{
                return 100
            }else if indexPath.section == 1{
                return 250
            }
           break
        default:
          break
        }
      
        return 0
    }
}
