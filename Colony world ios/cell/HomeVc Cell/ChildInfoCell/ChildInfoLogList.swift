//
//  ChildInfoLogList.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 05/05/23.
//

import UIKit

class ChildInfoLogList: UITableViewCell{
    @IBOutlet weak var reloadBtn: UIButton!
    var childModal:ChildInfoModal?
    var childList = [Datum1]()
    var sharetag:Int?
    var token:String?
    var childName:String?
    var date:String?
   
    @IBOutlet weak var mTableView: UITableView!
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    override func awakeFromNib() {
        super.awakeFromNib()
        ChildApi()
        self.mTableView.delegate = self
        self.mTableView.dataSource = self
        mTableView.register(UINib(nibName: "ChilfInfoLogCell", bundle: nil), forCellReuseIdentifier: "ChilfInfoLogCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @objc func buttonTapped(_ sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        if let cell = mTableView.cellForRow(at: indexPath) as? ChilfInfoLogCell {
            cell.messageView.isHidden = !cell.messageView.isHidden
              self.token = childList[indexPath.row].visitToken
              self.childName = childList[indexPath.row].childName1
            self.date = childList[indexPath.row].visitDateTime
            
            cell.WhatappBtn.tag = indexPath.row
            cell.EyeBtn.tag = indexPath.row
            cell.messageBtn.tag = indexPath.row
      
            cell.WhatappBtn.addTarget(self, action: #selector(Whatapp(sender:)), for: .touchUpInside)
            cell.EyeBtn.addTarget(self, action: #selector(EyeBtn(sender:)), for: .touchUpInside)
            cell.messageBtn.addTarget(self, action:  #selector (message),for: .touchUpInside)
        }
    }
    @IBAction func Whatapp(sender: Int){
       
        let vc = self.storyBoard.instantiateViewController(withIdentifier: "ChildWhatappPopups") as! ChildWhatappPopups
               vc.modalPresentationStyle = .overCurrentContext
               vc.providesPresentationContextTransitionStyle = false
               vc.definesPresentationContext = false
               vc.modalTransitionStyle = .crossDissolve
               vc.date = date
               vc.tokenno = token
        self.window?.rootViewController?.present(vc, animated: true, completion: nil)
    }
    @objc func message(){
        let textToShare = "Hello,\(childName ?? "") is at the gate for which the child token is \(token ?? "")"
         shareText(textToShare)

    }

    func shareText(_ text: String) {
        let activityViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        self.window?.rootViewController?.present(activityViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func EyeBtn(sender: Int){
       
        let vc = self.storyBoard.instantiateViewController(withIdentifier: "EventsPopup") as! EventsPopup
               vc.modalPresentationStyle = .overCurrentContext
               vc.providesPresentationContextTransitionStyle = false
               vc.definesPresentationContext = false
               vc.modalTransitionStyle = .crossDissolve
               vc.descData = "Visit Code is :\(token ?? "")"
        self.window?.rootViewController?.present(vc, animated: true, completion: nil)
    }
    
    func ChildApi(){
    
             let tag:String = "getChildVisitLogs"
             let userEmail:String = UserDefaults.standard.string(forKey: "userEmail") ?? ""
        let userPass:String =  UserDefaults.standard.string(forKey: "userPass") ?? ""
        let loggedRole:String = UserDefaults.standard.string(forKey: "loggedRole") ?? ""
        let userId = UserDefaults.standard.string(forKey: "UserID") ?? ""
        let flatId = UserDefaults.standard.string(forKey: "flatId") ?? ""
        let parameters: [String: Any] = [
            "tag" : tag,
            "userEmail" : userEmail,
            "userPass"  : userPass,
            "society_id" : societyId,
            "loggedRole"  : loggedRole,
            "user_id":userId,
            "FlatId":flatId
            
        ]
        print("ChildApiParam--->\(parameters)")
        var url : String = baseSeverUrl
        WebParamsApiManager.perFormRequest(url: url, params: parameters) {(res, error, errorcode) in
        
                print(res)
                if error == nil{
                    if let obj:NSDictionary =  res as? NSDictionary{
                        print(obj)
                        if let status:Int = obj["success"] as? Int{
                            print(status)
                            if status == 1{
                               
                                if res != nil{
                                    self.childModal = try! JSONDecoder().decode(ChildInfoModal.self, from: WebAPIManager.jsonToString(json: res as Any).data(using: .utf8)!)
                                    if self.childModal?.data?.count != 0 {
                                           self.childList.append(contentsOf: (self.childModal?.data) ?? [])
                                           print("childList--->\(self.childList)")
                                           print(msg.self)
                                        print("childList.count\(self.childList.count)")
                                        
                                           self.mTableView.reloadData()
                                       } else{
                                          
                                          print("Data Not found!")
                                       }
                                    
                                    print("Success-----")
                                }else{
                                    print("Data not found")
                                }
  
//
                            }else{
                            
                                if let msg :String = obj["message"] as? String{
                                   print(msg)
                                }
                            }
                        }else{
                         
                            if let msg :String = obj["message"] as? String{
                              print(msg)
                            }
                            
                        }
                    }else{
                        print("msg")
                    }
                }else{
                    print("msg")
                }
                
                
            }
            
            
            
        }
    
    @IBAction func ReloadAction(_ sender: UIButton) {
       
        childList = []
        ChildApi()
        self.mTableView.reloadData()
    }
}
extension ChildInfoLogList:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mTableView.dequeueReusableCell(withIdentifier: "ChilfInfoLogCell", for: indexPath) as! ChilfInfoLogCell
        cell.Name.text = childList[indexPath.row].childName1
        cell.Time.text = childList[indexPath.row].visitDateTime
        cell.ChildCount.text = "Child Count:\(childList[indexPath.row].childCount ?? 0)"
        cell.VisitTokenLbel.isHidden = true
      //  cell.VisitTokenLbel.text = "Child Token:\(childList[indexPath.row].visitToken ?? "")"
        
        cell.shareButton.tag = indexPath.row
        cell.shareButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
          sharetag = cell.shareButton.tag
        
        if  childList[indexPath.row].approvalStatus == 1{
            cell.Status.text = "Pending"
            cell.Status.textColor = getepayYellowColor
        }else if childList[indexPath.row].approvalStatus == 2{
            cell.Status.text = "Approved"
            cell.Status.textColor = hexStringToUIColor(hex: "#249B60")
        }else if childList[indexPath.row].approvalStatus == 3{
            cell.Status.text = "Rejected"
            cell.Status.textColor = .red
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 250
    }

}
//"Visitor Token:\(visitorLogList[indexPath.row].visitToken )"
