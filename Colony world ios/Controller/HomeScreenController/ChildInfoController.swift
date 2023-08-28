//
//  ChildInfoController.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 29/04/23.
//

import UIKit
protocol listPass{
    func dataPassing (data:[logsModal])
}


class ChildInfoController: UIViewController,TextFieldDelegate,DatePickerCellDelegate {
    
    var delegate: listPass?
    @IBOutlet weak var AddTxtFeild: UITextField!
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var HeaderView: UIView!
    var stringArr = [Int]()
    var childModal:ChildInfoModal?
    var childToken:ChildTokenModal?

    var childList = [Datum1]()
    var value1:String?
    var listModal:logsModal?
    var StringArray = Array<logsModal>()
    var dateValue:String?
    var numberic:Int?
    var sharetag:Int?
    var datePass:String?
    var token:String?
    var childName:String?
    override func viewDidLoad() {
        super.viewDidLoad()
//         ChildApi()
//        self.mTableView.reloadData()
        updateScreen()
        
        self.mTableView.delegate = self
        self.mTableView.dataSource = self
        mTableView.register(UINib(nibName: "ChildInfoCell1", bundle: nil), forCellReuseIdentifier: "ChildInfoCell1")
        
        mTableView.register(UINib(nibName: "ChildInfoDateCell", bundle: nil), forCellReuseIdentifier: "ChildInfoDateCell")
        mTableView.register(UINib(nibName: "ChildInfoLogList", bundle: nil), forCellReuseIdentifier: "ChildInfoLogList")
    }
    func textFieldDidEndEditing(cell: UITableViewCell, value: String) {
     value1 = value
    }
    
    func datePickerCellValueChanged(date: String) {
        print("ChildDate--\(date)")
      dateValue = date
    }
    

    @IBAction func AddChild(_ sender: UITextField) {
        if let txt = AddTxtFeild.text, !txt.isEmpty {
            guard let inputValue = Int(txt), inputValue >= 0 && inputValue <= 10 else {
                return
            }

            if inputValue > stringArr.count {
                // Add rows
                let rowsToAdd = inputValue - stringArr.count

                for i in stringArr.count..<(stringArr.count + rowsToAdd) {
                    stringArr.append(i)
                }

                let insertedIndexPaths = (stringArr.count - rowsToAdd..<stringArr.count).map { IndexPath(row: $0, section: 0) }

                mTableView.beginUpdates()
                mTableView.insertRows(at: insertedIndexPaths, with: .automatic)
                mTableView.endUpdates()
            } else if inputValue < stringArr.count {
                // Remove rows
                let rowsToRemove = stringArr.count - inputValue
                stringArr.removeLast(rowsToRemove)

                let deletedIndexPaths = (stringArr.count..<stringArr.count + rowsToRemove).map { IndexPath(row: $0, section: 0) }

                mTableView.beginUpdates()
                mTableView.deleteRows(at: deletedIndexPaths, with: .automatic)
                mTableView.endUpdates()
            }

            print("Add_StringArr--\(stringArr)")
        }
    }


    
    @IBAction func  minusTxtFeild(sender: UIButton) {

        let rowIndexToRemove = sender.tag
           print("rowIndexToRemove--\(rowIndexToRemove)")
           
           guard rowIndexToRemove >= 0 && rowIndexToRemove < stringArr.count else {
               return
           }
           
           stringArr.remove(at: rowIndexToRemove)
           print("stringArr--\(stringArr)")
           
           mTableView.beginUpdates()
           let deletedIndexPath = IndexPath(row: rowIndexToRemove, section: 0)
           mTableView.deleteRows(at: [deletedIndexPath], with: .automatic)
           mTableView.endUpdates()
           
          
           for i in rowIndexToRemove..<mTableView.visibleCells.count {
               if let cell = mTableView.cellForRow(at: IndexPath(row: i, section: 0)) as? ChildInfoCell1 {
                   cell.minusBTn.tag = i
               }
           }
    }
    func updateScreen(){
        HeaderView.backgroundColor = getepayYellowColor
    }

