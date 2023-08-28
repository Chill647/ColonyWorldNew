//
//  PayOptionController.swift
//  Colony world ios
//
//  Created by Getepay 2022 on 02/02/23.
//

import UIKit

class PayOptionController: UIViewController {
    
    @IBOutlet weak var PayNowBtn: UIButton!
    @IBOutlet weak var creditBtn: UIButton!
    @IBOutlet weak var DebitBtn: UIButton!
    @IBOutlet weak var Netbanking: UIButton!
    @IBOutlet weak var UpiBtn: UIButton!
    @IBOutlet weak var headerView: UIView!
    var payResponse:PayOptionModal?
    var PaymentID = [Int]()
    var amount = 0
    var stringData = ""
    var url = ""
    var paymentMode = ""
    var feesID = [Int]()
    var FeesString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        stringData = PaymentID.map { String($0) }.joined(separator: ",")
        print("stringData--\(stringData)")
        
        FeesString = feesID.map { String($0) }.joined(separator: ",")
        print("FeesString--\(FeesString)")
       // UpdateNavigationBar()
        updateScreen()
        radioBtn()
        PayoptionApi()
        
       
    }
    
    @IBAction func payNowAction(_ sender: Any) {
        var UserId = UserDefaults.standard.string(forKey: "UserID") ?? ""
        var PgURl = "\(payResponse?.scPGlink ?? "")&mdd=\(paymentMode)&amount=\(amount)&txnid=\(payResponse?.txnid ?? "")&mode\(payResponse?.mode ?? 0)&society_id=\(societyId)&user_id=\(UserId)&payment_check=\(FeesString)"
        print(PgURl)
        let newString = PgURl.replacingOccurrences(of: "paymentPay", with: "paymentPayMobile")
            print(newString)
        
                let moveVC = self.storyboard?.instantiateViewController(withIdentifier: "PaymentWebViewController") as! PaymentWebViewController
                   moveVC.url = newString
                   self.navigationController?.pushViewController(moveVC, animated: true)
    }
    func updateScreen(){
        PayNowBtn.backgroundColor = getepayYellowColor
        headerView.backgroundColor = getepayYellowColor
       // UpdateNavigationBar()
    }
    func radioBtn(){
        creditBtn.setImage(UIImage.init(named: "uncheckedRadio"), for: .normal)
        creditBtn.setImage(UIImage.init(named: "checkedRadio"), for: .selected)
        DebitBtn.setImage(UIImage.init(named: "uncheckedRadio"), for: .normal)
        DebitBtn.setImage(UIImage.init(named: "checkedRadio"), for: .selected)
        Netbanking.setImage(UIImage.init(named: "uncheckedRadio"), for: .normal)
        Netbanking.setImage(UIImage.init(named: "checkedRadio"), for: .selected)
        UpiBtn.setImage(UIImage.init(named: "uncheckedRadio"), for: .normal)
        UpiBtn.setImage(UIImage.init(named: "checkedRadio"), for: .selected)
    }
    
    @IBAction func SelectAction(_ sender: UIButton) {
        if sender == creditBtn {
            paymentMode = "CC"
            creditBtn.isSelected = true
            DebitBtn.isSelected = false
            Netbanking.isSelected = false
            UpiBtn.isSelected = false
        } else if sender == DebitBtn {
            paymentMode = "DC"
            creditBtn.isSelected = false
            DebitBtn.isSelected = true
            Netbanking.isSelected = false
            UpiBtn.isSelected = false
        }else if sender == Netbanking {
            paymentMode = "NB"
            creditBtn.isSelected = false
            DebitBtn.isSelected = false
            Netbanking.isSelected = true
            UpiBtn.isSelected = false
        }else if sender == UpiBtn {
            paymentMode = "UP"
            creditBtn.isSelected = false
            DebitBtn.isSelected = false
            Netbanking.isSelected = false
            UpiBtn.isSelected = true
        }
    }
    
    func PayoptionApi(){
        let tag:String = "pg_var"
        let userEmail:String = UserDefaults.standard.string(forKey: "userEmail") ?? ""
        let userPass:String =  UserDefaults.standard.string(forKey: "userPass") ?? ""
        let loggedRole:String = UserDefaults.standard.string(forKey: "loggedRole") ?? ""
        let parameters: [String: Any] = [
            "tag" : tag,
            "userEmail" : userEmail,
            "userPass"  : userPass,
            "society_id" : societyId,
            "loggedRole": loggedRole
        ]
        print("PayoptionApiParam--->\(parameters)")
        var url : String = baseSeverUrl
        WebParamsApiManager.perFormRequest(url: url, params: parameters) { [self](res, error, errorcode) in
            
            print("PayoptionApi--->\(res)")
            if error == nil{
                if let obj:NSDictionary =  res as? NSDictionary{
                    print(obj)
                    if let status:Int = 1 as? Int{
                        print(status)
                        
                if status == 1{
                            
                            self.removeSpinner_N()
                            
                    self.payResponse = try! JSONDecoder().decode(PayOptionModal.self, from: WebAPIManager.jsonToString(json: res as Any).data(using: .utf8)!)
                            
                    print("paymaintenaceResponse--->\(self.payResponse)")
                   
                    AddPgDataApi(payResponse?.txnid ?? "", payResponse?.pgName ?? "" , payResponse?.product ?? "",payResponse?.mode ?? 0)
                            
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
    
    
    
    func AddPgDataApi(_ txnId:String,_ gateway:String,_ product:String,_ mode:Int){
        let tag:String = "addT_PGdata"
        let userEmail:String = UserDefaults.standard.string(forKey: "userEmail") ?? ""
        let userPass:String =  UserDefaults.standard.string(forKey: "userPass") ?? ""
        let loggedRole:String = UserDefaults.standard.string(forKey: "loggedRole") ?? ""
        let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
        let mobileNo = UserDefaults.standard.string(forKey: "Mobileno") ?? ""
        let userName = UserDefaults.standard.string(forKey: "name") ?? ""
        
        var udf1 = "\(userID)%\(stringData)%\(amount)"
        print("udf1--\(udf1)")
       
        let parameters: [String: Any] = [
            "tag" : tag,
            "udf2" : userEmail,
            "udf3"  : mobileNo,
            "udf4" : userName,
            "udf5": "",
            "society_id":societyId,
            "userEmail": userEmail,
            "userPass":userPass,
            "loggedRole":loggedRole,
            "udf1": udf1,
            "txnid":txnId,
            "gateway":gateway,
            "mode":mode,
            "product":product
            
            
            
        ]
        print("AddPgDataApi--->\(parameters)")
        var url : String = baseSeverUrl
        WebParamsApiManager.perFormRequest(url: url, params: parameters) {(res, error, errorcode) in
            
            print("PayoptionApi--->\(res)")
            if error == nil{
                if let obj:NSDictionary =  res as? NSDictionary{
                    print(obj)
                    if let status:Int = obj["success"]  as? Int{
                        print(status)
                        
                if status == 1{
                            
                            self.removeSpinner_N()
                            
                    url = self.payResponse?.scPGlink ?? ""
                            
                            
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
