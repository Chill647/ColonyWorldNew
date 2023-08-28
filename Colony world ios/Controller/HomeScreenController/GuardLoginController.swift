//
//  GuardLoginController.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 01/06/23.
//

import UIKit
import iOSDropDown
import MessageUI
class GuardLoginController: UIViewController,VistorNamePass,VistorCountPass,DatePickerCellDelegate,Dropdown1,Dropdown2,ApprovedDropDown {
    
    
    
    var contact:String?
    var visitorsTag:String?
    @IBOutlet weak var mtableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var logoutBtn: UIButton!
    var guardModel:GuardPlannedLogsModel?
    var guardChildModel:GuardChildLogmodel?
    var childverify:ChildVerifyModel?
    
    var generateModel:GuardGenerateModal?
    var guardChildlist = [childsLogs]()
    var guardlistPlanned = [GuardLogs]()
    var guardlistUnPlanned = [GuardLogs]()
    var flatIdNo:String?
    var blockIDNo:String?
    var visitorName:String?
    var visitorCount:String?
    var datestring:String?
    var blockNo:String?
    var flatNo:String?
    var approvedString:String?
    var username:String?
    var userCount:String?
    var empname:String?
    var empCount:String?
    var generateMobileNo:String?
    var indexpathtag:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        //        flatIdNo = UserDefaults.standard.string(forKey: "flatId") ?? ""
        //        blockIDNo = UserDefaults.standard.string(forKey: "BlockId") ?? ""
        flatIdNo = ""
        blockIDNo = ""
        //        flatIdNo = "8245"
        //        blockIDNo = "673"
        visitorsTag = "Visitors"
        updateScreen()
        uiTableviewCell()
        getAllVisitLogsApi(flatId:"", blockid:"")
        
        
    }
    
    func uiTableviewCell(){
        self.mtableView.delegate = self
        self.mtableView.dataSource = self
        mtableView.register(UINib(nibName: "UnplannedVistorCell1", bundle: nil), forCellReuseIdentifier: "UnplannedVistorCell1")
        mtableView.register(UINib(nibName: "ChilfInfoLogCell", bundle: nil), forCellReuseIdentifier: "ChilfInfoLogCell")
        mtableView.register(UINib(nibName: "VistorCell1", bundle: nil), forCellReuseIdentifier: "VistorCell1")
        mtableView.register(UINib(nibName: "VistorCell2", bundle: nil), forCellReuseIdentifier: "VistorCell2")
        mtableView.register(UINib(nibName: "DropDownCell", bundle: nil), forCellReuseIdentifier: "DropDownCell")
        
        mtableView.register(UINib(nibName: "DropDownCell2", bundle: nil), forCellReuseIdentifier: "DropDownCell2")
        mtableView.register(UINib(nibName: "ChildInfoDateCell", bundle: nil), forCellReuseIdentifier: "ChildInfoDateCell")
        
//        mtableView.register(UINib(nibName: "LogsReloadCell", bundle: nil), forCellReuseIdentifier: "LogsReloadCell")
        
    }
    func updateScreen(){
        segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: getepayYellowColor], for: .normal)
    }
    
    @IBAction func LogoutClick(_ sender: Any) {
        let moveVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        moveVC.storeData = "not-nill"
        self.navigationController?.pushViewController(moveVC, animated: true)
        
    }
    func datePickerCellValueChanged(date: String) {
        self.datestring = date
        print("datestring-\(datestring)")
    }
    
    
    func textFieldDidEndEditing(cell: UITableViewCell, name: String) {
        self.visitorName = name
        print("visitorName-\(visitorName)")
    }
    
    func textFieldDidEndEditing(cell: UITableViewCell, value: String) {
        self.visitorCount = value
        print("visitorCount-\(visitorCount)")
        
        
    }
    
    
    func dropDwonblock(Block: String) {
        self.blockNo = Block
        print("blockNo-\(blockNo)")
    }
    
    func dropDownFlat(Flat: String) {
        self.flatNo = Flat
        print("flatNo-\(flatNo)")
    }
    
    func ApprovedData(approvedStatus: String) {
        self.approvedString = approvedStatus
        //RemarksApi()
        print("approvedString-\(approvedString ?? "")")
        let indexPath = IndexPath(row: indexpathtag ?? 0, section: 6)
        print("RemarkindexPath\(indexPath)")
        if let cell = mtableView.cellForRow(at: indexPath) as? ChilfInfoLogCell {
            if  self.approvedString == "Approved on call"{
                
                cell.VisitTokenLbel.isHidden = false
                cell.VisitTokenLbel.text = "Visitor Remark: \(approvedString ?? "")"
                RemarksApi(token:"\(guardlistUnPlanned[indexPath.row].visitToken ?? 0)", remark: approvedString ?? "")
            }else if self.approvedString == "Approved with SMS code"{
                cell.VisitTokenLbel.isHidden = false
                cell.VisitTokenLbel.text = "Visitor Remark: \(approvedString ?? "")"
                RemarksApi(token:"\(guardlistUnPlanned[indexPath.row].visitToken ?? 0)", remark: approvedString ?? "")
            }
            
        }
    }
    
    @IBAction func RemarkAction(sender: UIButton){
        print("sender.tag--\(sender.tag)")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func SegmentClick(_ sender: UISegmentedControl) {
        
        switch segment.selectedSegmentIndex {
        case 0:
            
            guardlistPlanned = []
            getAllVisitLogsApi(flatId: "", blockid: "")
            self.mtableView.reloadData()
            // break
        case 1:
            
            guardlistUnPlanned = []
            getAllVisitLogsApi(flatId: flatIdNo ?? "", blockid: blockIDNo ?? "")
            self.mtableView.reloadData()
            //  break
        case 2:
            
            guardChildlist = []
            guardchildLogsApi()
            self.mtableView.reloadData()
            // break
        default:
            
            break
        }
        
        
    }
 
    @IBAction func radioBtn(sender: UIButton){
        let indexPath = IndexPath(row: sender.tag, section: 0)
        if let cell = mtableView.cellForRow(at: indexPath) as? VistorCell1 {
            if sender == cell.VisitorsBtn{
                visitorsTag = "Visitors"
                cell.VisitorsBtn.isSelected = true
                cell.HouseHoldBtn.isSelected = false
                self.mtableView.reloadData()
            }else{
                visitorsTag = "HouseHold"
                cell.VisitorsBtn.isSelected = false
                cell.HouseHoldBtn.isSelected = true
                self.mtableView.reloadData()
            }
        }
    }
    
    @IBAction func ReloadPlanned(sender: UIButton){
        guardlistPlanned = []
        getAllVisitLogsApi(flatId: "", blockid: "")
        self.mtableView.reloadData()
    }
    
    @IBAction func ReloadUnPlanned(sender: UIButton){
        guardlistUnPlanned = []
        getAllVisitLogsApi(flatId: flatIdNo ?? "", blockid: blockIDNo ?? "")
        self.mtableView.reloadData()
    }
    
    @IBAction func ReloadChild(sender: UIButton){
        guardChildlist = []
        guardchildLogsApi()
        self.mtableView.reloadData()
    }
    @IBAction func remarkunPlannedBtn(sender: UIButton){
        let indexPath = IndexPath(row: sender.tag, section: 6)
        if let cell = mtableView.cellForRow(at: indexPath) as? ChilfInfoLogCell {
            cell.VisitTokenLbel.text = approvedString
            
        }
    }
    @IBAction func verifyChildBtn(sender: UIButton){
        let indexPath = IndexPath(row: sender.tag, section: 1)
        if let cell = mtableView.cellForRow(at: indexPath) as? ChilfInfoLogCell {
            
            cell.verifyBtn.isHidden = true
            cell.Status.text = "Approved"
            verifyChildApi(guardChildlist[indexPath.row].visitToken ?? "")
        }
        
    }
    
    @IBAction func verifyPlannedBtn(sender: UIButton){
        let indexPath = IndexPath(row: sender.tag, section: 1)
        print("VerifyPlannedIndex--\(indexPath)")
        if let cell = mtableView.cellForRow(at: indexPath) as? ChilfInfoLogCell {
            
            cell.verifyBtn.isHidden = true
            cell.Status.text = "Approved"
            
            verifyPlannedApi(guardlistPlanned[indexPath.row].visitToken ?? 0)
        }
        
    }
    
    @IBAction func generatebtn(sender: UIButton){
        validation()
        
    }
    @IBAction func callBtn(sender: UIButton){
        if generateMobileNo != nil{
            let number : Int = Int(generateMobileNo ?? "") ?? 0
            if let url = URL(string: "tel://\(number)") {
                UIApplication.shared.openURL(url)
            }
        }else{
            self.displayMessage("Please firstly Generate request")
        }
    }
    func getAllVisitLogsApi(flatId:String,blockid:String){
        //        showSpinner_N(onView: view)
        let tag:String = "getAllVisitLogs"
        let userEmail:String = UserDefaults.standard.string(forKey: "userEmail") ?? ""
        let userPass:String =  UserDefaults.standard.string(forKey: "userPass") ?? ""
        let loggedRole:String = UserDefaults.standard.string(forKey: "loggedRole") ?? ""
        let userId = UserDefaults.standard.string(forKey: "UserID") ?? ""
        
        let parameters: [String: Any] = [
            "tag" : tag,
            "userEmail" : userEmail,
            "userPass"  : userPass,
            "society_id" : societyId,
            "loggedRole"  : loggedRole,
            "user_id":userId,
            "FlatId":flatId ,
            "block_id":blockid
        ]
        print("getAllVisitLogsiParam--->\(parameters)")
        var url : String = baseSeverUrl
        WebParamsApiManager.perFormRequest(url: url, params: parameters) {(res, error, errorcode) in
            
            print("getAllVisitLogsRes--->\(res ?? "")")
            if error == nil{
                self.removeSpinner_N()
                if let obj:NSDictionary =  res as? NSDictionary{
                    print(obj)
                    if let status:Int = obj["success"] as? Int{
                        print(status)
                        if status == 1{
                            self.removeSpinner_N()
                            if res != nil{
                                self.guardModel = try! JSONDecoder().decode(GuardPlannedLogsModel.self, from: WebAPIManager.jsonToString(json: res as Any).data(using: .utf8)!)
                                self.guardlistUnPlanned = []
                                self.guardlistPlanned = []
                               
                                if self.guardModel?.data.count != 0 {
                                    self.flatIdNo = "\(self.guardModel?.data[0].flatID ?? 0)"
                                    self.blockIDNo = "\(self.guardModel?.data[0].blockID ?? 0)"
                                    
                                    for data in self.guardModel?.data ?? [] {
                                        if data.visitType == 1 {
                                            self.guardlistPlanned.append(data)
                                        } else if data.visitType == 2 {
                                            self.guardlistUnPlanned.append(data)
                                        }
                                    }
                                    print("guardlistPlanned--->\(self.guardlistPlanned)")
                                    print("guardlistUnPlanned--->\(self.guardlistUnPlanned)")
                                    
                                    
                                    print("guardLogPlannedList.count\(self.guardlistPlanned.count)")
                                    print("guardlistUnPlanned.count\(self.guardlistUnPlanned.count)")
                                    self.mtableView.reloadData()
                                } else{
                                    self.removeSpinner_N()
                                    // self.displayMessage("Data Not found!")
                                }
                                //
                                print("Success-----")
                            }else{
                                self.removeSpinner_N()
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
    
    func guardchildLogsApi(){
        //        showSpinner_N(onView: view)
        let tag:String = "getChildVisitLogs"
        let userEmail:String = UserDefaults.standard.string(forKey: "userEmail") ?? ""
        let userPass:String =  UserDefaults.standard.string(forKey: "userPass") ?? ""
        let loggedRole:String = UserDefaults.standard.string(forKey: "loggedRole") ?? ""
        let userId = UserDefaults.standard.string(forKey: "UserID") ?? ""
        
        let parameters: [String: Any] = [
            "tag" : tag,
            "userEmail" : userEmail,
            "userPass"  : userPass,
            "society_id" : societyId,
            "loggedRole"  : loggedRole,
            "user_id":userId
            
        ]
        print("guardchildLogsApiParam--->\(parameters)")
        var url : String = baseSeverUrl
        WebParamsApiManager.perFormRequest(url: url, params: parameters) {(res, error, errorcode) in
            
            print("guardchildLogsApiRes--->\(res ?? "")")
            if error == nil{
                self.removeSpinner_N()
                if let obj:NSDictionary =  res as? NSDictionary{
                    print(obj)
                    if let status:Int = obj["success"] as? Int{
                        print(status)
                        if status == 1{
                            self.removeSpinner_N()
                            if res != nil{
                                self.guardChildModel = try! JSONDecoder().decode(GuardChildLogmodel.self, from: WebAPIManager.jsonToString(json: res as Any).data(using: .utf8)!)
                                // self.guardlist = []
                                if self.guardChildModel?.data.count != 0 {
                                    self.guardChildlist.append(contentsOf: (self.guardChildModel?.data) ?? [])
                                    print("guardChildlist--->\(self.guardChildlist)")
                                    print(msg.self)
                                    print("guardChildlist.count\(self.guardChildlist.count)")
                                    
                                    
                                    self.mtableView.reloadData()
                                } else{
                                    self.removeSpinner_N()
                                    // self.displayMessage("Data Not found!")
                                }
                                //
                                print("Success-----")
                            }else{
                                self.removeSpinner_N()
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
    
    func verifyChildApi(_ token:String){
        //        showSpinner_N(onView: view)
        let tag:String = "confirmChildVisitG"
        let userEmail:String = UserDefaults.standard.string(forKey: "userEmail") ?? ""
        let userPass:String =  UserDefaults.standard.string(forKey: "userPass") ?? ""
        let loggedRole:String = UserDefaults.standard.string(forKey: "loggedRole") ?? ""
        let userId = UserDefaults.standard.string(forKey: "UserID") ?? ""
        
        let parameters: [String: Any] = [
            "tag" : tag,
            "userEmail" : userEmail,
            "userPass"  : userPass,
            "society_id" : societyId,
            "loggedRole"  : loggedRole,
            "user_id":userId,
            "FlatId":flatIdNo ?? "",
            "block_id":blockIDNo ?? "",
            "security_token":token
            
        ]
        print("verifybuttonApiParam--->\(parameters)")
        var url : String = baseSeverUrl
        WebParamsApiManager.perFormRequest(url: url, params: parameters) {(res, error, errorcode) in
            
            print("verifybuttonApiRes--->\(res ?? "")")
            if error == nil{
                self.removeSpinner_N()
                if let obj:NSDictionary =  res as? NSDictionary{
                    print(obj)
                    if let status:Int = obj["success"] as? Int{
                        print(status)
                        if status == 1{
                            self.removeSpinner_N()
                            self.childverify = try! JSONDecoder().decode(ChildVerifyModel.self, from: WebAPIManager.jsonToString(json: res as Any).data(using: .utf8)!)
                            if res != nil{
                                if let msg :String = obj["message"] as? String{
                                    print("ChildMessage\(msg)")
                                    self.displayMessage(msg)
                                    self.displayMessage(self.childverify?.msg)
                                }
                                
                                self.guardChildlist = []
                                self.guardchildLogsApi()
                                self.mtableView.reloadData()
                                
                            }else{
                                self.removeSpinner_N()
                                print("Data not found")
                            }
                            
                            //
                        }else{
                            self.removeSpinner_N()
                            self.guardChildlist = []
                            self.guardchildLogsApi()
                            self.mtableView.reloadData()
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
    
    
    func verifyPlannedApi(_ token:Int){
        //        showSpinner_N(onView: view)
        let tag:String = "verifyplannedvisitrequest"
        let userEmail:String = UserDefaults.standard.string(forKey: "userEmail") ?? ""
        let userPass:String =  UserDefaults.standard.string(forKey: "userPass") ?? ""
        let loggedRole:String = UserDefaults.standard.string(forKey: "loggedRole") ?? ""
        let userId = UserDefaults.standard.string(forKey: "UserID") ?? ""
        
        let parameters: [String: Any] = [
            "tag" : tag,
            "userEmail" : userEmail,
            "userPass"  : userPass,
            "society_id" : societyId,
            "loggedRole"  : loggedRole,
            "user_id":userId,
            "FlatId":flatIdNo ?? "",
            "visit_token":token
        ]
        print("verifyPlannedApiParam--->\(parameters)")
        var url : String = baseSeverUrl
        WebParamsApiManager.perFormRequest(url: url, params: parameters) {(res, error, errorcode) in
            
            print("verifyPlannedApiRes--->\(res ?? "")")
            if error == nil{
                self.removeSpinner_N()
                if let obj:NSDictionary =  res as? NSDictionary{
                    print(obj)
                    if let status:Int = obj["success"] as? Int{
                        print(status)
                        if status == 1{
                            self.removeSpinner_N()
                            if res != nil{
                                if let msg :String = obj["message"] as? String{
                                    self.displayMessage(msg)
                                }
                                self.guardlistPlanned = []
                                self.getAllVisitLogsApi(flatId: "", blockid: "")
                                self.mtableView.reloadData()
                                
                            }else{
                                self.removeSpinner_N()
                                self.guardlistPlanned = []
                                self.getAllVisitLogsApi(flatId: "", blockid: "")
                                self.mtableView.reloadData()
                                print("Data not found")
                            }
                            
                            //
                        }else{
                            self.removeSpinner_N()
                            self.guardlistPlanned = []
                            self.getAllVisitLogsApi(flatId: "", blockid: "")
                            self.mtableView.reloadData()
                            if let msg :String = obj["message"] as? String{
                                self.displayMessage(msg)
                            }
                        }
                    }else{
                        self.removeSpinner_N()
                        self.guardlistPlanned = []
                        self.getAllVisitLogsApi(flatId: "", blockid: "")
                        self.mtableView.reloadData()
                        if let msg :String = obj["message"] as? String{
                            self.displayMessage(msg)
                        }
                        
                    }
                }else{
                    self.removeSpinner_N()
                    self.guardlistPlanned = []
                    self.getAllVisitLogsApi(flatId: "", blockid: "")
                    self.mtableView.reloadData()
                    self.displayMessage("Something Went Wrong,Pls Try agian")
                }
            }else{
                self.removeSpinner_N()
                self.guardlistPlanned = []
                self.getAllVisitLogsApi(flatId: "", blockid: "")
                self.mtableView.reloadData()
                self.displayMessage("Something Went Wrong,Pls Try agian")
            }
            
            
        }
        
    }
    
    func GenerateVisitorsApi(){
        showSpinner_N(onView: view)
        let tag:String = "genratevisitrequest"
        let userEmail:String = UserDefaults.standard.string(forKey: "userEmail") ?? ""
        let userPass:String =  UserDefaults.standard.string(forKey: "userPass") ?? ""
        let loggedRole:String = UserDefaults.standard.string(forKey: "loggedRole") ?? ""
        let userId = UserDefaults.standard.string(forKey: "UserID") ?? ""
        
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
            "FlatId":flatNo ?? "",
            "block_id":blockNo ?? "",
            "visitor_name": username ?? "",
            "visitor_count":userCount ?? "",
            "emp_name":empname ?? "",
            "emp_count":empCount ?? "",
            "emp_visit_date": datestring ?? ""
            
        ]
        print("GenerateVisitorsApiParam--->\(parameters)")
        var url : String = baseSeverUrl
        WebParamsApiManager.perFormRequest(url: url, params: parameters) { [self](res, error, errorcode) in
            
            print("GenerateVisitorsApiRes--->\(res ?? "")")
            if error == nil{
                if let obj:NSDictionary =  res as? NSDictionary{
                    print(obj)
                    if let status:Int = obj["success"] as? Int{
                        print(status)
                        if status == 1{
                            self.removeSpinner_N()
                            if res != nil{
                                self.generateModel = try! JSONDecoder().decode(GuardGenerateModal.self, from: WebAPIManager.jsonToString(json: res as Any).data(using: .utf8)!)
                                generateMobileNo = generateModel?.ownerMobile
                                print("generateMobileNo--\(generateMobileNo)")
                                guardlistUnPlanned = []
                                getAllVisitLogsApi(flatId: "", blockid: "")
                                self.mtableView.reloadData()
                                
                                
                            }else{
                                self.removeSpinner_N()
                                self.displayMessage("Something Went Wrong,Pls Try agian")
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
    func RemarksApi(token:String,remark:String){
        //        showSpinner_N(onView: view)
        let tag:String = "updateRemarkGuard"
        let userEmail:String = UserDefaults.standard.string(forKey: "userEmail") ?? ""
        let userPass:String =  UserDefaults.standard.string(forKey: "userPass") ?? ""
        let loggedRole:String = UserDefaults.standard.string(forKey: "loggedRole") ?? ""
        let userId = UserDefaults.standard.string(forKey: "UserID") ?? ""
        
        let parameters: [String: Any] = [
            "tag" : tag,
            "userEmail" : userEmail,
            "userPass"  : userPass,
            "society_id" : societyId,
            "loggedRole"  : loggedRole,
            "user_id":userId,
            "FlatId":"8244",
            "block_id":blockIDNo ?? "",
            "visit_token":token,
            "remark":remark
            
        ]
        print("RemarksApiParam--->\(parameters)")
        var url : String = baseSeverUrl
        WebParamsApiManager.perFormRequest(url: url, params: parameters) {(res, error, errorcode) in
            
            print("RemarksApiRes--->\(res ?? "")")
            if error == nil{
                self.removeSpinner_N()
                if let obj:NSDictionary =  res as? NSDictionary{
                    print(obj)
                    if let status:Int = obj["success"] as? Int{
                        print(status)
                        if status == 1{
                            self.removeSpinner_N()
                            self.generateModel = try! JSONDecoder().decode(GuardGenerateModal.self, from: WebAPIManager.jsonToString(json: res as Any).data(using: .utf8)!)
                            if res != nil{
                                if let msg :String = obj["message"] as? String{
                                    self.displayMessage(msg)
                                }
                                //                                    self.guardlistUnPlanned = []
                                //                                    self.getAllVisitLogsApi(flatId: "", blockid: "")
                                //                                   // self.mtableView.reloadData()
                                
                            }else{
                                self.removeSpinner_N()
                                print("Data not found")
                            }
                            
                            //
                        }else{
                            self.removeSpinner_N()
                            //                                self.guardlistPlanned = []
                            //                                self.getAllVisitLogsApi(flatId: "", blockid: "")
                            //  self.mtableView.reloadData()
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
        }else if blockNo == nil {
            displayMessage("Enter Block No.")
        }else if flatNo == nil {
            displayMessage("Enter Flat No.")
        }else if datestring == nil {
            displayMessage("Enter Date")
        }else{
            GenerateVisitorsApi()
            self.mtableView.reloadData()
        }
    }

}

extension GuardLoginController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch segment.selectedSegmentIndex {
        case 0:
            return 2
        case 1:
            return 7
        case 2:
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
             return guardlistPlanned.count
            
            }
            break
            
        case 1:
            if section == 0{
                return 1
            }else if section == 1{
                return 1
            }else if section == 2{
                return 1
            }else if section == 3{
                return 1
            }else if section == 4{
                return 1
            }else if section == 5{
                return 1
            }else if section == 6{
                return guardlistUnPlanned.count
            }
            
            break
        case 2:
            if section == 0{
                return 1
            }else if section == 1{
                return guardChildlist.count
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
                let cell = self.mtableView.dequeueReusableCell(withIdentifier: "UnplannedVistorCell1", for: indexPath) as! UnplannedVistorCell1
                cell.UnplannedLbl.text = "Planned Visitors(Guard)"
                cell.visitorlbl.text = "Logs"
                cell.IconImage.isHidden = true
                cell.RefreshBtn.addTarget(self, action: #selector(ReloadPlanned(sender:)), for: .touchUpInside)
                return cell
            }else if indexPath.section == 1{
                let cell = self.mtableView.dequeueReusableCell(withIdentifier: "ChilfInfoLogCell", for: indexPath) as! ChilfInfoLogCell
                cell.shareButton.isHidden = true
                cell.VisitTokenLbel.isHidden = false
                cell.verifyBtn.isHidden = false
                cell.RemarkView.isHidden = true
                
                cell.Name.text = guardlistPlanned[indexPath.row].visitorName
                cell.ChildCount.text = "Visitor Count:\(guardlistPlanned[indexPath.row].visitorCount ?? 0)"
                cell.Time.text = guardlistPlanned[indexPath.row].visitDate
                cell.VisitTokenLbel.text = "Visitor Token:\(guardlistPlanned[indexPath.row].visitToken ?? 0)"
                
                if  guardlistPlanned[indexPath.row].status == 1{
                    cell.Status.text = "Pending"
                    cell.verifyBtn.isHidden = false
                    cell.Status.textColor = getepayYellowColor
                }else if guardlistPlanned[indexPath.row].status == 2{
                    cell.Status.text = "Approved"
                    cell.verifyBtn.isHidden = true
                    cell.Status.textColor = hexStringToUIColor(hex: "#249B60")
                }
         
                cell.VisitTokenLbel.font = .boldSystemFont(ofSize: 12)
                
                cell.verifyBtn.addTarget(self, action: #selector(verifyPlannedBtn(sender:)), for: .touchUpInside)
                
                return cell
            }
            
          break
            
        case 1:
            
            if indexPath.section == 0{
                let cell = self.mtableView.dequeueReusableCell(withIdentifier: "VistorCell1", for: indexPath) as! VistorCell1
                cell.VistorInfoLbl.text = "UnPlanned Visitor Info:(Guard)"
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
            }else if indexPath.section == 1{
                let cell = self.mtableView.dequeueReusableCell(withIdentifier: "VistorCell2", for: indexPath) as! VistorCell2
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
            }else if indexPath.section == 2{
                let cell = self.mtableView.dequeueReusableCell(withIdentifier: "DropDownCell", for: indexPath) as!
                DropDownCell
                cell.delegate = self
                cell.placeholderLbl.text = "Block Number"
                
                return cell
            }else if indexPath.section == 3{
                let cell = self.mtableView.dequeueReusableCell(withIdentifier: "DropDownCell2", for: indexPath) as!
                DropDownCell2
                cell.delegate = self
                
                return cell
            }else if indexPath.section == 4{
                let cell = self.mtableView.dequeueReusableCell(withIdentifier: "ChildInfoDateCell", for: indexPath) as!
                ChildInfoDateCell
                cell.delegate = self
                cell.GuardrequestView.isHidden = false
                cell.RequestBtn.addTarget(self, action: #selector(generatebtn(sender:)), for: .touchUpInside)
                cell.CallBtn.addTarget(self, action: #selector(callBtn(sender:)), for: .touchUpInside)
                return cell
            } else if indexPath.section == 5{
                let cell = self.mtableView.dequeueReusableCell(withIdentifier: "UnplannedVistorCell1", for: indexPath) as! UnplannedVistorCell1
                cell.UnplannedLbl.isHidden = true
                cell.visitorlbl.text = "Logs"
                cell.IconImage.isHidden = true
           //     cell.UnplanedLblheight.constant = 0
                cell.RefreshBtn.addTarget(self, action: #selector(ReloadUnPlanned(sender:)), for: .touchUpInside)
                
                return cell
            }else if indexPath.section == 6{
                let cell = self.mtableView.dequeueReusableCell(withIdentifier: "ChilfInfoLogCell", for: indexPath) as! ChilfInfoLogCell
                cell.delegate = self
                cell.shareButton.isHidden = true
                cell.VisitTokenLbel.isHidden = false
                cell.verifyBtn.isHidden = true
                cell.RemarkView.isHidden = false
                
                cell.Name.text = guardlistUnPlanned[indexPath.row].visitorName
                cell.ChildCount.text = "Visitor Count:\(guardlistUnPlanned[indexPath.row].visitorCount ?? 0)"
                cell.Time.text = guardlistUnPlanned[indexPath.row].visitDate
               
                cell.VisitTokenLbel.isHidden = true
                cell.remarkTxtFeild.tag = indexPath.row
                indexpathtag = cell.remarkTxtFeild.tag
                cell.remarkTxtFeild.addTarget(self, action: #selector(RemarkAction(sender:)), for: .touchUpInside)
                cell.VisitTokenLbel.font = .systemFont(ofSize: 10)
            
                
                if  guardlistUnPlanned[indexPath.row].status == 1{
                    cell.Status.text = "Pending"
                    cell.Status.textColor = getepayYellowColor
                    cell.RemarkView.isHidden = true
                    
                }else if guardlistUnPlanned[indexPath.row].status == 2{
                    cell.Status.text = "Approved"
                    cell.Status.textColor = hexStringToUIColor(hex: "#249B60")
                    
                    
            
                    if guardlistUnPlanned[indexPath.row].status == 1{
                        cell.RemarkView.isHidden = false
                    }else if guardlistUnPlanned[indexPath.row].status == 2{
                        cell.RemarkView.isHidden = true
                        cell.VisitTokenLbel.isHidden = false
                        cell.VisitTokenLbel.text = "Visitor Remark: \(guardlistUnPlanned[indexPath.row].remark ?? "")"
                    }
                }
                return cell
            }
            
           
          break
        case 2:
            if indexPath.section == 0{
                let cell = self.mtableView.dequeueReusableCell(withIdentifier: "UnplannedVistorCell1", for: indexPath) as! UnplannedVistorCell1
                cell.UnplannedLbl.isHidden = false
                cell.UnplannedLbl.text = "Child Info"
                cell.visitorlbl.text = "Logs"
                cell.IconImage.isHidden = false
               // cell.UnplanedLblheight.constant = 50
                cell.RefreshBtn.addTarget(self, action: #selector(ReloadChild(sender:)), for: .touchUpInside)
                return cell
            }else if indexPath.section == 1{
                let cell = self.mtableView.dequeueReusableCell(withIdentifier: "ChilfInfoLogCell", for: indexPath) as! ChilfInfoLogCell
                cell.shareButton.isHidden = true
              //  cell.ChildCount.text = "child Count: 1"
                cell.VisitTokenLbel.isHidden = false
               // cell.VisitTokenLbel.text = "Child Token: ****"
                cell.verifyBtn.isHidden = false
                cell.RemarkView.isHidden = true
                cell.verifyBtn.tag = indexPath.row
                cell.VisitTokenLbel.font = .boldSystemFont(ofSize: 12)
                
                cell.Name.text = guardChildlist[indexPath.row].childName1
                cell.ChildCount.text = "child Count: \(guardChildlist[indexPath.row].childCount ?? 0)"
                cell.Time.text = guardChildlist[indexPath.row].visitDateTime
                
                let originalText = guardChildlist[indexPath.row].visitToken ?? ""
                let labelPrefix = NSAttributedString(string: "Child token:")
                let secureAttributedString = convertToSecureText(originalText: originalText)
                
                let combinedAttributedString = NSMutableAttributedString()
                combinedAttributedString.append(labelPrefix)
                combinedAttributedString.append(secureAttributedString)
                
                cell.VisitTokenLbel.attributedText = combinedAttributedString
                
                if  guardChildlist[indexPath.row].approvalStatus == 1{
                    cell.Status.text = "Pending"
                    cell.verifyBtn.isHidden = false
                    cell.Status.textColor = getepayYellowColor
                }else if guardChildlist[indexPath.row].approvalStatus == 2{
                    cell.Status.text = "Approved"
                    cell.verifyBtn.isHidden = true
                    cell.Status.textColor = hexStringToUIColor(hex: "#249B60")
                    
                
                }
                cell.verifyBtn.addTarget(self, action: #selector(verifyChildBtn(sender:)), for: .touchUpInside)
                
                
                return cell
            }
            
            break
            
        default:
            break
        }
        
        return UITableViewCell()
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch segment.selectedSegmentIndex{
        case 0:
            if indexPath.section == 0{
                return 90
            }else if indexPath.section == 1{
                return 250
            }
            break
        case 1:
            if indexPath.section == 0{
                return 200
            }else if indexPath.section == 1{
                return 110
            }else if indexPath.section == 2{
                return 110
            }else if indexPath.section == 3{
                return 110
            }else if indexPath.section == 4{
                return 200
            }else if indexPath.section == 5{
                return 100
            }else if indexPath.section == 6{
                return 250
            }
           break
        case 2:
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
