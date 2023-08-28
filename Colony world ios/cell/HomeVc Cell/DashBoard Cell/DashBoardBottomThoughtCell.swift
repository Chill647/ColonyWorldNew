//
//  DashBoardBottomThoughtCell.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 18/05/23.
//

import UIKit

class DashBoardBottomThoughtCell: UITableViewCell {

    @IBOutlet weak var CellView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        updateScreen()
        // Initialization code
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
