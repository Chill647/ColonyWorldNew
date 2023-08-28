//
//  ParkingController.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 22/05/23.
//

import UIKit

class ParkingController: UIViewController {

    @IBOutlet weak var mtableView: UITableView!
   
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var cornerView: UIView!
    var parkingModel:ParkingModal?
    var parkingList = [parkingArray]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateScreen()
       
        
        self.mtableView.delegate = self
        self.mtableView.dataSource = self
       
        mtableView.register(UINib(nibName: "ParkingViewCell", bundle: nil), forCellReuseIdentifier: "ParkingViewCell")
        ParkingApi()
        
    }
    
    func updateScreen(){
        cornerView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
         mainView.backgroundColor = getepayYellowColor
        
        cornerView.CornerRadious  = 20

    }
    
    
    func ParkingApi(){
        
        let tag:String = "viewParkingSlot"
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
        print("ParkingApiRequestbody-->\(parameters)")
    
        var url : String = baseSeverUrl
        WebParamsApiManager.perFormRequest(url: url, params: parameters) { [self](res, error, errorcode) in
          
            print("ParkingApiResponse--->\(res)")
           
            if error == nil{
               
                if let obj:NSDictionary =  res as? NSDictionary{
                    print(obj)
                    if let status:Int = obj["success"] as? Int{
                        print(status)
                        if status == 1{
                            self.removeSpinner_N()
                            if res != nil{
                                self.parkingModel = try! JSONDecoder().decode(ParkingModal.self, from: WebAPIManager.jsonToString(json: res as Any).data(using: .utf8)!)
                                if self.parkingModel?.data.count != 0 {
                                    self.parkingList.append(contentsOf: (self.parkingModel?.data)!)
                                    print("ParkingApilist--->\(self.parkingList)")
                                   
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
}
extension ParkingController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parkingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mtableView.dequeueReusableCell(withIdentifier: "ParkingViewCell", for: indexPath) as! ParkingViewCell
        cell.blockName.text = parkingList[indexPath.row].blockName
        cell.flatNo.text = parkingList[indexPath.row].flatNameNo
        cell.slotLbl.text =  parkingList[indexPath.row].slotName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 330
    }
}