    @IBAction func generateRequest(_sender:UIButton){
        validation()
    }
 

    
    func childButtonApi (){
        showSpinner_N(onView: view)
        let tag:String = "addChildVisit"
        let userEmail:String = UserDefaults.standard.string(forKey: "userEmail") ?? ""
        let userPass:String =  UserDefaults.standard.string(forKey: "userPass") ?? ""
        let loggedRole:String = UserDefaults.standard.string(forKey: "loggedRole") ?? ""
        let userId = UserDefaults.standard.string(forKey: "UserID") ?? ""
        let flatId = UserDefaults.standard.string(forKey: "flatId") ?? ""
        let childname1 = value1
        let parameters: [String: Any] = [
            "tag" : tag,
            "userEmail" : userEmail,
            "userPass"  : userPass,
            "society_id" : societyId,
            "loggedRole"  : loggedRole,
            "user_id":userId,
            "FlatId":flatId,
            "block_id": UserDefaults.standard.string(forKey: "BlockId") ?? "",
            "child_count":AddTxtFeild.text ?? "",
            "visit_date":dateValue ?? "",
            "child_name_1":value1 ?? "",
            "child_name_2":"",
            "child_name_3":"",
            "child_name_4":"",
            "child_name_5":"",
            "child_name_6":"",
            "child_name_7":"",
            "child_name_8":"",
            "child_name_9":"",
            "child_name_10":""
        ]
        print("childButtonApiParam--->\(parameters)")
        var url : String = baseSeverUrl
        WebParamsApiManager.perFormRequest(url: url, params: parameters) {(res, error, errorcode) in
        
                print("childButtonApiRes---\(res)")
                if error == nil{
                    if let obj:NSDictionary =  res as? NSDictionary{
                        print(obj)
                        if let status:Int = obj["success"] as? Int{
                            print(status)
                            if status == 1{
                                self.removeSpinner_N()
                                if res != nil{
                                    self.childToken = try! JSONDecoder().decode(ChildTokenModal.self, from: WebAPIManager.jsonToString(json: res as Any).data(using: .utf8)!)
                                    var token = self.childToken?.securityToken
                                    if let msg :String = obj["message"] as? String{
                                        self.displayMessage(msg)
                                        
                                    }
                                  
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
        
        if AddTxtFeild.text == "" {
            displayMessage("Enter Child Count")
        }else if value1 == nil {
            displayMessage("Enter Child Name")
        }else if dateValue == nil {
            displayMessage("Enter Date")
        }else{
            childButtonApi()
            self.mTableView.reloadData()
        }
    }

    
}
extension ChildInfoController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
      return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            
           print("stringArr.count--\(stringArr.count)")
            return stringArr.count
        }else if section == 1{
            return 1
        }else if section == 2 {
      
            return 1
          
        }
        return 0
}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = mTableView.dequeueReusableCell(withIdentifier: "ChildInfoCell1", for: indexPath) as! ChildInfoCell1
            cell.delegate = self
            cell.minusBTn.tag = indexPath.row
            cell.minusBTn.addTarget(self, action: #selector(minusTxtFeild(sender:)), for: .touchUpInside)
            return cell
        }else if indexPath.section == 1 {
            let cell = mTableView.dequeueReusableCell(withIdentifier: "ChildInfoDateCell", for: indexPath) as! ChildInfoDateCell
            cell.GenerateBtn.tag = indexPath.row
            cell.delegate = self
            cell.GenerateBtn.isHidden = false
            cell.GenerateBtn.addTarget(self, action: #selector(generateRequest(_sender:)), for: .touchUpInside)
      
           
            return cell
        } else if indexPath.section == 2{
            let cell = mTableView.dequeueReusableCell(withIdentifier: "ChildInfoLogList", for: indexPath) as! ChildInfoLogList

            return cell
        }
       
       return UITableViewCell()
    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     
     
        if indexPath.section == 0{
            return 100
        }else if indexPath.section == 1{
            return 180
        }else if indexPath.section == 2{
            return 600
        }
        return 0
    }
    
    

    
}
