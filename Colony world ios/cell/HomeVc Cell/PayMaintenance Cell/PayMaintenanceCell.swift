//
//  PayMaintenanceCell.swift
//  Colony world ios
//
//  Created by Getepay 2022 on 18/03/23.
//

import UIKit

class PayMaintenanceCell: UITableViewCell {
  
    @IBOutlet weak var checkImage: UIImageView!
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var Checkbutton: UIButton!
    @IBOutlet weak var DueDateLbl: UILabel!
    @IBOutlet weak var maintenanceCostLbl: UILabel!
    @IBOutlet weak var periodLbl: UILabel!
    var isCheck = false
    var isNil = true
    override func awakeFromNib() {
        super.awakeFromNib()
        updateScreen()
        // Initialization code
    }

    func updateScreen(){
        viewMain.layer.cornerRadius = 10
        viewMain.layer.shadowColor = UIColor.gray.cgColor
        viewMain.layer.shadowOpacity = 0.8
        viewMain.layer.shadowOffset = .zero
        viewMain.layer.shadowRadius = 5
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
