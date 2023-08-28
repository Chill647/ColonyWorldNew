//
//  DropDownCell2.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 03/06/23.
//

import UIKit
import iOSDropDown


protocol Dropdown2: class {
    func dropDownFlat(Flat:String)
}
class DropDownCell2: UITableViewCell {
    weak var delegate:Dropdown2?
    @IBOutlet weak var placeHolderWidth: NSLayoutConstraint!
    @IBOutlet weak var placeholderLbl: UILabel!
    @IBOutlet weak var droptxtFeild: DropDown!
    var DropDownArray = [String]()
    var flatModel:GetFlatmodal?
    var flatArrayList = [flatList]()
    var flatIdList: [Int] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        getFlatNoApi()
        self.DropDownArray = ["401","402","501"]
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func getFlatNoApi(){
//        showSpinner_N(onView: view)
        let tag:String = "getFlatByBlock"
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
            "loggedRole"  : loggedRole,
            "block_id" : "673"
        ]
        print("getFlatNoApiParam--->\(parameters)")
        var url : String = baseSeverUrl
        WebParamsApiManager.perFormRequest(url: url, params: parameters) {(res, error, errorcode) in
        
                print("getFlatNoApiRes--->\(res ?? "")")
                if error == nil{
                   
                    if let obj:NSDictionary =  res as? NSDictionary{
                        print(obj)
                        if let status:Int = obj["success"] as? Int{
                            print(status)
                            if status == 1{
                               
                                if res != nil{
                                    self.flatModel = try! JSONDecoder().decode(GetFlatmodal.self, from: WebAPIManager.jsonToString(json: res as Any).data(using: .utf8)!)
                                   
                                    if let flatData = self.flatModel?.data, !flatData.isEmpty {
                                              self.flatArrayList.append(contentsOf: flatData)
                                              
                                              // Store only the flat IDs in the flatIdList array
                                        self.flatIdList = flatData.map { $0.flatID ?? 0 }
                                       
                                        
                                        self.droptxtFeild.optionArray = self.flatIdList.map { String($0) }
                                        self.droptxtFeild.didSelect{(selectedText , index ,id) in
                                            self.droptxtFeild.text = "\(selectedText)"
                                            print("self.droptxtFeild.text--\(self.droptxtFeild.text)")
                                            self.delegate?.dropDownFlat(Flat: self.droptxtFeild.text ?? "")
                                      }
                                        print("flatArrayList--->\(self.flatArrayList)")
                                        print("flatIdList--->\(self.flatIdList)")
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
