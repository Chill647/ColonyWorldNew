//
//  EventsViewController.swift
//  Colony world ios
//
//  Created by Futuretek on 25/01/23.
//

import UIKit

class EventsViewController: UIViewController {
    
    
//    @IBOutlet weak var popupLabel: UILabel!
//    @IBOutlet weak var Popupview: UIView!
    @IBOutlet var mTableView: UITableView!
    @IBOutlet weak var headerColor: UIView!
    var EventsResponse:EventsModal?
    var EventsModalist = [Event]()
    var desc = ""
    override func viewDidLoad() {
        super.viewDidLoad()
     //   UpdateNavigationBar()
        EventsApi()
        self.mTableView.reloadData()
        headerColor.backgroundColor = getepayYellowColor
        self.mTableView.delegate = self
        self.mTableView.dataSource = self
        mTableView.register(UINib(nibName: "EventsViewCell", bundle: nil), forCellReuseIdentifier: "EventsViewCell")

    }
//    func updateScreen(){
//        Popupview.isHidden = true
//    }
//    @IBAction func okPopupbtn(_ sender: Any) {
//        Popupview.isHidden = true
//    }
    func EventsApi(){
        showSpinner_N(onView: view)
        let tag:String = "user_events"
        let userEmail:String = UserDefaults.standard.string(forKey: "userEmail") ?? ""
        let userPass:String =  UserDefaults.standard.string(forKey: "userPass") ?? ""
        let loggedRole:String = UserDefaults.standard.string(forKey: "loggedRole") ?? ""
        let parameters: [String: Any] = [
            "tag" : tag,
            "userEmail" : userEmail,
            "userPass"  : userPass,
            "society_id" : societyId,
            "loggedRole"  : loggedRole
        ]
        var url : String = baseSeverUrl
        WebParamsApiManager.perFormRequest(url: url, params: parameters) {(res, error, errorcode) in
        
                print(res)
                if error == nil{
                    if let obj:NSDictionary =  res as? NSDictionary{
                        print(obj)
                        if let status:Int = 1 as? Int{
                            print(status)
                            if status == 1{
                                self.removeSpinner_N()
                                
                                self.EventsResponse = try! JSONDecoder().decode(EventsModal.self, from: WebAPIManager.jsonToString(json: res as Any).data(using: .utf8)!)
                                if self.EventsResponse?.events.count != 0 {
                                    self.EventsModalist.append(contentsOf: (self.EventsResponse?.events)!)
                                    print("EventsModalist--->\(self.EventsModalist)")
                                    print(msg.self)
                                    
                                    
                                    self.mTableView.reloadData()
                                } else{
                                    self.removeSpinner_N()
                                    // self.displayMessage("Data Not found!")
                                }
                                UserDefaults.standard.set("true", forKey: "isLoggedIn")
                             
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


extension EventsViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventsModalist.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mTableView.dequeueReusableCell(withIdentifier: "EventsViewCell", for: indexPath) as! EventsViewCell
        
        
       var Date = EventsModalist[indexPath.row].start.replacingOccurrences(of: "00:00:00 GMT+0000", with: "")
        cell.startDateLbl.text = Date
        cell.societyLabel.text = EventsModalist[indexPath.row].title
        cell.EyeButton.tag = indexPath.row
        cell.EyeButton.addTarget(self, action:  #selector (downloadData),for: .touchUpInside)
        desc = EventsModalist[indexPath.row].event_desc
        if !desc.isEmpty{
            cell.EyeButton.isHidden = false
        }else{
            cell.EyeButton.isHidden = true
        }
            
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    @objc func downloadData(){

         let vc = self.storyboard?.instantiateViewController(withIdentifier: "EventsPopup") as! EventsPopup
                vc.modalPresentationStyle = .overCurrentContext
                vc.providesPresentationContextTransitionStyle = false
                vc.definesPresentationContext = false
                vc.modalTransitionStyle = .crossDissolve
                 vc.descData = desc
                self.present(vc, animated: true,completion: nil)
    }
    
}


