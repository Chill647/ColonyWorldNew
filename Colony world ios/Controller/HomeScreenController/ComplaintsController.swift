//
//  ComplaintsController.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 23/05/23.
//

import UIKit

class ComplaintsController: UIViewController,ComplaintDelegate,StatusDelegate,ComplaintRegister{
    
    var compalintListModel:ComplaintLogsModel?
    var complaintList = [ComplaintList]()
    @IBOutlet weak var mtableView: UITableView!
    @IBOutlet weak var topCornerView: UIView!
    @IBOutlet var mainView: UIView!
    var complaint:String?
    var register:String?
    var dateString:String?
    var Category:String?
    var desc: String?
    var indexpathtag:Int?
    var complaintStatus:String?
    var complaintId:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        updateScreen()
       
       
        self.mtableView.delegate = self
        self.mtableView.dataSource = self
        mtableView.register(UINib(nibName: "ComplaintTextFeildCell", bundle: nil), forCellReuseIdentifier: "ComplaintTextFeildCell")
        mtableView.register(UINib(nibName: "ComplaintButtonCell", bundle: nil), forCellReuseIdentifier: "ComplaintButtonCell")
        mtableView.register(UINib(nibName: "ComplaintListCell", bundle: nil), forCellReuseIdentifier: "ComplaintListCell")
        ComplaintLogsApi()
    }
    
    func updateScreen(){
        mainView.backgroundColor = getepayYellowColor
        topCornerView.CornerRadious = 20
        topCornerView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
    }
    
    
    func didEnterData(complaintText: String, RegisterText: String, DateTextFeild: String, CategoryTxtFeild: String, DescriptionTextFeild: String) {
          complaint = complaintText
       
          dateString = DateTextFeild
         Category = CategoryTxtFeild
         desc = DescriptionTextFeild
        
        print("ComplaintDAta--complaint\(complaint)dateString\(dateString)Category\(Category)desc\(desc)")
    }
    func didEnterData(StatusText: String) {
        var status = StatusText
        print("statusCheck--\(status)")
        
        
        let indexPath = IndexPath(row: indexpathtag ?? 0, section: 2)
        print("RemarkindexPath\(indexPath)")
        if let cell = mtableView.cellForRow(at: indexPath) as? ComplaintListCell {
            if  status == "Open"{
                
                cell.status.isHidden = false
                cell.statusLbl.isHidden = false
                self.complaintStatus = "1"
  
                complaintStatusApi(complaintList[indexPath.row].compID ?? 0,self.complaintStatus ?? "")
            }else if status == "Closed"{
                cell.status.isHidden = true
                cell.statusLbl.isHidden = true
                self.complaintStatus = "2"

                complaintStatusApi(complaintList[indexPath.row].compID ?? 0,self.complaintStatus ?? "")
            }
            
        }
    }
    
    func Registerdata(RegisterText: String) {
        self.register = RegisterText
        print("registerVC--\(register)")
    }
    
    @IBAction func submitBtn(_sender:UIButton){
        validateAddCoupon()
    }
    func validateAddCoupon() {
        
        if complaint == nil {
            displayMessage("Enter complaint")
        }else if Category == nil {
            displayMessage("Enter Category")
        }else if desc == nil {
            displayMessage("Enter Description")
        }else if dateString == nil {
            displayMessage("Enter Date")
        }else if register == nil {
            displayMessage("Enter register")
        }else{
            AddComplaintApi()
        }
    }
    
    func AddComplaintApi(){
        showSpinner_N(onView: view)
        let tag:String = "addComplaint"
        var UserEmail = UserDefaults.standard.string(forKey: "userEmail") ?? ""
        var userPass = UserDefaults.standard.string(forKey: "userPass") ?? ""
        var loggedRole =  UserDefaults.standard.string(forKey: "loggedRole") ?? ""
       
        let parameters: [String: Any] = [
            "tag" : tag,
            "userEmail" : UserEmail,
            "userPass"  : userPass,
            "society_id" :societyId,
            "loggedRole": loggedRole,
            "complaint_type":complaint ?? "",
            "category":Category ?? "",
            "description":desc ?? "",
            "register_to":register ?? "",
            "date":dateString ?? ""
        ]
        print("AddComplaintApiRequestbody-->\(parameters)")
    
        var url : String = baseSeverUrl
        WebParamsApiManager.perFormRequest(url: url, params: parameters) { [self](res, error, errorcode) in
          
            print("AddComplaintApiResponse--->\(res)")
           
            if error == nil{
               
                if let obj:NSDictionary =  res as? NSDictionary{
                    print(obj)
                    if let status:Int = obj["success"] as? Int{
                        print(status)
                        if status == 1{
                            self.removeSpinner_N()
                            if res != nil{
                                do {
                                    if let jsonData = WebAPIManager.jsonToString(json: res as Any).data(using: .utf8) {
                                        let decoder = JSONDecoder()
                                        if let msg :String = obj["message"] as? String{
                                            self.removeSpinner_N()
                                            self.displayMessage(msg)
                                        }
                                        complaintList = []
                                        ComplaintLogsApi()
                                        self.mtableView.reloadData()
                                       
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
    
    
    func ComplaintLogsApi(){
      
        let tag:String = "viewComplaints"
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
        print("ComplaintLogsApiRequestbody-->\(parameters)")
    
        var url : String = baseSeverUrl
        WebParamsApiManager.perFormRequest(url: url, params: parameters) { [self](res, error, errorcode) in
          
            print("ComplaintLogsApiResponse--->\(res)")
           
            if error == nil{
               
                if let obj:NSDictionary =  res as? NSDictionary{
                    print(obj)
                    if let status:Int = obj["success"] as? Int{
                        print(status)
                        if status == 1{
                            self.removeSpinner_N()
                            if res != nil{
                                self.compalintListModel = try! JSONDecoder().decode(ComplaintLogsModel.self, from: WebAPIManager.jsonToString(json: res as Any).data(using: .utf8)!)
                                if self.compalintListModel?.data?.count != 0 {
                                    self.complaintList.append(contentsOf: (self.compalintListModel?.data) ?? [])
                                    print("complaintList--->\(self.complaintList)")
                                    print(msg.self)
                                    
                                    
                                    self.mtableView.reloadData()
                                } else{
                                    self.removeSpinner_N()
                                    // self.displayMessage("Data Not found!")
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
    
    
    
    func complaintStatusApi(_ ComplaintID:Int,_ ComplaintStatus:String){
        showSpinner_N(onView: view)
        let tag:String = "changeComplaintStatus"
        var UserEmail = UserDefaults.standard.string(forKey: "userEmail") ?? ""
        var userPass = UserDefaults.standard.string(forKey: "userPass") ?? ""
        var loggedRole =  UserDefaults.standard.string(forKey: "loggedRole") ?? ""
       
        let parameters: [String: Any] = [
            "tag" : tag,
            "userEmail" : UserEmail,
            "userPass"  : userPass,
            "society_id" :societyId,
            "complaint_id" : ComplaintID,
            "status" : ComplaintStatus
        ]
        print("complaintStatusApiRequestbody-->\(parameters)")
    
        var url : String = baseSeverUrl
        WebParamsApiManager.perFormRequest(url: url, params: parameters) { [self](res, error, errorcode) in
          
            print("complaintStatusApiResponse--->\(res)")
           
            if error == nil{
               
                if let obj:NSDictionary =  res as? NSDictionary{
                    print(obj)
                    if let status:Int = obj["success"] as? Int{
                        print(status)
                        if status == 1{
                            self.removeSpinner_N()
                            if res != nil{
                                do {
                                    if let jsonData = WebAPIManager.jsonToString(json: res as Any).data(using: .utf8) {
                                        let decoder = JSONDecoder()
                                        if let msg :String = obj["message"] as? String{
                                            self.removeSpinner_N()
                                            self.displayMessage(msg)
                                        }
                                        complaintList = []
                                        ComplaintLogsApi()
                                        self.mtableView.reloadData()
                                       
                                    } else {
                                        complaintList = []
                                        ComplaintLogsApi()
                                        self.mtableView.reloadData()
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
extension ComplaintsController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
       return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2{
            print("complaintList.count--\(complaintList.count)")
            return complaintList.count
        }else{
            return 1
        }
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = mtableView.dequeueReusableCell(withIdentifier: "ComplaintTextFeildCell", for: indexPath) as! ComplaintTextFeildCell
                   cell.delegate = self
                   cell.delegate1 = self
                  cell.CategoryTxtFeild.tag = indexPath.row
                  cell.RegisterTextfeild.tag = indexPath.row
                 cell.DateTextFeild.tag = indexPath.row 
                cell.complaintTextFeild.tag = indexPath.row
               cell.DescriptionTextFeild.tag = indexPath.row
            return cell
        }else if indexPath.section == 1{
            let cell = mtableView.dequeueReusableCell(withIdentifier: "ComplaintButtonCell", for: indexPath) as! ComplaintButtonCell
            
//            if self.compalintListModel?.data?.count != 0 {
//                cell.MyComplaintsLbl.isHidden = false
//                cell.Linelbl.isHidden = false
//            }
            cell.SubmitBtn.addTarget(self, action: #selector(submitBtn(_sender:)), for: .touchUpInside)
            return cell
        }else if indexPath.section == 2{
            let cell = mtableView.dequeueReusableCell(withIdentifier: "ComplaintListCell", for: indexPath) as! ComplaintListCell
            cell.delegate = self
            cell.complaintNoLbl.text = "\(complaintList[indexPath.row].compID ?? 0)"
            cell.CategoryLbl.text = complaintList[indexPath.row].category ?? "-"
            cell.ReportedOnlbl.text = complaintList[indexPath.row].registerToRole ?? "-"
            cell.ClosedOnLbl.text = complaintList[indexPath.row].closedOn ?? "-"
            cell.status.tag = indexPath.row
            self.indexpathtag =  cell.status.tag
            
            if complaintList[indexPath.row].complaintStatus == 1{
                cell.status.isHidden = false
                cell.statusLbl.isHidden = false
            }else if complaintList[indexPath.row].complaintStatus == 2{
                cell.status.isHidden = true
                cell.statusLbl.isHidden = true
            }
            return cell
        }
 return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 360
        }else if indexPath.section == 1{
            return 140
        }else{
            return 230
        }
    }
}
