//
//  ProfileImageViewCell.swift
//  Colony world ios
//
//  Created by Futuretek on 21/12/22.
//

import UIKit

class ProfileImageViewCell: UITableViewCell {

    @IBOutlet var profileImgView: UIImageView!
    @IBOutlet weak var lineView: UIView!
 //   var buttonTouchedClosure : (()->Void)? //closure
    override func awakeFromNib() {
        super.awakeFromNib()
        
       // profileImgView.CornerRadious = 50
//        lineView.borderColor = getepayYellowColor
        
    }
    
  

//        @IBAction func tappedCamera(_ sender: UIButton) {
//            self.buttonTouchedClosure?() //closure execution
//        }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
