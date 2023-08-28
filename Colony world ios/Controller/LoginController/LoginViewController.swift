//
//  ViewController.swift
//  Colony world ios
//
//  Created by Asim Getepay 2022 on 14/12/22.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
     
    @IBOutlet weak var welcomeLbl: UILabel!
    @IBOutlet weak var SoceityName: UILabel!
    @IBOutlet weak var eyeButton: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var RoundedView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    var iconClick = true
    var storeData:String = ""
    var loginResponse:LoginModal?
    var callback:(()->())?
    override func viewDidLoad() {
        super.viewDidLoad()
      //  UpdateNavigationBar()
      
        if storeData == "not-nill"{
            
         //  tabBarController?.hidesBottomBarWhenPushed = true
            UserDefaults.standard.removeObject(forKey: "isLoggedIn")
            UserDefaults.standard.removeObject(forKey: "userEmail")
            UserDefaults.standard.removeObject(forKey: "userPass")
            UserDefaults.standard.removeObject(forKey: "loggedRole")
            UserDefaults.standard.removeObject(forKey: "name")
            UserDefaults.standard.removeObject(forKey: "Mobileno")
            UserDefaults.standard.removeObject(forKey: "UserID")
            UserDefaults.standard.removeObject(forKey: "UserEmail1")
            UserDefaults.standard.removeObject(forKey: "SoceityName")
            UserDefaults.standard.removeObject(forKey: "flatId")
            UserDefaults.standard.removeObject(forKey: "BlockId")
            
            
           
            print("Name2--\(UserDefaults.standard.string(forKey: "name") ?? "")")
            
           
        }else{
            var isLoggedIn : String = UserDefaults.standard.string(forKey: "isLoggedIn") ?? ""
                          if(isLoggedIn != nil && isLoggedIn == "true"){
//                              let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//                              self.navigationController?.pushViewController(vc, animated: true)

                              let nextViewController =  self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                               tabBarController?.hidesBottomBarWhenPushed = false
                              self.navigationController?.pushViewController(nextViewController, animated: true)

                          } else if(isLoggedIn != nil && isLoggedIn == "false"){
                              //                              let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                              //                              self.navigationController?.pushViewController(vc, animated: true)

                                                            let nextViewController =  self.storyboard?.instantiateViewController(withIdentifier: "GuardLoginController") as! GuardLoginController
                                                            // tabBarController?.hidesBottomBarWhenPushed = false
                                                            self.navigationController?.pushViewController(nextViewController, animated: true)

                                        }
        }

       updateScreen()
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    @IBAction func eyeBittonPressed(_ sender: UIButton) {
        if (iconClick == true){
            passwordText.isSecureTextEntry = false
           
        }else{
            passwordText.isSecureTextEntry = true
           
        }
        iconClick = !iconClick
    }
    
    
    @IBAction func loginButton(_ sender: UIButton) {
        if validate(){
            loginApi()
        }
    }
   
    func validate() -> Bool {
        
        if (usernameText.text == ""){
            displayMessage(title: "Username", msg: "Please enter Username")
            return false
        }else if(passwordText.text == ""){
            displayMessage(title: "Password", msg: "Please enter Password")
            return false
        }
        
        return true
    }
    
    
    @IBAction func ForgetBtn(_ sender: Any) {
        
        let moveVC = self.storyboard?.instantiateViewController(withIdentifier: "ForgetPasswordController") as! ForgetPasswordController
        
        self.navigationController?.pushViewController(moveVC, animated: true)
        
    }
   
    func updateScreen(){
        var image = AppImage
        imageView.image = UIImage(named: "\(image)")
        imageView.contentMode = .scaleAspectFit
        userNameView.layer.shadowColor = UIColor.black.cgColor
        userNameView.layer.shadowOpacity = 0.2
        userNameView.layer.shadowOffset = CGSize(width: 4, height: 4)
        userNameView.layer.shadowRadius = 5
        userNameView.layer.masksToBounds = false
        
        passwordView.layer.shadowColor = UIColor.black.cgColor
        passwordView.layer.shadowOpacity = 0.2
        passwordView.layer.shadowOffset = CGSize(width: 4, height: 4)
        passwordView.layer.shadowRadius = 5
        passwordView.layer.masksToBounds = false
        
        mainView.backgroundColor = getepayYellowColor
        loginBtn.backgroundColor = getepayYellowColor
        SoceityName.text = societyName1
        welcomeLbl.text = "Welcome to \(societyName1)"
      
       imageView.layer.cornerRadius = min(imageView.frame.width, imageView.frame.height) / 2
       
       // imageView.contentMode = .center
        imageView.clipsToBounds = true
    }
    func loginApi(){
        showSpinner_N(onView: view)
        let tag:String = "login"
        let userEmail:String = usernameText.text ?? ""
        let userPass:String = passwordText.text ?? ""
     
        
        print("loginApiReq--->\(tag)-----\(userEmail)------\(userPass)-----\(societyId)")
        
        let parameters: [String: Any] = [
            "tag" : tag,
            "userEmail" : userEmail,
            "userPass"  : userPass,
            "society_id" : societyId
        ]
        print("LoginParam--->\(parameters)")
        var url : String = baseSeverUrl
        WebParamsApiManager.perFormRequest(url: url, params: parameters) {(res, error, errorcode) in
            print(request)
        
            print("loginApiRes----\(res)")
            if error == nil{
                if let obj:NSDictionary =  res as? NSDictionary{
                    print(obj)
                    if let status:Int = obj["success"] as? Int{
                        print(status)
                        if status == 1{
                            self.removeSpinner_N()
                            
                            self.loginResponse = try! JSONDecoder().decode(LoginModal.self, from: WebAPIManager.jsonToString(json: res as Any).data(using: .utf8)!)
                            var loggedRole = self.loginResponse?.loggedRole
                            var userid:Int = (self.loginResponse?.user_id)!
                            var soceityName = self.loginResponse?.society_name
                            print("loggedRole--->\(loggedRole)")
                            print("userid--->\(userid)")
                         //   UserDefaults.standard.set("true", forKey: "isLoggedIn")
                            UserDefaults.standard.set(self.usernameText.text ?? "", forKey: "userEmail")
                            UserDefaults.standard.set(self.passwordText.text ?? "", forKey: "userPass")
                            UserDefaults.standard.set(self.loginResponse?.society_name, forKey: "SoceityName")
                            print("UserLogin-------->\(UserDefaults.standard.set(self.usernameText.text ?? "", forKey: "userEmail"))")
                            UserDefaults.standard.set(loggedRole, forKey: "loggedRole")
                            UserDefaults.standard.set(userid, forKey: "UserID")
                            
                            if loggedRole == "Guard"{
                                let moveVC = self.storyboard?.instantiateViewController(withIdentifier: "GuardLoginController") as! GuardLoginController
                               //  self.tabBarController?.hidesBottomBarWhenPushed = false
                                UserDefaults.standard.set("false", forKey: "isLoggedIn")
                                   self.navigationController?.pushViewController(moveVC, animated: true)
                            }else{
                                let moveVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                                UserDefaults.standard.set("true", forKey: "isLoggedIn")
                                 self.tabBarController?.hidesBottomBarWhenPushed = false
                                   self.navigationController?.pushViewController(moveVC, animated: true)
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
