//
//  UnplannedVistorCell1.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 16/05/23.
//

import UIKit

class UnplannedVistorCell1: UITableViewCell {

    @IBOutlet weak var UnplanedLblheight: NSLayoutConstraint!
    @IBOutlet weak var IconImage: UIImageView!
    @IBOutlet weak var visitorlbl: UILabel!
    @IBOutlet weak var RefreshBtn: UIButton!
    @IBOutlet weak var UnplannedLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        IconImage.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
