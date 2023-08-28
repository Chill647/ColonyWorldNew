//
//  dashboardBannerCell.swift
//  Colony world ios
//
//  Created by Getepay 2022 on 19/12/22.
//

import UIKit

class dashboardBannerCell: UITableViewCell {
    var timer = Timer()
    var counter = 0

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var mCollectionView: UICollectionView!
    let layout = UICollectionViewFlowLayout()
    var BannerResponse:BannerModal?
    var bannerArray = [Datum]()
    let bannerImages = [UIImage(named: "bhaikhata.jpg"),UIImage(named: "bhaikhata.jpg"),UIImage(named: "bhaikhata.jpg")]
    
    var  imgArr = [UIImage(named: "app_logo"),UIImage(named: "app_logo"),UIImage(named: "app_logo")]
    override func awakeFromNib() {
        super.awakeFromNib()
        updateScreen()
        BannerApi ()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 10
        mCollectionView.setCollectionViewLayout(layout, animated: true)
        self.mCollectionView.delegate = self
        self.mCollectionView.dataSource = self
        mCollectionView.register(UINib(nibName: "dashboardCollectionCell", bundle: nil), forCellWithReuseIdentifier: "dashboardCollectionCell")
     self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)

    }
    
    
    func updateScreen(){
        cellView.layer.cornerRadius = 20
        cellView.layer.borderColor = UIColor.gray.cgColor

        cellView.layer.shadowColor = UIColor.gray.cgColor
        cellView.layer.shadowOpacity = 0.8
        cellView.layer.shadowOffset = .zero
        cellView.layer.shadowRadius = 5
    }
    @objc func changeImage() {
        guard mCollectionView.numberOfItems(inSection: 0) > 0 else {
               return
           }
        if bannerArray.count>0{
            if counter < bannerArray.count{
                let index = IndexPath.init(item: counter, section: 0)
                self.mCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
                counter += 1
            }else{
                counter = 0
                let index = IndexPath.init(item: counter, section: 0)
                self.mCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated:  false)
                counter = 1
            }
        }else if imgArr.count>0{
          
//            guard mCollectionView.numberOfItems(inSection: 0) > 0 else {
//                return
//            }
            if counter < imgArr.count{
                let index = IndexPath.init(item: counter, section: 0)
                self.mCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
                counter += 1
            }else{
                counter = 0
                let index = IndexPath.init(item: counter, section: 0)
                self.mCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated:  false)
                counter = 1
            }
        }else{
            print("SomeDAta Found")
       }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    func BannerApi(){
        let tag:String = "adbannerImage"
        let parameters: [String: Any] = [
            "tag" : tag,
            "society_id" :societyId
          
        ]
        print("BannerApiparameters--\(parameters)")
        var url : String = baseSeverUrl
        WebParamsApiManager.perFormRequest(url: url, params: parameters) {(res, error, errorcode) in
          
                print("BannerApi----\(res)")
                if error == nil{
                    if let obj:NSDictionary =  res as? NSDictionary{
                        print(obj)
                        if let status:Int = obj["success"] as? Int{
                            print(status)
                            if status == 1{
                              
                                self.BannerResponse = try! JSONDecoder().decode(BannerModal.self, from: WebAPIManager.jsonToString(json: res as Any).data(using: .utf8)!)
                                if self.BannerResponse?.data.count != 0 {
                                    self.bannerArray.append(contentsOf: (self.BannerResponse?.data)!)
                                    print("BannerApilist--->\(self.bannerArray)")
                                    print(msg.self)
                                    
                                    
                                    self.mCollectionView.reloadData()
                                } else{
                                    //self.removeSpinner_N()
                                }
                                
                            }else{
                               // self.removeSpinner_N()
                                if let msg :String = obj["message"] as? String{
                                   // self.displayMessage(msg)
                                }
                            }
                        }else{
                           // self.removeSpinner_N()
                           // self.displayMessage("Something Went Wrong,Pls Try agian")
                        }
                    }else{
                        //self.removeSpinner_N()
                        //self.displayMessage("Something Went Wrong,Pls Try agian")
                    }
                }else{
                   // self.removeSpinner_N()
                    //self.displayMessage("Something Went Wrong,Pls Try agian")
                }
                
                
            }
            
            
            
        }
    
}
extension dashboardBannerCell: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if bannerArray.count>0
        {
            return bannerArray.count
        }else{
            return imgArr.count
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mCollectionView.dequeueReusableCell(withReuseIdentifier: "dashboardCollectionCell", for: indexPath) as! dashboardCollectionCell
        if bannerArray.count>0{
            let urlImage = "\(imageUrl2)/\(bannerArray[indexPath.row].imagePath)"
           print("BannerUrl-->\(urlImage)")
            let urlString = urlImage.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            if let url = URL(string: urlString){
                cell.bannerImg.downloadedProfileImage(from: url, contentMode: .scaleToFill)

               }
        }else{
                   cell.bannerImg.image = UIImage(named: "\(AppImage)")
            }
   
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//         let collectionwidth =  mCollectionView.bounds.width
//       return CGSize(width: collectionwidth/1, height: collectionwidth/1)
//        return CGSize(width: 300, height: 200)
        
        let widthPerItem = mCollectionView.frame.width  - layout.minimumInteritemSpacing
        return CGSize(width:widthPerItem, height: 200)
    }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
       return 1
     }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         return UIEdgeInsets(top:5,left:5,bottom: 5,right: 5)
     
     
     }
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return 1
     }
    
}
