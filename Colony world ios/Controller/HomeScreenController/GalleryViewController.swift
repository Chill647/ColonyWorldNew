//
//  GalleryViewController.swift
//  Colony world ios
//
//  Created by Futuretek on 21/12/22.
//

import UIKit

//var FolderId = 0
//var title = ""
class GalleryViewController: UIViewController {
//     weak var delegate: GaleryDataPass!
    @IBOutlet var mTableView: UITableView!
    @IBOutlet weak var headerColor: UIView!
    var galleryResponse:GalleryModal?
    var galleryList = [Folder]()
    var FolderId = 0
    var Foldertitle = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        headerColor.backgroundColor = getepayYellowColor
      //  UpdateNavigationBar()
        self.mTableView.delegate = self
        self.mTableView.dataSource = self
        GalleryApi()
        self.mTableView.reloadData()

        
    }
    func GalleryApi(){
        showSpinner_N(onView: view)
        let tag:String = "gallery_folders"
        var UserEmail = UserDefaults.standard.string(forKey: "userEmail") ?? ""
        var userPass = UserDefaults.standard.string(forKey: "userPass") ?? ""
        var loggedRole =  UserDefaults.standard.string(forKey: "loggedRole") ?? ""
        let parameters: [String: Any] = [
            "tag" : tag,
            "userEmail" : UserEmail,
            "userPass"  : userPass,
            "society_id" : societyId,
            "loggedRole"  : loggedRole
           
        ]
        print("GalleryApiParam-->\(parameters)")
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
                           self.galleryResponse = try! JSONDecoder().decode(GalleryModal.self, from: WebAPIManager.jsonToString(json: res as Any).data(using: .utf8)!)
                            if let folders = self.galleryResponse?.folders, folders.count > 0 {
                             FolderId = folders[0].folderID
                            Foldertitle = folders[0].folderName
                            } else {
                                print("epmty list")
                            }
//
                            if self.galleryResponse?.folders.count != 0 {
                                self.galleryList.append(contentsOf: (self.galleryResponse?.folders)!)
                                
                                
                                print("GalleryList--->\(galleryList.count)")
                                self.mTableView.reloadData()
                            }else {
                                print("Data is not found!")
                            }
                            
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
extension GalleryViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return galleryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mTableView.dequeueReusableCell(withIdentifier: "GalleryViewControllerCell", for: indexPath) as! GalleryViewControllerCell
        cell.folderLabel.text = galleryList[indexPath.row].folderName
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let moveVC = self.storyboard?.instantiateViewController(withIdentifier: "ListofEventsScreenVC") as! ListofEventsScreenVC
        moveVC.FolderId = FolderId
        moveVC.Foldertitle = Foldertitle
        self.navigationController?.pushViewController(moveVC, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    
}

