//
//  ListofEventsScreenVC.swift
//  Au Biz Pay
//
//  Created by shayam on 01/10/21.
//  Copyright © 2021 eshiksa. All rights reserved.
//

import UIKit

class ListofEventsScreenVC: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var TopRoundCorner: UIView!
    @IBOutlet weak var CollectionViewData: UICollectionView!
    @IBOutlet weak var lbl_EventName: UILabel!
    var galleryDetailsResponse:GalleryDetailsModal?
    var ImagesList = [Images]()
    var urlImage = ""
    var FolderId = 0
    var Foldertitle = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        GalleryDetailsApi()
      //  UpdateNavigationBar()
        lbl_EventName.text = "Images"
        headerView.backgroundColor = getepayYellowColor
        print("ControllerScreen -> ListofEventsScreenVC")
        TopRoundCorner.clipsToBound = true
        TopRoundCorner.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        TopRoundCorner.layer.cornerRadius = 20
        CollectionViewData.delegate = self
        CollectionViewData.dataSource = self
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
}

extension ListofEventsScreenVC : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("ImagesList.count-->\(ImagesList.count)")
        return ImagesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventListCell", for: indexPath as IndexPath) as! EventListCell

        var ImagesID =   ImagesList[indexPath.row].id ?? 0
         urlImage = "\(imageUrl2)/upload/images/gallery/\(ImagesID).png"
        print("ImageUrl-->\(urlImage)")
    
        let url = URL(string: urlImage ?? "")
        if url != nil {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!)
                DispatchQueue.main.async {
                    if data != nil {
                        cell.Img_Event.image = UIImage(data:data!)
                      
                    }
                }
            }
           
        }
        cell.ImageOuter.layer.cornerRadius = 2
        cell.ImageOuter.layer.shadowColor = UIColor.darkGray.cgColor
        cell.ImageOuter.layer.shadowOpacity = 0.5
        cell.ImageOuter.layer.shadowOffset = .zero
        cell.ImageOuter.layer.shadowRadius = 2
        
        let width = CollectionViewData.frame.width
        let cellWidth = width/3.2
        cell.CellWidth.constant = cellWidth-5
        cell.CellHeight.constant = cellWidth-5
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "GalleryClickController") as? GalleryClickController {
//            let img = greetingsTableModel?.occasionTemplateVoList?[indexPath.row].imagePath ?? ""
//            var path = "\(IMAGEBASEURL)\(img)"
//            path = path.replacingOccurrences(of: " ", with: "%20")
//            vc.imgPath = path
//
            var ImagesID =   ImagesList[indexPath.row].id ?? 0
            var path = "\(imageUrl2)/upload/images/gallery/\(ImagesID).png"
           print("ImageUrl-->\(path)")
            vc.imageURl = path
          self.navigationController?.pushViewController(vc, animated: true)
   
        }
    }
    
    
    func GalleryDetailsApi(){
       // showSpinner_N(onView: view)
        let tag:String = "gallery_folder_content"
        var UserEmail = UserDefaults.standard.string(forKey: "userEmail") ?? ""
        var userPass = UserDefaults.standard.string(forKey: "userPass") ?? ""
        var loggedRole =  UserDefaults.standard.string(forKey: "loggedRole") ?? ""
        let parameters: [String: Any] = [
            "tag" : tag,
            "userEmail" : UserEmail,
            "userPass"  : userPass,
            "society_id" : societyId,
            "loggedRole"  : loggedRole,
            "title"       :   Foldertitle,
            "folder_id"   : FolderId
        ]
        var url : String = baseSeverUrl
        print("GalleryFolderParam---->\(parameters)")
        WebParamsApiManager.perFormRequest(url: url, params: parameters) { [self](res, error, errorcode) in
            print(res)
            if error == nil{
                if let obj:NSDictionary =  res as? NSDictionary{
                    print(obj)
                    if let status:Int = 1 as? Int{
                        print(status)
                        if status == 1{
                      //      self.removeSpinner_N()
                            
                         self.galleryDetailsResponse = try! JSONDecoder().decode(GalleryDetailsModal.self, from: WebAPIManager.jsonToString(json: res as Any).data(using: .utf8)!)
                   
                            if self.galleryDetailsResponse?.images?.count != 0 {
                                self.ImagesList.append(contentsOf: (self.galleryDetailsResponse?.images)!)
                                print("ImagesList-->\(ImagesList)")
                                self.CollectionViewData.reloadData()
                            }else {
                                print("Data is not found!")
                            }
                            
                        }else{
                       
                            if let msg :String = obj["message"] as? String{
                                print(msg)
                            }
                        }
                    }else{
                  
                        if let msg :String = obj["message"] as? String{
                            
                           print(msg)
                        }
                        
                    }
                }else{
                    
                   
                }
            }else{
             print("Something Went Wrong ,pls try again!")
            }
          

        }
      
    }
    
}
