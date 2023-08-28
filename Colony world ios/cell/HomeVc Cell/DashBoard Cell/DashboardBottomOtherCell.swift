//
//  DashboardBottomOtherCell.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 18/05/23.
//

import UIKit

protocol CustomTableViewCellDelegate2:class {
    func passTheCurrent2(tableIndex: Int, collectionViewIndex: Int)
}

class DashboardBottomOtherCell: UITableViewCell {
    var selectedData:String = ""
    var rowNumber:Int = 0
    var list = ["Profile","gallery","DashBoard","Logout","circular","Event"]
    
    
    @IBOutlet weak var CellView: UIView!
    weak var delegate2 : CustomTableViewCellDelegate2?
   // let bannerImages = [UIImage(named: "ProfileDrawer"),UIImage(named: "GalleryDrawer"),UIImage(named: "PayDrawer"),UIImage(named: "EventDrawer"),UIImage(named: "PayHistoryDrawer"),UIImage(named: "CircularDrawer")]
    let bannerImages = [UIImage(named: "ParkingNew"),UIImage(named: "VisitorNew"),UIImage(named: "ChildNew"),UIImage(named: "PayHIstoryNew")]
//    let bannerLabel = ["Profile","Gallery","Pay Now","Events","History","Circular"]
    let bannerLabel = ["Parking","Visitor","Child","Payment History"]
    @IBOutlet weak var mCollectionView: UICollectionView!
    let layout = UICollectionViewFlowLayout()
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    override func awakeFromNib() {
        super.awakeFromNib()
        updateScreen()
        layout.scrollDirection = .horizontal //.horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        mCollectionView.setCollectionViewLayout(layout, animated: true)
        self.mCollectionView.delegate = self
        self.mCollectionView.dataSource = self
        mCollectionView.register(UINib(nibName: "dashBoardCollectionBottomCell", bundle: nil), forCellWithReuseIdentifier: "dashBoardCollectionBottomCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateScreen(){
        CellView.layer.cornerRadius = 10
        CellView.layer.borderColor = UIColor.gray.cgColor

        CellView.layer.shadowColor = UIColor.gray.cgColor
        CellView.layer.shadowOpacity = 0.8
        CellView.layer.shadowOffset = .zero
        CellView.layer.shadowRadius = 5
        

  }
    
    
}
extension DashboardBottomOtherCell:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mCollectionView.dequeueReusableCell(withReuseIdentifier: "dashBoardCollectionBottomCell", for: indexPath) as! dashBoardCollectionBottomCell
        
        cell.CollectionLabel.text = bannerLabel[indexPath.row]
        cell.CollectionImg.image = bannerImages[indexPath.row]
        if indexPath.item == 0{
            cell.InnerView.backgroundColor =  hexStringToUIColor(hex: "#02D0FA")
        }else if indexPath.item == 1{
            cell.InnerView.backgroundColor = hexStringToUIColor(hex: "#8180FB")
        }else if indexPath.item == 2{
            cell.InnerView.backgroundColor = hexStringToUIColor(hex: "#9BD14B")
        }else if indexPath.item == 3{
            cell.InnerView.backgroundColor = hexStringToUIColor(hex: "#FF894B")
        }
        return cell
    }
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if let del = self.delegate2
          {
              del.passTheCurrent2(tableIndex: 0, collectionViewIndex: indexPath.item)
           
          }
      }
    


}
extension DashboardBottomOtherCell:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
//        let widthPerItem = mCollectionView.frame.width / 4 - layout.minimumInteritemSpacing
//        print("widthPerItem--\(widthPerItem)")
//        return CGSize(width:widthPerItem, height: 90)
        let width = collectionView.bounds.width / 4
           let height = width
           return CGSize(width: width + 1, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        return 2
   }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
   }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top:5,left:2,bottom: 0,right: 2)
    }
    
    
}
