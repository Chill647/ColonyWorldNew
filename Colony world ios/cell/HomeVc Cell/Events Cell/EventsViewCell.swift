//
//  EventsViewCell.swift
//  Colony world ios
//
//  Created by Futuretek on 25/01/23.
//

import UIKit

class EventsViewCell: UITableViewCell {
    @IBOutlet var societyImg: UIImageView!
    @IBOutlet var societyLabel: UILabel!
    @IBOutlet var dateImage: UIImageView!
    @IBOutlet var startDateLbl: UILabel!
    @IBOutlet var endDateLbl: UILabel!

   
    @IBOutlet weak var EyeButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
