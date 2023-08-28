//
//  TutorialsController.swift
//  Colony world ios
//
//  Created by Getepay 2022 on 13/04/23.
//

import UIKit
import AVKit
class TutorialsController: UIViewController {
    
    @IBOutlet var mTableView: UITableView!
    @IBOutlet weak var headerColor: UIView!
    var tutorialResponse:TutorialModel?
    var videoList = [Video]()
    var filePath = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TutorialApi()
      //  self.mTableView.reloadData()
        headerColor.backgroundColor = getepayYellowColor
        self.mTableView.delegate = self
        self.mTableView.dataSource = self
        mTableView.register(UINib(nibName: "EventsViewCell", bundle: nil), forCellReuseIdentifier: "EventsViewCell")
    }
    
    func TutorialApi(){
        showSpinner_N(onView: view)
        let tag:String = "getTutorials"
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
        print("TutorialApi-->\(parameters)")
        var url : String = baseSeverUrl
        WebParamsApiManager.perFormRequest(url: url, params: parameters) { [self](res, error, errorcode) in
           
            print("TutorialApiRes--->\(res)")
            if error == nil{
                if let obj:NSDictionary =  res as? NSDictionary{
                    print(obj)
                    if let status:Int = obj["success"] as? Int{
                        print(status)
                        if status == 1{
                            self.removeSpinner_N()
                           self.tutorialResponse = try! JSONDecoder().decode(TutorialModel.self, from: WebAPIManager.jsonToString(json: res as Any).data(using: .utf8)!)
//                            FolderId = self.galleryResponse?.folders[0].folderID ?? 0
//                            Foldertitle = self.galleryResponse?.folders[0].folderName ?? ""

                            if self.tutorialResponse?.videos?.count != 0 {
                                self.videoList.append(contentsOf: (self.tutorialResponse?.videos)!)
                                print("ListCountVideo--->\(videoList.count)")
                                self.mTableView.reloadData()
                            }else {
                                print("Data is not found!")
                            }
                            
                            
                            print("ListCountVideo--->\(videoList.count)")
                            self.mTableView.reloadData()
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
extension TutorialsController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("videoList.count--\(videoList.count)")
        return videoList.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mTableView.dequeueReusableCell(withIdentifier: "EventsViewCell", for: indexPath) as! EventsViewCell

        cell.startDateLbl.text = videoList[indexPath.row].description
        cell.societyLabel.text = videoList[indexPath.row].title
        cell.dateImage.image = UIImage(named: "DescriptionIcon")
        cell.dateImage.contentMode = .scaleAspectFill
        cell.EyeButton.tag = indexPath.row
        cell.EyeButton.addTarget(self, action:  #selector (downloadData),for: .touchUpInside)
        filePath = videoList[indexPath.row].path ?? ""
        return cell 
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }

    @objc func downloadData(){
        if !filePath.isEmpty{
            let videoURL = URL(string: "\(imageUrl2)/\(filePath)")!
            print("videoUrl--->\(videoURL)")
                    let player = AVPlayer(url: videoURL)
                    let playerViewController = AVPlayerViewController()
                    playerViewController.player = player
                    present(playerViewController, animated: true) {
                        player.play()
                    }
           
        }else{
            displayMessage("Download Url Not Found !!")
        }
         
    }
    
}

