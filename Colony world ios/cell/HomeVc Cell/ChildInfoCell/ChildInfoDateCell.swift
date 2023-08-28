//
//  ChildInfoDateCell.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 05/05/23.
//

import UIKit
protocol DatePickerCellDelegate: AnyObject {
    func datePickerCellValueChanged(date: String)
}
class ChildInfoDateCell: UITableViewCell {
  
    @IBOutlet weak var RequestBtn: UIButton!
    weak var delegate: DatePickerCellDelegate?
    @IBOutlet weak var datepicker: UIDatePicker!
    @IBOutlet weak var GenerateBtn: UIButton!
    var datePicker1 = DateFormatter()
    @IBOutlet weak var reloadView: UIView!
    
    @IBOutlet weak var GuardrequestView: UIView!
    @IBOutlet weak var CallBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        datepicker.locale = .current
        datepicker.date = Date()
        datepicker.preferredDatePickerStyle = .automatic
        datepicker.addTarget(self, action: #selector(dateSelected), for: .valueChanged)
        updateScreen()
    }
    @objc
    func dateSelected(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .medium
        dateFormatter.dateFormat = "yyyy-MM-dd , HH:MM:ss"
       
        let date1 = dateFormatter.string(from: datepicker.date)
        print("datepicker1----\(date1)")
        delegate?.datePickerCellValueChanged(date: date1)
    }

   
    func updateScreen(){
        GuardrequestView.isHidden = true
        GenerateBtn.isHidden = true
        GenerateBtn.backgroundColor = getepayYellowColor
        GenerateBtn.setTitleColor(.white, for: .normal)

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
