//
//  VistorCell2.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 16/05/23.
//

import UIKit
protocol VistorCountPass: AnyObject {
    func textFieldDidEndEditing(cell: UITableViewCell, value: String)
}
class VistorCell2: UITableViewCell {
    weak var delegate: VistorCountPass?
   
    @IBOutlet weak var TextFeildLbl: UITextField!
    @IBOutlet weak var placeHolderlabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
       
    }
    
    @IBAction func ActionTextFeild(_ sender: UITextField) {
        print("CellCount---\(sender.text ?? "")")
        delegate?.textFieldDidEndEditing(cell: self, value: sender.text ?? "")
    }
    
  

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
