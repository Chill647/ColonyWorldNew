//
//  CircularViewCell.swift
//  Colony world ios
//
//  Created by Futuretek on 31/01/23.
//

import UIKit

class CircularViewCell: UITableViewCell {
    @IBOutlet weak var downloadBtn: UIButton!
    @IBOutlet var societyImg: UIImageView!
    @IBOutlet var societyLabel: UILabel!
    @IBOutlet var dateImage: UIImageView!
    @IBOutlet var publishStrDate: UILabel!
    @IBOutlet var publishEndDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
