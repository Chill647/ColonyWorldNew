//
//  DropDownCell.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 01/06/23.
//

import UIKit
import iOSDropDown

protocol Dropdown1: class {
    func dropDwonblock(Block:String)
}
class DropDownCell: UITableViewCell {
    
    weak var delegate:Dropdown1?
    @IBOutlet weak var placeHolderWidth: NSLayoutConstraint!
    @IBOutlet weak var placeholderLbl: UILabel!
    @IBOutlet weak var droptxtFeild: DropDown!
    var blockModel:GetBlockModal?
    var blockIdList: [Int] = []
    var DropDownArray = [String]()
    override func awakeFromNib() {
        super.awakeFromNib()
        getBlockApi()
       

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func getBlockApi(){
//        showSpinner_N(onView: view)
        let tag:String = "getAllBlocks"
        let userEmail:String = UserDefaults.standard.string(forKey: "userEmail") ?? ""
        let userPass:String =  UserDefaults.standard.string(forKey: "userPass") ?? ""
        let loggedRole:String = UserDefaults.standard.string(forKey: "loggedRole") ?? ""
        let userId = UserDefaults.standard.string(forKey: "UserID") ?? ""
        let blockId = UserDefaults.standard.string(forKey: "BlockId") ?? ""
        let parameters: [String: Any] = [
            "tag" : tag,
            "userEmail" : userEmail,
            "userPass"  : userPass,
            "society_id" : societyId,
            "loggedRole"  : loggedRole
            
        ]
        print("getBlockApiParam--->\(parameters)")
        var url : String = baseSeverUrl
        WebParamsApiManager.perFormRequest(url: url, params: parameters) {(res, error, errorcode) in
        
                print("getBlockApiRes--->\(res ?? "")")
                if error == nil{
                   
                    if let obj:NSDictionary =  res as? NSDictionary{
                        print(obj)
                        if let status:Int = obj["success"] as? Int{
                            print(status)
                            if status == 1{
                               
                                if res != nil{
                                self.blockModel = try! JSONDecoder().decode(GetBlockModal.self, from: WebAPIManager.jsonToString(json: res as Any).data(using: .utf8)!)

                                    if let blockData = self.blockModel?.data, !blockData.isEmpty {
                                             // self.flatArrayList.append(contentsOf: blockData)

                                              // Store only the flat IDs in the flatIdList array
                                        self.blockIdList = blockData.map { $0.blockID ?? 0 }


                                        self.droptxtFeild.optionArray = self.blockIdList.map { String($0) }
                                        self.droptxtFeild.didSelect{(selectedText , index ,id) in
                                            self.droptxtFeild.text = "\(selectedText)"
                                            print("self.droptxtFeild.text--\(self.droptxtFeild.text)")
                                            self.delegate?.dropDwonblock(Block: self.droptxtFeild.text ?? "")
                                      }
                                      //  print("flatArrayList--->\(self.flatArrayList)")
                                        print("blockIdList--->\(self.blockIdList)")
                                          } else{
                                        print("data not Found")
                                    }
                                 
                                }else{
                                   
                                    print("Data not found")
                                }
  
//
                            }else{
                              
                               
                                if let msg :String = obj["message"] as? String{
                                   print("Data Not Found")
                                }
                            }
                        }else{
                            print("Something Went Wrong,Pls Try agian")
                            
                        }
                    }else{
                        print("Something Went Wrong,Pls Try agian")
                    }
                }else{
                    
                    print("Something Went Wrong,Pls Try agian")
                }
                
                
        }
     
    }
}
