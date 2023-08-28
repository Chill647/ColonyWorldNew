//
//  ChilfInfoLogCell.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 05/05/23.
//

import UIKit
import iOSDropDown

protocol ApprovedDropDown: class {
    func ApprovedData(approvedStatus:String)
}

class ChilfInfoLogCell: UITableViewCell {
    @IBOutlet weak var remarkButton: UIButton!
    weak var delegate:ApprovedDropDown?

    @IBOutlet weak var dropDornbtn: UIButton!
    @IBOutlet weak var Status: UILabel!
    @IBOutlet weak var remarkTxtFeild: DropDown!
    @IBOutlet weak var verifyBtn: UIButton!
    @IBOutlet weak var Appicon: UIImageView!
    
    @IBOutlet weak var RemarkView: UIView!
    @IBOutlet weak var VisitTokenLbel: UILabel!
    @IBOutlet weak var EyeBtn: UIButton!
    @IBOutlet weak var messageBtn: UIButton!
    @IBOutlet weak var WhatappBtn: UIButton!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var ChildCount: UILabel!
    @IBOutlet weak var Time: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var mainView: UIView!
    var isCheck = false
    var DropDownArray = [String]()
    override func awakeFromNib() {
        super.awakeFromNib()
        updateScreen()
       
         Appicon.image = UIImage(named: "\(AppImage)")
        DropDownArray = ["Approved on call","Approved with SMS code"]
        self.remarkTxtFeild.optionArray = DropDownArray
        self.remarkTxtFeild.didSelect{(selectedText , index ,id) in
            self.remarkTxtFeild.text = "\(selectedText)"
            self.delegate?.ApprovedData(approvedStatus:self.remarkTxtFeild.text ?? "" )
           self.RemarkView.isHidden = true
            self.VisitTokenLbel.isHidden = false
            self.VisitTokenLbel.text = "Visitor Remark: \(selectedText)"
           
            }
    }
    func updateScreen(){
       
        RemarkView.isHidden = true
        verifyBtn.isHidden = true
        VisitTokenLbel.isHidden = true
        messageView.isHidden = true
        mainView.layer.cornerRadius = 10
        mainView.layer.shadowColor = UIColor.gray.cgColor
        mainView.layer.shadowOpacity = 0.8
        mainView.layer.shadowOffset = .zero
        mainView.layer.shadowRadius = 5
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
