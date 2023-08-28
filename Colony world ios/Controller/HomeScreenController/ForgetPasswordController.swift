//
//  ForgetPasswordController.swift
//  Colony world ios
//
//  Created by Getepay 2022 on 19/12/22.
//

import UIKit

class ForgetPasswordController: UIViewController {
    var forgetResponse:ForgetModal?
    @IBOutlet weak var SumbitBtn: UIButton!
    @IBOutlet weak var forgetTxtFeild: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func SumbitBtnAction(_ sender: Any) {
        ForgetApi()
    }
    
    func ForgetApi(){
        showSpinner_N(onView: view)
        let tag:String = "forgotpswd"
        let userEmail:String = self.forgetTxtFeild.text!
        let society_id:String = societyId
        print("ForgetApiReq--->\(tag)------\(userEmail)-----\(society_id)")

        let parameters: [String: Any] = [
            "tag" : tag,
            "userEmail" : userEmail,
            "society_id" : society_id
        ]
        var url : String = baseSeverUrl
        WebParamsApiManager.perFormRequest(url: url, params: parameters) {(res, error, errorcode) in
         
            print(res)
            if error == nil{
                if let obj:NSDictionary =  res as? NSDictionary{
                    print(obj)
                    if let status:Int = obj["success"] as? Int{
                        print(status)
                        if status == 1{
                            self.removeSpinner_N()
                            
                            self.forgetResponse = try! JSONDecoder().decode(ForgetModal.self, from: WebAPIManager.jsonToString(json: res as Any).data(using: .utf8)!)
                       
                            let moveVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                               self.navigationController?.pushViewController(moveVC, animated: true)
                            self.displayMessage("your Password send to register mobile no.!!")
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
