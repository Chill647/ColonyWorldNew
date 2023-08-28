//
//  SectionHeaderCell.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 29/05/23.
//

import UIKit

class SectionHeaderCell: UITableViewCell {
    @IBOutlet weak var expandButton: UIButton!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        upadateScreen()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func upadateScreen(){
                topView.layer.cornerRadius = 10
                topView.layer.shadowColor = UIColor.gray.cgColor
                topView.layer.shadowOpacity = 0.8
                topView.layer.shadowOffset = .zero
                topView.layer.shadowRadius = 5
    }
}
