//
//  ChildInfoCell1.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 29/04/23.
//

import UIKit
protocol TextFieldDelegate: AnyObject {
    func textFieldDidEndEditing(cell: UITableViewCell, value: String)
}
class ChildInfoCell1: UITableViewCell {
    weak var delegate: TextFieldDelegate?
    
    @IBOutlet weak var minusBTn: UIButton!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var cellView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    @IBAction func ActionTextFeild(_ sender: UITextField) {
        delegate?.textFieldDidEndEditing(cell: self, value: sender.text ?? "")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
