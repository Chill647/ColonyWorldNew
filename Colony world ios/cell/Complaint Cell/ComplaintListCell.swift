//
//  ComplaintListCell.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 23/05/23.
//

import UIKit
import iOSDropDown


protocol StatusDelegate: class {
    func didEnterData(StatusText: String)
}
class ComplaintListCell: UITableViewCell {
    @IBOutlet weak var complaintNoLbl: UILabel!
    @IBOutlet weak var CategoryLbl: UILabel!
    @IBOutlet weak var ReportedOnlbl: UILabel!
    @IBOutlet weak var ClosedOnLbl: UILabel!
    
    @IBOutlet weak var statusLbl: UILabel!
    weak var delegate:StatusDelegate?
    @IBOutlet weak var status: DropDown!
    var statusArray = [String]()
    @IBOutlet weak var shadowView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        updateScreen ()
        statusArray = ["Open","Closed"]
        status.optionArray = statusArray
        status.didSelect{(selectedText , index ,id) in
                 self.status.text = "\(selectedText)"
            print("status--\(self.status)")
            self.delegate?.didEnterData(StatusText:self.status.text ?? "" )
            }
   
    }

    
    func updateScreen (){
        
        shadowView.layer.cornerRadius = 10
        shadowView.layer.shadowColor = UIColor.gray.cgColor
        shadowView.layer.shadowOpacity = 0.8
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
