//
//  ProfileViewCell.swift
//  Colony world ios
//
//  Created by Futuretek on 21/12/22.
//

import UIKit

class ProfileViewCell: UITableViewCell {

    @IBOutlet weak var FullName: UILabel!
    
    @IBOutlet weak var FlatNo: UILabel!
    @IBOutlet weak var BlockAddress: UILabel!
    @IBOutlet weak var Address: UILabel!
    @IBOutlet weak var EmailAddress: UILabel!
    @IBOutlet weak var ContactNo: UILabel!
    @IBOutlet weak var ProfileView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        updateScreen()
    }
    func updateScreen(){
        ProfileView.layer.cornerRadius = 10
        ProfileView.layer.shadowColor = UIColor.gray.cgColor
        ProfileView.layer.shadowOpacity = 0.8
        ProfileView.layer.shadowOffset = .zero
        ProfileView.layer.shadowRadius = 5
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
