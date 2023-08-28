//
//  DirectoryCell.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 20/05/23.
//

import UIKit

class DirectoryCell: UITableViewCell {

    @IBOutlet weak var contactlbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var expandView: UIView!
    @IBOutlet weak var topView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        updateScreen()
    }
    func updateScreen(){

        
        expandView.layer.cornerRadius = 10
        expandView.layer.shadowColor = UIColor.gray.cgColor
        expandView.layer.shadowOpacity = 0.8
        expandView.layer.shadowOffset = .zero
        expandView.layer.shadowRadius = 5
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
