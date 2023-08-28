//
//  PaymentHistoryViewController.swift
//  Colony world ios
//
//  Created by Futuretek on 25/01/23.
//

import UIKit

class PaymentHistoryViewController: UIViewController {
    @IBOutlet var mTableView: UITableView!
    @IBOutlet weak var headerColor: UIView!
    var PaymentResponse:PaymentHistoryModal?
    @IBOutlet weak var topView: UIView!
    var PaymentModalist = [PaymentHistory]()
    var buildNo = ""
    override func viewDidLoad() {
        super.viewDidLoad()
      
        headerColor.backgroundColor = getepayYellowColor
        updateScreen()
        PaymentHistoryApi()
        self.mTableView.reloadData()
        self.mTableView.delegate = self
        self.mTableView.dataSource = self
        self.mTableView.register(UINib(nibName: "PaymentHistoryViewCell", bundle: nil), forCellReuseIdentifier: "PaymentHistoryViewCell")
        
    }
    
    func updateScreen(){
        topView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
//        topView.backgroundColor = getepayYellowColor
        
        
    }
   
    func PaymentHistoryApi(){
        showSpinner_N(onView: view)
        let tag:String = "payment_history"
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
        print("PaymentHistoryParam--->\(parameters)")
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
                                
                                self.PaymentResponse = try! JSONDecoder().decode(PaymentHistoryModal.self, from: WebAPIManager.jsonToString(json: res as Any).data(using: .utf8)!)
                                if self.PaymentResponse?.paymentHistory.count != 0 {
                                    self.PaymentModalist.append(contentsOf: (self.PaymentResponse?.paymentHistory)!)
                                    print("PaymentModalist--->\(self.PaymentModalist)")
                                    print(msg.self)
                
                                    self.mTableView.reloadData()
                                } else{
                                    self.removeSpinner_N()
                                     self.displayMessage("Data Not found!")
                                }
                               
//                                self.mTableView.reloadData()
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
                
                
         //   }
            
            
            
        }
        
    }
    func DownlondFromUrl(){

        var k = ""
        
        let urlString = xlsPath+"/reports/payment/invoices/\(buildNo).pdf"
        let url = URL(string: urlString)
        print("urlPaymentHistoryDownload--->\(url)")
        let fileName = String((url!.lastPathComponent)) as NSString
        let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL? ?? URL(string: "")!
        let destinationFileUrl = documentsUrl.appendingPathComponent("\(fileName).xlsx")
        print(fileName)
        let fileURL = URL(string: urlString)
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = URLRequest(url:fileURL!)
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)")
                }
                try? FileManager.default.removeItem(at: destinationFileUrl)
                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                    do {
                        let contents  = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
                        for indexx in 0..<contents.count {
                            if contents[indexx].lastPathComponent == destinationFileUrl.lastPathComponent {
                                let activityViewController = UIActivityViewController(activityItems: [contents[indexx]], applicationActivities: nil)
                                DispatchQueue.main.async {
                                    self.present(activityViewController, animated: true, completion: nil)
                                }
                                
                            }
                        }
                    }
                    catch (let err) {
                        print("error: \(err)")
                    }
                } catch (let writeError) {
                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
                }
            } else {
                print("Error took place while downloading a file. Error description: \(error?.localizedDescription ?? "")")
            }
        }
        task.resume()
        
        
        
    }
    
}
extension PaymentHistoryViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(" PaymentModalist.count---\( PaymentModalist.count)")
        return PaymentModalist.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mTableView.dequeueReusableCell(withIdentifier: "PaymentHistoryViewCell", for: indexPath) as! PaymentHistoryViewCell
        cell.referenceLabel.text = "\(PaymentModalist[indexPath.row].billNumber ?? 0)"
        //cell.maintenanceLabel.text = PaymentModalist[indexPath.row].maintainName
        cell.maintenanceLabel.text = PaymentModalist[indexPath.row].fees_name
        cell.dateLabel.text = PaymentModalist[indexPath.row].billDate
        cell.amountLabel.text = "\(PaymentModalist[indexPath.row].total_paid_amount ?? "")"
        cell.invoiceBtn.addTarget(self, action:  #selector (downloadData),for: .touchUpInside)
        buildNo = "\(PaymentModalist[indexPath.row].billNumber ?? 0)"
     
        return cell
        
    }
    @objc func downloadData(){
        if !buildNo.isEmpty{
            print("FilepathService\(buildNo)")
             DownlondFromUrl()
        }else{
            displayMessage("Download Url Not Found !!")
        }
         
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    
}

