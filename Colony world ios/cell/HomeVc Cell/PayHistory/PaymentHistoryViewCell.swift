//
//  PaymentHistoryViewCell.swift
//  Colony world ios
//
//  Created by Futuretek on 25/01/23.
//

import UIKit

class PaymentHistoryViewCell: UITableViewCell {
    @IBOutlet var referenceImg: UIImageView!
    @IBOutlet var referenceLabel: UILabel!
    @IBOutlet var maintenanceImg: UIImageView!
    @IBOutlet var maintenanceLabel: UILabel!
    @IBOutlet var dateImg: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var amountImg: UIImageView!
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet weak var invoiceBtn: UIButton!
    
    @IBOutlet weak var maintenaceLblHeight2: NSLayoutConstraint!
    @IBOutlet weak var maintenanceLblHeight: NSLayoutConstraint!
    @IBOutlet weak var maintenaceHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        maintenaceLblHeight2.constant = 0
//        maintenanceLblHeight.constant = 0
//        maintenaceHeight.constant = 0
    }
    func updateScreen(){
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
