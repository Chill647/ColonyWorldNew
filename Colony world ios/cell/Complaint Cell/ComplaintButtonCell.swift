//
//  ComplaintButtonCell.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 23/05/23.
//

import UIKit

class ComplaintButtonCell: UITableViewCell {

    @IBOutlet weak var MyComplaintsLbl: UILabel!
    @IBOutlet weak var Linelbl: UILabel!
    @IBOutlet weak var SubmitBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.MyComplaintsLbl.isHidden = true
//        self.Linelbl.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
