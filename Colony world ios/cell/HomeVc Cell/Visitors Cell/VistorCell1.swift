//
//  VistorCell1.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 16/05/23.
//

import UIKit
protocol VistorNamePass: AnyObject {
    func textFieldDidEndEditing(cell: UITableViewCell, name: String)
}
class VistorCell1: UITableViewCell {
    weak var delegate: VistorNamePass?
    
    @IBOutlet weak var VistorInfoLbl: UILabel!
    @IBOutlet weak var VisitorPlaceholderLbl: UILabel!
    @IBOutlet weak var VistorTextFeild: UITextField!
    @IBOutlet weak var visitorHeight: NSLayoutConstraint!
    @IBOutlet weak var VisitorLbl: UILabel!
    @IBOutlet weak var HouseHoldBtn: UIButton!
    @IBOutlet weak var VisitorsBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
      VisitorLbl.isHidden = true
        updateScreen()
    }
    func updateScreen(){
       // visitorHeight.constant = 0
        VisitorsBtn.setImage(UIImage.init(named: "uncheckedRadio"), for: .normal)
        VisitorsBtn.setImage(UIImage.init(named: "checkedRadio"), for: .selected)
        HouseHoldBtn.setImage(UIImage.init(named: "uncheckedRadio"), for: .normal)
        HouseHoldBtn.setImage(UIImage.init(named: "checkedRadio"), for: .selected)
        
        VisitorsBtn.setTitleColor(UIColor.gray, for: .disabled)
        HouseHoldBtn.setTitleColor(UIColor.gray, for: .disabled)
        
        
    }
    @IBAction func ActionTextFeild(_ sender: UITextField) {
        delegate?.textFieldDidEndEditing(cell: self, name: sender.text ?? "")
    }
       
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
