//
//  CircularDetailsController.swift
//  Colony world ios
//
//  Created by Getepay 2022 on 12/04/23.
//

import UIKit

class CircularDetailsController: UIViewController {
   
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var headerView: UIView!
    var circularID = 0
    var index:Int?
    var circularModel:CircularDetailsModal?
    var urlData = ""
    var path = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        CircularDetailsApi()
        updateScreen ()
        
    }
    func updateScreen (){
        headerView.backgroundColor = getepayYellowColor
    }
 
    @IBAction func DownloadBtn(_ sender: Any) {
  
        urlData = "\(imageUrl2)/upload/circular/\(path)"
        urlData = urlData.replacingOccurrences(of: " ", with: "%20")
        print("circularString---\(urlData)")
        if !urlData.isEmpty{
            DownlondFromUrl()
        }else{
            displayMessage("Download Url Not Found !!")
        }
      
       
    }
 
    func CircularDetailsApi(){
        showSpinner_N(onView: view)
        let tag:String = "circular_details"
        let userEmail:String = UserDefaults.standard.string(forKey: "userEmail") ?? ""
        let userPass:String =  UserDefaults.standard.string(forKey: "userPass") ?? ""
        let loggedRole:String = UserDefaults.standard.string(forKey: "loggedRole") ?? ""
        let parameters: [String: Any] = [
            "tag" : tag,
            "userEmail" : userEmail,
            "userPass"  : userPass,
            "society_id" : societyId,
            "loggedRole"  : loggedRole,
            "circular_id" : circularID,
            "index" :index
        ]
        print("CircularDetailsApiParam-->\(parameters)")
        var url : String = baseSeverUrl
        WebParamsApiManager.perFormRequest(url: url, params: parameters) { [self](res, error, errorcode) in
           
            print(res)
            if error == nil{
                if let obj:NSDictionary =  res as? NSDictionary{
                    print(obj)
                    if let status:Int = 1 as? Int{
                        print(status)
                        if status == 1{
                            self.removeSpinner_N()
                        
                            self.circularModel = try! JSONDecoder().decode(CircularDetailsModal.self, from: WebAPIManager.jsonToString(json: res as Any).data(using: .utf8)!)
                           label.text = circularModel?.circular?.title
                            dateLabel.text = circularModel?.circular?.publishDate
                             path = circularModel?.circular?.cirFile ?? ""
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
    func downloadImageAndSave(urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error downloading image: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsDirectory.appendingPathComponent("image.jpg")
            
            do {
                try data.write(to: fileURL)
                print("Image downloaded and saved successfully")
            } catch {
                print("Error saving image: \(error.localizedDescription)")
            }
        }.resume()
    }
//https://colony.getekart.com/upload/circular/9%20RH%20Logo.png
    
    
    func DownlondFromUrl(){

        var k = ""

        let urlString = urlData
        let url = URL(string: urlString)
        print("urlServiceInvoiceDownload--->\(url)")
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
