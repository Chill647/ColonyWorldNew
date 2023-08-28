//
//  PayMaintenanceViewController.swift
//  Colony world ios
//
//  Created by Getepay 2022 on 26/12/22.
//

import UIKit
import SwiftGridView


//
//class PayMaintenanceViewController: UIViewController {
//   
//    @IBOutlet var mainView: UIView!
//    @IBOutlet weak var PayNowBtn: UIButton!
//    @IBOutlet weak var dataGridView: SwiftGridView!
//    @IBOutlet weak var maintenaceMessageLbl: UILabel!
//    @IBOutlet weak var popupMaintenance: UIView!
//    var paymaintenaceResponse:PayMaintenanceModal?
//    var paymentlist = [Maintenanse]()
//    var dataCache = NSCache<NSString, NSString>()
//   // private let cache = NSCache<NSNumber, UIImage>()
//  //  private let utilityQueue = DispatchQueue.global(qos: .utility)
//    var headerArray = ["Select Maintenance","Period","Maintenance Cost","Due Date",""]
//    var checkStatus:Bool = true
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        popupMaintenance.isHidden = true
//        PayMaintenanceApi()
//        updateScreen()
//        self.dataGridView.delegate = self
//        self.dataGridView.dataSource = self
//        self.dataGridView.register(UINib(nibName: String(describing: GridViewHeader.self), bundle: nil), forSupplementaryViewOfKind: SwiftGridElementKindHeader, withReuseIdentifier: GridViewHeader.reuseIdentifier())
//        self.dataGridView.register(UINib(nibName: String(describing: GridViewCell.self), bundle: nil), forCellWithReuseIdentifier: GridViewCell.reuseIdentifier())
//       
//    }
//    @IBAction func crossBtn(_ sender: Any) {
//        popupMaintenance.isHidden = true
//    }
//
//    func updateScreen(){
//        UpdateNavigationBar()
//        mainView.backgroundColor = getepayYellowColor
//        PayNowBtn.backgroundColor = getepayYellowColor
//    }
//    
//    @IBAction func PayNowAction(_ sender: Any) {
//        if checkStatus == true{
//            popupMaintenance.isHidden = false
//            maintenaceMessageLbl.text = "Please Select Previous Maintenance!!!"
//           
//        }else{
//            let moveVC = self.storyboard?.instantiateViewController(withIdentifier: "PayOptionController") as! PayOptionController
//            self.navigationController?.pushViewController(moveVC, animated: true)
//
//        }
//       
//    }
//    func PayMaintenanceApi(){
//       
//        let tag:String = "maintenance"
//        let userEmail:String = UserDefaults.standard.string(forKey: "userEmail") ?? ""
//        let userPass:String = UserDefaults.standard.string(forKey: "userPass") ?? ""
//        let society_id:String = UserDefaults.standard.string(forKey: "soceityId") ?? ""
//        let loggedRole:String = UserDefaults.standard.string(forKey: "loggedRole") ?? ""
//        print("PayMaintenanceApiReq--->\(userEmail)------\(userPass)-----\(loggedRole)----\(society_id)")
//
//        let parameters: [String: Any] = [
//            "tag" : tag,
//            "userEmail" : userEmail,
//            "userPass"  : userPass,
//            "society_id" : societyId,
//            "loggedRole": loggedRole
//        ]
//        var url : String = baseSeverUrl
//        WebParamsApiManager.perFormRequest(url: url, params: parameters) {(res, error, errorcode) in
//          
//            print("PayMaintenanceApi--->\(res)")
//            if error == nil{
//                if let obj:NSDictionary =  res as? NSDictionary{
//                    print(obj)
//                    if let status:Int = 1 as? Int{
//                        print(status)
//                      
//                        if status == 1{
//                            
//                            self.removeSpinner_N()
//                            
//                            self.paymaintenaceResponse = try! JSONDecoder().decode(PayMaintenanceModal.self, from: WebAPIManager.jsonToString(json: res as Any).data(using: .utf8)!)
//                            
//                            print("paymaintenaceResponse--->\(self.paymaintenaceResponse)")
//                            if self.paymaintenaceResponse?.maintenanse?.count != 0 {
//                         
//                                self.paymentlist.append(contentsOf: (self.paymaintenaceResponse?.maintenanse)!)
//                                print("paymentlist--->\(self.paymentlist)")
//                                print("paymentlist.count--->\(self.paymentlist.count)")
//                                print(msg.self)
//                                
//                                
//                              self.dataGridView.reloadData()
//                            } else{
//                                self.removeSpinner_N()
//                                // self.displayMessage("Data Not found!")
//                            }
//               
//                        }
//                        else{
//                            self.removeSpinner_N()
//                            if let msg :String = obj["message"] as? String{
//                                self.displayMessage(msg)
//                            }
//                        }
//                    }else{
//                        self.removeSpinner_N()
//                        if let msg :String = obj["message"] as? String{
//                            self.displayMessage(msg)
//                        }
//                        
//                    }
//                }else{
//                    self.removeSpinner_N()
//                    self.displayMessage("Something Went Wrong,Pls Try agian")
//                }
//            }else{
//                self.removeSpinner_N()
//                self.displayMessage("Something Went Wrong,Pls Try agian")
//            }
//          
//
//        }
//        
//    
//        
//    }
//    
////    func checkedValidate()->Bool {
////        if checkStatus == 0{
////            popupMaintenance.isHidden = false
////            maintenaceMessageLbl.text = "Please Select Previous Maintenance!!!"
////            return false
////        }
////        return true
////    }
//}
//
//// MARK: - SwiftGridViewDataSource Methods
//extension PayMaintenanceViewController: SwiftGridViewDataSource {
//   
//    func dataGridView(_ dataGridView: SwiftGridView, cellAtIndexPath indexPath: IndexPath) -> SwiftGridCell {
//      
//        let cell =  dataGridView.dequeueReusableCellWithReuseIdentifier(GridViewCell.reuseIdentifier(), forIndexPath: indexPath) as! GridViewCell
//            cell.prepareForReuse()
//       
//        let gridColors : [UIColor] = [.white]
//        if indexPath.sgColumn == 0{
//            checkStatus = cell.isNil
//            cell.radioBtn.isHidden = false
//            cell.titleLabel.isHidden = true
//            cell.radioBtn.image = UIImage(named: "UncheckBox")
//           
//        }
//       else if(indexPath.sgColumn == 1) {
//          // self.labelData.setObject(, forKey: <#T##AnyObject#>)
//           var data1 = "\(self.paymentlist[indexPath.sgRow].feesName[0].fees)\n\(self.paymentlist[indexPath.sgRow].feesName[0].maintainName)"
//         
//           cell.radioBtn.isHidden = true
//           cell.titleLabel.text = "\(self.paymentlist[indexPath.sgRow].feesName[0].fees)\n\(self.paymentlist[indexPath.sgRow].feesName[0].maintainName)"
////           dataCache.setObject(cell.titleLabel, forKey:)
//       } else if indexPath.sgColumn == 2{
//           cell.radioBtn.isHidden = true
//           cell.titleLabel.text = "\(self.paymentlist[indexPath.sgRow].feesName[0].amount)"
//       }else if indexPath.sgColumn == 3{
//           cell.radioBtn.isHidden = true
//           cell.titleLabel.text = "\(self.paymentlist[indexPath.sgRow].feesName[0].dueDate)"
//       }
//
//        cell.backgroundColor = gridColors.randomElement()
//        return cell
//        
//    }
//    
//
//    func dataGridView(_ dataGridView: SwiftGridView, gridHeaderViewForColumn column: NSInteger) -> SwiftGridReusableView {
//        let headerView = dataGridView.dequeueReusableSupplementaryViewOfKind(SwiftGridElementKindHeader, withReuseIdentifier: GridViewHeader.reuseIdentifier(), atColumn: column) as! GridViewHeader
//        headerView.prepareForReuse()
//    
//        if column == 0{
//            headerView.titleLabel.text = "\(headerArray[0])"
//        }else if column == 1{
//            headerView.titleLabel.text = "\(headerArray[1])"
//        }else if column == 2{
//            headerView.titleLabel.text = "\(headerArray[2])"
//        }else if column == 3 {
//            headerView.titleLabel.text = "\(headerArray[3])"
//        }else if column == 4 {
//            headerView.titleLabel.text = "\(headerArray[4])"
//        }
//      
//       
//        return headerView
//    }
//    func dataGridView(_ dataGridView: SwiftGridView, didSelectCellAtIndexPath indexPath: IndexPath) {
//        let cell = dataGridView.cellForItem(at: indexPath) as! GridViewCell
//        if cell.isCheck == false{
//              cell.isCheck = true
//              checkStatus = false
//
//           cell.radioBtn.image = UIImage(named: "checkBox")
//            print("You have selected 1")
//        
//
//        }else{
//            cell.isCheck = false
//            checkStatus = true
//            cell.radioBtn.image = UIImage(named: "UncheckBox")
//            print("You have selected 2")
//        }
//      
//    }
//    
//    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        let cell =  dataGridView.cellForItem(at: indexPath) as! GridViewCell
//         cell.radioBtn.image = UIImage(named: "UncheckBox")
//        print("You have deselected ")
//      
//    }
//    
//}
//// MARK: - SwiftGridViewDelegate Methods
//extension PayMaintenanceViewController: SwiftGridViewDelegate {
//    
//    func numberOfSectionsInDataGridView(_ dataGridView: SwiftGridView) -> Int {
//        return 1
//    }
//    
//    func numberOfColumnsInDataGridView(_ dataGridView: SwiftGridView) -> Int {
//        return 4
//    }
//    
//    func dataGridView(_ dataGridView: SwiftGridView, numberOfRowsInSection section: Int) -> Int {
//        return paymentlist.count
//    }
//    func heightForGridHeaderInDataGridView(_ dataGridView: SwiftGridView) -> CGFloat {
//        return 75
//    }
//    
//    func dataGridView(_ dataGridView: SwiftGridView, widthOfColumnAtIndex columnIndex: Int) -> CGFloat {
//        return 170
//    }
//    func dataGridView(_ dataGridView: SwiftGridView, heightOfRowAtIndexPath indexPath: IndexPath) -> CGFloat {
//        return 75
//    }
//    
//    
//}
