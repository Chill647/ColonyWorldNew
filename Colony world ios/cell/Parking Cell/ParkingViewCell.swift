//
//  ParkingViewCell.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 29/05/23.
//

import UIKit

class ParkingViewCell: UITableViewCell {

    @IBOutlet weak var slotLbl: UILabel!
    @IBOutlet weak var flatNo: UILabel!
    @IBOutlet weak var blockName: UILabel!
    @IBOutlet weak var dataView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        updateScreen()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func updateScreen(){
    
        dataView.layer.cornerRadius = 10
        dataView.layer.shadowColor = UIColor.gray.cgColor
        dataView.layer.shadowOpacity = 0.8
        dataView.layer.shadowOffset = .zero
        dataView.layer.shadowRadius = 5
    }
}
