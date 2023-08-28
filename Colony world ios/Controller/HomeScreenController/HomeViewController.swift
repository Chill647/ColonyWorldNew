//
//  HomeViewController.swift
//  Colony world ios
//
//  Created by Getepay 2022 on 19/12/22.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController,MenuControllerDelegate,CustomTableViewCellDelegate,CustomTableViewCellDelegate2{
  
    
   
    @IBOutlet weak var HeaderLbl: UILabel!
    
    @IBOutlet weak var HeaderView: UIView!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var mTableView: UITableView!
    var contact_Arr = [Any]()
    var indexPath = 0
    var mobileNo = [Int]()
    private var sideMenu:SideMenuNavigationController?
    var customTableViewCell = DashBoardbottomViewCell()
    var profileResponse:ProfileModal?
    var UpdateVersion:UpdateVersionModel?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        AppVerssionApi()
        profileApi()
        HeaderView.backgroundColor = getepayYellowColor
       // UpdateNavigationBar()
       // hidesBottomBarWhenPushed = false
       customTableViewCell.delegate = self
       let menu = MenuController(with: SideMenuItem.allCases)
       sideMenu = SideMenuNavigationController(rootViewController: menu)
       sideMenu?.leftSide = true
       sideMenu?.setNavigationBarHidden(true, animated: false)
       menu.delegate = self
       SideMenuManager.default.leftMenuNavigationController = sideMenu
       SideMenuManager.default.addPanGestureToPresent(toView: view)
        print("loginCredentials----\(UserDefaults.standard.string(forKey: "userEmail"))----\(UserDefaults.standard.string(forKey: "userPass"))")
       
        self.mTableView.delegate = self
        self.mTableView.dataSource = self
         mTableView.register(UINib(nibName: "dashboardBannerCell", bundle: nil), forCellReuseIdentifier: "dashboardBannerCell")
        mTableView.register(UINib(nibName: "DashBoardbottomViewCell", bundle: nil), forCellReuseIdentifier: "DashBoardbottomViewCell")
        mTableView.register(UINib(nibName: "DashboardBottomOtherCell", bundle: nil), forCellReuseIdentifier: "DashboardBottomOtherCell")
        mTableView.register(UINib(nibName: "DashBoardBottomThoughtCell", bundle: nil), forCellReuseIdentifier: "DashBoardBottomThoughtCell")
      
        FcmTokenApi()
    }
    
    func updateScreen(){
        let string1 = "Hello \(UserDefaults.standard.string(forKey: "name") ?? ""),"
              let font1 = UIFont.boldSystemFont(ofSize: 18)
              let attributedString1 = NSAttributedString(string: string1, attributes: [NSAttributedString.Key.font: font1])
              
              let string2 = "\(UserDefaults.standard.string(forKey: "blockName") ?? "")  \(UserDefaults.standard.string(forKey: "flatNo") ?? "")  \(societyName1)"
        let font2 = UIFont.systemFont(ofSize: 19)
              let attributedString2 = NSAttributedString(string: string2, attributes: [NSAttributedString.Key.font: font2])
              
              // Create a mutable attributed string to combine the two
              let combinedString = NSMutableAttributedString()
              combinedString.append(attributedString1)
              combinedString.append(NSAttributedString(string: " ")) // Add space between the two strings
              combinedString.append(attributedString2)
              
              // Assign the combined attributed string to the label
          HeaderLbl.attributedText = combinedString
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
       
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        updateScreen()
    }
    
    @IBAction func TutorialsBtn(_ sender: Any) {
        let moveVC = self.storyboard?.instantiateViewController(withIdentifier: "TutorialsController") as! TutorialsController
           self.navigationController?.pushViewController(moveVC, animated: true)
    }
    @IBAction func ContactUsBtn(_ sender: UIButton) {
        let moveVC = self.storyboard?.instantiateViewController(withIdentifier: "ContactUsViewController") as! ContactUsViewController
           self.navigationController?.pushViewController(moveVC, animated: true)
    }
    
    @IBAction func didTapButton(_ sender: Any) {
        present(sideMenu!,animated: true)
    }
    func didSelectMenuItem(named: SideMenuItem) {
        sideMenu?.dismiss(animated: true, completion:nil)
         title = named.rawValue
        
        switch named {
        case .Dashboard:
            let moveVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
               self.navigationController?.pushViewController(moveVC, animated: true)
            
        case .Profile:
            let moveVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
              self.navigationController?.pushViewController(moveVC, animated: true)
   
        case .PayNow:
            let moveVC = self.storyboard?.instantiateViewController(withIdentifier: "PayMaintenanceController1") as! PayMaintenanceController1
               self.navigationController?.pushViewController(moveVC, animated: true)
        
        case .History:
            let moveVC = self.storyboard?.instantiateViewController(withIdentifier: "PaymentHistoryViewController") as! PaymentHistoryViewController
               self.navigationController?.pushViewController(moveVC, animated: true)
        case .ChildSecurity:
            let moveVC = self.storyboard?.instantiateViewController(withIdentifier: "ChildInfoController") as! ChildInfoController
               self.navigationController?.pushViewController(moveVC, animated: true)
        case .Tutorial:
            let moveVC = self.storyboard?.instantiateViewController(withIdentifier: "TutorialsController") as! TutorialsController
               self.navigationController?.pushViewController(moveVC, animated: true)
        case .Gallery:
            let moveVC = self.storyboard?.instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController
               self.navigationController?.pushViewController(moveVC, animated: true)
            
        case .Circular:
            
            let moveVC = self.storyboard?.instantiateViewController(withIdentifier: "CircularViewController") as! CircularViewController
               self.navigationController?.pushViewController(moveVC, animated: true)
            
        case .Event:
            let moveVC = self.storyboard?.instantiateViewController(withIdentifier: "EventsViewController") as! EventsViewController
               self.navigationController?.pushViewController(moveVC, animated: true)
        case .Support:
            let moveVC = self.storyboard?.instantiateViewController(withIdentifier: "ContactUsViewController") as! ContactUsViewController
            
            self.navigationController?.pushViewController(moveVC, animated: true)
            
        case .Logout:
            let moveVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
         //   tabBarController?.hidesBottomBarWhenPushed = true
           // tabBarController?.tabBar.frame.size.height   = 0
                moveVC.storeData = "not-nill"
               self.navigationController?.pushViewController(moveVC, animated: true)
       
        }
    }
    
   
    func profileApi(){
        
        let tag:String = "profile"
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
        print("profileApiRequestbody-->\(parameters)")
    
        var url : String = baseSeverUrl
        WebParamsApiManager.perFormRequest(url: url, params: parameters) { [self](res, error, errorcode) in
          
            print("profileApiResponse--->\(res)")
           
            if error == nil{
               
                if let obj:NSDictionary =  res as? NSDictionary{
                    print(obj)
                    if let status:Int = 1 as? Int{
                        print(status)
                        if status == 1{
                            self.removeSpinner_N()
                            if res != nil{
                                self.profileResponse = try! JSONDecoder().decode(ProfileModal.self, from: WebAPIManager.jsonToString(json: res as Any).data(using: .utf8)!)
                                
                                print("profileResponse--->\(self.profileResponse)")

                            
                                self.contact_Arr.append(profileResponse?.support?.supportMobile1 ?? "")
                                self.contact_Arr.append(profileResponse?.support?.supportMobile2 ?? "")
                                print("contact_Arr-->\(contact_Arr )")
                                UserDefaults.standard.set(self.contact_Arr, forKey: "contactList")
                                
                                
                                 UserDefaults.standard.set(self.profileResponse?.name ?? "", forKey: "name")
                               print( "USername--->\(UserDefaults.standard.set(self.profileResponse?.name ?? "", forKey: "name"))")
                                UserDefaults.standard.set(self.profileResponse?.contact1 ?? "", forKey: "Mobileno")
                                UserDefaults.standard.set(self.profileResponse?.support?.supportEmail, forKey: "Email")
                                UserDefaults.standard.set(self.profileResponse?.blockName, forKey: "blockName")
                                UserDefaults.standard.set(self.profileResponse?.flatNameNo, forKey: "flatNo")
                                UserDefaults.standard.set(self.profileResponse?.email, forKey: "UserEmail1")
                                UserDefaults.standard.set(self.profileResponse?.flatID, forKey: "flatId")
                                UserDefaults.standard.set(self.profileResponse?.blockID, forKey: "BlockId")
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
    
    func FcmTokenApi(){
       
        let tag:String = "fcm"
        let token:String = fcmTocken_Val
        var userID:Int = UserDefaults.standard.integer(forKey: "UserID")
       

        print("FcmTokenReq--->\(tag)-----\(token)---\(userID)-----\(societyId)")

        let parameters: [String: Any] = [
            "tag" : tag,
            "token" : token,
            "user_id" : userID,
            "society_id" : societyId
        ]
        
        print("FcmRequestbody-->\(parameters)")
        var url : String = "https://colony.getekart.com/index.php?plugin=MobileAPI&action=fcm"
        WebParamsApiManager.perFormRequest(url: url, params: parameters) {(res, error, errorcode) in
          
            print("FcmTokenApiRes--->\(res)")
            if error == nil{
               
                if let obj:NSDictionary =  res as? NSDictionary{
                    print(obj)
                    if let status:Int = obj["success"] as? Int{
                        print(status)
                        if status == 1{
                            self.removeSpinner_N()
                            if res != nil{
                              //  self.profileResponse = try! JSONDecoder().decode(ProfileModal.self, from: WebAPIManager.jsonToString(json: res as Any).data(using: .utf8)!)
                                
//                                print("FcmTokenApiResponse--->\(self.profileResponse)")

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
    
    func AppVerssionApi(){
       
        let tag:String = "getSocietyAppVersion"
       
        let parameters: [String: Any] = [
            "tag" : tag,
            "society_id" : societyId
        ]
        
        print("AppVerssionApiParam-->\(parameters)")
        var url : String = baseSeverUrl
        WebParamsApiManager.perFormRequest(url: url, params: parameters) {(res, error, errorcode) in
          
            print("AppVerssionApiRes--->\(res)")
            if error == nil{
               
                if let obj:NSDictionary =  res as? NSDictionary{
                    print(obj)
                    var data = try! JSONDecoder().decode(UpdateVersionModel.self, from: WebAPIManager.jsonToString(json: res as Any).data(using: .utf8)!)
                    var appVersion = data.data?.iosVersion
                    print("appVersion--->\(appVersion ?? "")")
                    let mobileAppVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
                    print("mobileAppVersion--\(mobileAppVersion ?? "")")
                    
                  
                    if let status:Int = obj["success"] as? Int{
                        print(status)
                        if status == 1{
                          
                            self.removeSpinner_N()
                            if mobileAppVersion ?? "" >= (appVersion ?? ""){
                               
                            } else{
                                let alert = UIAlertController(title: "\(societyName1)", message: "Please Update Your Application !!", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Update Now", style: .default, handler: { (alertResponse) in
                                    DispatchQueue.main.async {
                                        self.openAppStore()
                                    }
                                }))
                                self.present(alert, animated: true, completion: nil)
                                print("App is already Upadate")
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
   
    func openAppStore() {
        
        print("bundleIdentifier---\(Bundle.main.bundleIdentifier ?? "")")
        if let url = URL(string:"\(appID)"),
            UIApplication.shared.canOpenURL(url){
            //print(url)
            UIApplication.shared.open(url, options: [:]) { (opened) in
                if(opened){
                    //print("App Store Opened")
                }
            }
        } else {
            //print("Can't Open URL on Simulator")
        }
    }
    func passTheCurrent2(tableIndex: Int, collectionViewIndex: Int) {
             if collectionViewIndex == 0{
                    let moveVC = self.storyboard?.instantiateViewController(withIdentifier: "ParkingController") as! ParkingController
                    print("MoveVC")
                        self.navigationController?.pushViewController(moveVC, animated: true)
                }else if collectionViewIndex == 1{
                    let moveVC = self.storyboard?.instantiateViewController(withIdentifier: "VistorController") as! VistorController
                    print("MoveVC")
                        self.navigationController?.pushViewController(moveVC, animated: true)
                }else if collectionViewIndex == 2{
                    let moveVC = self.storyboard?.instantiateViewController(withIdentifier: "ChildInfoController") as! ChildInfoController
                    print("MoveVC")
                        self.navigationController?.pushViewController(moveVC, animated: true)
                }else if collectionViewIndex == 3{
                    let moveVC = self.storyboard?.instantiateViewController(withIdentifier: "PaymentHistoryViewController") as! PaymentHistoryViewController
                    print("MoveVC")
                        self.navigationController?.pushViewController(moveVC, animated: true)
                }
    }
}

extension HomeViewController :UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
        let cell = mTableView.dequeueReusableCell(withIdentifier: "dashboardBannerCell", for: indexPath) as! dashboardBannerCell
            
       return cell ??  UITableViewCell()
        
        } else if indexPath.section == 1 {
            let cell = mTableView.dequeueReusableCell(withIdentifier: "DashBoardbottomViewCell", for: indexPath) as! DashBoardbottomViewCell
            cell.delegate = self
           return cell ??  UITableViewCell()
        }else if indexPath.section == 2{
            let cell = mTableView.dequeueReusableCell(withIdentifier: "DashboardBottomOtherCell", for: indexPath) as! DashboardBottomOtherCell
             cell.delegate2 = self
           return cell ??  UITableViewCell()
        }else if indexPath.section == 3{
            let cell = mTableView.dequeueReusableCell(withIdentifier: "DashBoardBottomThoughtCell", for: indexPath) as! DashBoardBottomThoughtCell
         
           return cell ??  UITableViewCell()
        }
       
        return UITableViewCell()
    }
    
    func passTheCurrent(tableIndex: Int, collectionViewIndex: Int) {
        if collectionViewIndex == 0{
            let moveVC = self.storyboard?.instantiateViewController(withIdentifier: "PayMaintenanceController1") as! PayMaintenanceController1
            print("MoveVC")
                self.navigationController?.pushViewController(moveVC, animated: true)
        }
        else if collectionViewIndex == 1{
            let moveVC = self.storyboard?.instantiateViewController(withIdentifier: "EventsViewController") as! EventsViewController
            print("MoveVC")
                self.navigationController?.pushViewController(moveVC, animated: true)
        }  else if collectionViewIndex == 2{
            let moveVC = self.storyboard?.instantiateViewController(withIdentifier: "CircularViewController") as! CircularViewController
            print("MoveVC")
                self.navigationController?.pushViewController(moveVC, animated: true)
        }else if collectionViewIndex == 3{
            let moveVC = self.storyboard?.instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController
            
            print("MoveVC")
                self.navigationController?.pushViewController(moveVC, animated: true)
        }

        
       
        
      
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 180
        } else if indexPath.section == 1{
            return 200
        }else if indexPath.section == 2{
            return 200
        }else if indexPath.section == 3{
            return 200
        }
       return CGFloat()
        
    }
    
   
    
    
}

