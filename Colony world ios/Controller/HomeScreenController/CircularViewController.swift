//
//  CircularViewController.swift
//  Colony world ios
//
//  Created by Futuretek on 25/01/23.
//

import UIKit

class CircularViewController: UIViewController {
    @IBOutlet var mTableView: UITableView!
    @IBOutlet weak var headerColor: UIView!
    var CircularResponse:CircularModal?
    var CircularModalist = [Circular]()
    var circularId = 0
    var indexInteger:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
       // UpdateNavigationBar()
        CircularApi()
        self.mTableView.reloadData()
        headerColor.backgroundColor = getepayYellowColor
        self.mTableView.delegate = self
        self.mTableView.dataSource = self
        mTableView.register(UINib(nibName: "CircularViewCell", bundle: nil), forCellReuseIdentifier: "CircularViewCell")
    }
    
    
    
    func CircularApi(){
        showSpinner_N(onView: view)
        let tag:String = "circulars"
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
        print("CircularParameters--->\(parameters)")
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
                                self.CircularResponse = try! JSONDecoder().decode(CircularModal.self, from: WebAPIManager.jsonToString(json: res as Any).data(using: .utf8)!)
                                if self.CircularResponse?.circulars.count != 0 {
                                    self.CircularModalist.append(contentsOf: (self.CircularResponse?.circulars)!)
                                    print("CircularModalist--->\(self.CircularModalist)")
                                    print(msg.self)
                                   
                                    
                                    self.mTableView.reloadData()
                                } else{
                                    self.removeSpinner_N()
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
                }else{
                    self.removeSpinner_N()
                    self.displayMessage("Something Went Wrong,Pls Try agian")
                }
                
                
            }
            
            
            
        }
        
    }
    

extension CircularViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CircularModalist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mTableView.dequeueReusableCell(withIdentifier: "CircularViewCell", for: indexPath) as! CircularViewCell
        cell.publishStrDate.text = CircularModalist[indexPath.row].publishDate
        cell.publishEndDate.text = CircularModalist[indexPath.row].publishTodate
        cell.societyLabel.text = CircularModalist[indexPath.row].title
        circularId = CircularModalist[indexPath.row].circularID ?? 0
        cell.downloadBtn.tag = indexPath.row
        cell.downloadBtn.addTarget(self, action:  #selector (downloadData),for: .touchUpInside)
        indexInteger = indexPath.row
        return cell ??  UITableViewCell()
    }
    
    
    @objc func downloadData(){
        let moveVC = self.storyboard?.instantiateViewController(withIdentifier: "CircularDetailsController") as! CircularDetailsController
        moveVC.circularID = circularId
        moveVC.index = indexInteger
        print("moveVC.index--\(moveVC.index)")
       self.navigationController?.pushViewController(moveVC, animated: true)
    
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let moveVC = self.storyboard?.instantiateViewController(withIdentifier: "CircularDetailsController") as! CircularDetailsController
//        moveVC.circularID = circularId
//        moveVC.index = indexPath.row
//        print("moveVC.index--\(moveVC.index)")
//       self.navigationController?.pushViewController(moveVC, animated: true)
//    }
}
