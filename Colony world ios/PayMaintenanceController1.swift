//
//  PayMaintenanceController1.swift
//  Colony world ios
//
//  Created by Getepay 2022 on 18/03/23.
//

import UIKit

class PayMaintenanceController1: UIViewController {

    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var depositLbl: UILabel!
    @IBOutlet weak var duesLbl: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var payDataView: UIView!
    @IBOutlet weak var paynowBtn: UIButton!
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var mainView: UIView!
    var isCheck1 = [String]()
    var paymaintenaceResponse:PayMaintenanceModal?
    var paymentlist = [Maintenanse]()
    var SelectedList = [Maintenanse]()
    var checkStatus:Bool = true
    var previousCount:Int?
    var statusChecker = ""
    var tag:Int = 0
    var FeesId = [Int]()
    var PaymentId = [Int]()
    var maintenanceCost = [Int]()
  //  var Amount = [Int]()
    var totalAMount:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        updateScreen()
        paynowBtn.isHidden = true
        self.mTableView.delegate = self
        self.mTableView.dataSource = self
        mTableView.register(UINib(nibName: "PayMaintenanceCell", bundle: nil), forCellReuseIdentifier: "PayMaintenanceCell")
       
        PayMaintenanceApi()
        self.mTableView.reloadData()
         
    }
    
    func paymentRecord (){
        duesLbl.text = "\(paymaintenaceResponse?.totalDue ?? 0)"
        totalAmount.text = "\(paymaintenaceResponse?.advancedAmount ?? 0)"
        depositLbl.text = "\(paymaintenaceResponse?.totalPaid ?? 0)"
        
    }
    
    
    
    @IBAction func payNowBtn(_ sender: Any) {
//        if ValuePass != ""{
//            let moveVC = self.storyboard?.instantiateViewController(withIdentifier: "PayOptionController") as! PayOptionController
//            moveVC.valuedata = ValuePass
//            self.navigationController?.pushViewController(moveVC, animated: true)
//        }else{
//            ValuePass = ""
//            ValidateMessage("Please Select Payment Fess")
//        }
        
        totalAMount = maintenanceCost.reduce(0, { $0 + $1 })
       print("totalAMount-->\(totalAMount)")
        let moveVC = self.storyboard?.instantiateViewController(withIdentifier: "PayOptionController") as! PayOptionController
                   moveVC.amount = totalAMount ?? 0
                   moveVC.PaymentID = PaymentId
                   moveVC.feesID = FeesId
                   self.navigationController?.pushViewController(moveVC, animated: true)
       
    }
    func updateScreen(){
    //    topViewHeight.constant = 52
        paynowBtn.backgroundColor = getepayYellowColor
        //UpdateNavigationBar()
        mainView.backgroundColor = getepayYellowColor
        topView.clipsToBound = true
        topView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        topView.layer.cornerRadius = 15
        payDataView.layer.cornerRadius = 20
        payDataView.layer.shadowColor = UIColor.gray.cgColor
        payDataView.layer.shadowOpacity = 0.8
        payDataView.layer.shadowOffset = .zero
        payDataView.layer.shadowRadius = 5
    }
    
    func PayMaintenanceApi(){
        showSpinner_N(onView: view)
        let tag:String = "maintenance"
        let userEmail:String = UserDefaults.standard.string(forKey: "userEmail") ?? ""
        let userPass:String = UserDefaults.standard.string(forKey: "userPass") ?? ""
        let loggedRole:String = UserDefaults.standard.string(forKey: "loggedRole") ?? ""
        print("PayMaintenanceApiReq--->\(userEmail)------\(userPass)-----\(loggedRole)----\(societyId)")
       
        let parameters: [String: Any] = [
            "tag" : tag,
            "userEmail" : userEmail,
            "userPass"  : userPass,
            "society_id" : societyId,
            "loggedRole": loggedRole
        ]
        print("paymaintenanceParam----\(parameters)")
        var url : String = baseSeverUrl
        WebParamsApiManager.perFormRequest(url: url, params: parameters) {(res, error, errorcode) in
            print("PayMaintenanceUrl---\(url)")
            print("PayMaintenanceApi--->\(res)")
            if error == nil{
                if let obj:NSDictionary =  res as? NSDictionary{
                    print(obj)
                    if let status:Int = 1 as? Int{
                        print(status)
                      
                        if status == 1{
                            
                            self.removeSpinner_N()
                            if PayMaintenanceModal.self != nil{
                                
                                self.paymaintenaceResponse = try! JSONDecoder().decode(PayMaintenanceModal.self, from: WebAPIManager.jsonToString(json: res as Any).data(using: .utf8)!)
                                
                                print("paymaintenaceResponse--->\(self.paymaintenaceResponse)")
                            
                                if self.paymaintenaceResponse?.maintenanse?.count != 0 {

                                    self.paymentlist.append(contentsOf: ((self.paymaintenaceResponse?.maintenanse) ?? [] ))
                                    if (self.paymentlist != nil && !self.paymentlist.isEmpty){
                                        self.paynowBtn.isHidden = false
                                        self.SelectedList.append(contentsOf: self.paymentlist)
                                    }
                                
                                    print("paymentlist--->\(self.paymentlist)")
                                    print("paymentlist.count--->\(self.paymentlist.count)")
                                    print(msg.self)
                                    
                                    self.paymentRecord ()
                                    self.mTableView.reloadData()
                                } else{
                                    self.removeSpinner_N()
                                    // self.displayMessage("Data Not found!")
                                }
                            }else{
                                self.removeSpinner_N()
                                if let msg :String = obj["message"] as? String{
                                    self.displayMessage(msg)
                                }
                            }
                           
               
                        }
                        else{
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
    
    // This code is button is selected and deslected without Validation
    
    
    @IBAction func btnCheckUncheckClick(_sender: UIButton) {
        let buttonTag = _sender.tag
        print(buttonTag)
        
        // Check if the button is currently selected or deselected
        let isSelected = SelectedList[buttonTag].isCheck == "true"
        
        if isSelected {
            // Deselect the button
            SelectedList[buttonTag].isCheck = "false"
            _sender.setImage(UIImage(named: "uncheckedRadio"), for: .normal)
            
            // Remove the corresponding data from arrays
            let paymentIDToRemove = SelectedList[buttonTag].feesName[0].paymentID ?? 0
            if let index = PaymentId.firstIndex(of: paymentIDToRemove) {
                PaymentId.remove(at: index)
            }
            maintenanceCost.remove(at: buttonTag)
            FeesId.remove(at: buttonTag)
            
            print("PaymentIdRemove--\(PaymentId)")
            print("maintenanceCostRemove\(maintenanceCost)")
            print("FeesId--\(FeesId)")
        } else {
            // Select the button
            SelectedList[buttonTag].isCheck = "true"
            _sender.setImage(UIImage(named: "checkedRadio"), for: .normal)
            
            // Add the corresponding data to arrays
            PaymentId.append(SelectedList[buttonTag].feesName[0].paymentID ?? 0)
            print("\(PaymentId)--->PaymentId")
            
            maintenanceCost.append(SelectedList[buttonTag].feesName[0].amount ?? 0)
            print("\(maintenanceCost)--->maintenanceCost")
            
            FeesId.append(SelectedList[buttonTag].feesName[0].feesID ?? 0)
            print("\(FeesId)--->FeesId")
        }
    }

    
    
    // This code is button is selected and deslected with Validation
    
//    @IBAction func btnCheckUncheckClick(_sender:UIButton){
//        let buttonTag = _sender.tag
//        print(buttonTag)
//        if (_sender.imageView?.image == UIImage(named: "checkedRadio")){
//            if (buttonTag>0 && buttonTag<SelectedList.count-1) {
//                                          if (SelectedList[buttonTag - 1].isCheck == "true" && SelectedList[buttonTag + 1].isCheck == "false") {
//                                              SelectedList[buttonTag].isCheck = "false"
//                                              _sender.setImage(UIImage.init(named: "uncheckedRadio"), for: .normal)
//                                              PaymentId.remove(at: buttonTag)
//                                              maintenanceCost.remove(at: buttonTag)
//                                              FeesId.remove(at: buttonTag)
//                                              print("PaymentIdRemove--\(PaymentId)")
//                                              print("maintenanceCostRemove\(maintenanceCost)")
//                                              print("FeesId--\(FeesId)")
//                                          }else{
////                                              SelectedList[buttonTag].isCheck = "false";
////                                              _sender.setImage(UIImage.init(named: "uncheckedRadio"), for: .normal)
//                                              ValidateMessage("Please Select valid fees")
//                                          }
//
//                                      }else if (buttonTag == 0){
//                                          if (SelectedList.count>0 && SelectedList[buttonTag + 1].isCheck == "true"){
////                                              SelectedList[buttonTag].isCheck = "false"
////                                              _sender.setImage(UIImage.init(named: "uncheckedRadio"), for: .normal)
//                                              ValidateMessage("Please Select valid fees")
//
//                                          }else{
//                                                  SelectedList[buttonTag].isCheck = "false"
//                                        _sender.setImage(UIImage.init(named: "uncheckedRadio"), for: .normal)
//                                              PaymentId.remove(at: buttonTag)
//                                              maintenanceCost.remove(at: buttonTag)
//                                              FeesId.remove(at: buttonTag)
//                                              print("PaymentIdRemove--\(PaymentId)")
//                                              print("maintenanceCostRemove\(maintenanceCost)")
//                                              print("FeesId--\(FeesId)")
//                                          }
//
//                                      }else {
//                                          SelectedList[buttonTag].isCheck = "false"
//
//                                      }
//                    }else{
//            SelectedList[buttonTag].isCheck = "true"
//            if buttonTag > 0{
//
//                    if (SelectedList[buttonTag - 1].isCheck == "true"){
//                        _sender.setImage(UIImage.init(named: "checkedRadio"), for: .normal)
//
//
//                        PaymentId.append(SelectedList[buttonTag].feesName[0].paymentID ?? 0)
//                        print("\(PaymentId)--->PaymentId")
//                       print(SelectedList[buttonTag].isCheck)
//
//                        maintenanceCost.append(SelectedList[buttonTag].feesName[0].amount ?? 0)
//                        print("\(maintenanceCost)--->maintenanceCost")
//
//                        FeesId.append(SelectedList[buttonTag].feesName[0].feesID ?? 0)
//                        print("\(FeesId)--->FeesId")
//
//
//                    }else{
//                        SelectedList[buttonTag].isCheck = "false"
//                        _sender.setImage(UIImage.init(named: "uncheckedRadio"), for: .normal)
//                        ValidateMessage("Please pay previous installment")
//                      //  PaymentId.remove(at: buttonTag)
//                    }
//                    }else if buttonTag == 0{
//
//                            if (SelectedList[buttonTag].isCheck == "true"){
//                                _sender.setImage(UIImage.init(named: "checkedRadio"), for: .normal)
//                                PaymentId.append(SelectedList[buttonTag].feesName[0].paymentID ?? 0)
//
//                                print("\(PaymentId)--->PaymentId")
//                                print(SelectedList[buttonTag].isCheck)
//
//                                maintenanceCost.append(SelectedList[buttonTag].feesName[0].amount ?? 0)
//                                print("\(maintenanceCost)--->maintenanceCost")
//
//                                FeesId.append(SelectedList[buttonTag].feesName[0].feesID ?? 0)
//                                print("\(FeesId)--->FeesId")
//
//                            }else{
//                                SelectedList[buttonTag].isCheck = "false"
//                                _sender.setImage(UIImage.init(named: "uncheckedRadio"), for: .normal)
//
//                                ValidateMessage("Please pay previous installment")
//                                PaymentId.remove(at: buttonTag)
//                                maintenanceCost.remove(at: buttonTag)
//                                FeesId.remove(at: buttonTag)
//                                print("PaymentIdRemove--\(PaymentId)")
//                                print("maintenanceCostRemove\(maintenanceCost)")
//                                print("FeesId--\(FeesId)")
//                            }
//                //
//
//                    }else{
//
//            }
//
//
//        }
//
//
//        }

        
        
    }
        
     
    

//,MyCellDelegate
extension PayMaintenanceController1:UITableViewDelegate,UITableViewDataSource{
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return paymentlist.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
            let cell = mTableView.dequeueReusableCell(withIdentifier: "PayMaintenanceCell", for: indexPath) as! PayMaintenanceCell
      //      cell.periodLbl.text = "\(self.paymentlist[indexPath.row].feesName[0].fees ?? "")\n\(self.paymentlist[indexPath.row].feesName[0].maintainName ?? "")"
        
            cell.periodLbl.text = "\(self.paymentlist[indexPath.row].feesName[0].fees ?? "")"
            cell.maintenanceCostLbl.text = "\(self.paymentlist[indexPath.row].feesName[0].amount ?? 0)"
           //DD-MM-YYYY
            let dateString = self.paymentlist[indexPath.row].feesName[0].dueDate ?? ""
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"

            if let date = dateFormatter.date(from: dateString) {
                dateFormatter.dateFormat = "dd-MM-yyyy"
                let formattedDate = dateFormatter.string(from: date)
                cell.DueDateLbl.text = formattedDate
                print(formattedDate) // Output: 05-04-2023
            }
            
         
           
         //   checkedRadio
            
            cell.Checkbutton.tag = indexPath.row
            cell.Checkbutton.addTarget(self, action: #selector(btnCheckUncheckClick(_sender:)), for: .touchUpInside)
            tag = cell.Checkbutton.tag
           
            cell.Checkbutton.setImage(UIImage.init(named: "uncheckedRadio"), for: .normal)
            cell.Checkbutton.setImage(UIImage.init(named: "checkedRadio"), for: .selected)
            
            
            
            
            return cell
      
  
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 200
        
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = mTableView.cellForRow(at: indexPath) as! PayMaintenanceCell
//        ValuePass = "\(paymentlist[indexPath.row])"
       
    }

    func ValidateMessage(_ message:String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)

             // add the actions (buttons)
             alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            

             // show the alert
             self.present(alert, animated: true, completion: nil)
    }
}
