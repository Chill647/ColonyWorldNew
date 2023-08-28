//
//  ComplaintTextFeildCell.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 23/05/23.
//

import UIKit
import iOSDropDown
protocol ComplaintDelegate: class {
    func didEnterData(complaintText: String, RegisterText: String,DateTextFeild:String,CategoryTxtFeild:String,DescriptionTextFeild:String)
}

protocol ComplaintRegister: class {
    func Registerdata(RegisterText:String)
}

class ComplaintTextFeildCell: UITableViewCell {
    weak var delegate: ComplaintDelegate?
    weak var delegate1:ComplaintRegister?
    
    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var CategoryView: UIView!
    @IBOutlet weak var complaintView: UIView!
    @IBOutlet weak var complaintTextFeild: DropDown!
    @IBOutlet weak var RegisterTextfeild: DropDown!
    @IBOutlet weak var DateTextFeild: UIDatePicker!
    @IBOutlet weak var CategoryTxtFeild: UITextField!
    @IBOutlet weak var DescriptionTextFeild: UITextField!
    var datePicker1 = DateFormatter()
    var complaintArray = [String]()
    var registerArray = [String]()
    var Register:String?
    override func awakeFromNib() {
        super.awakeFromNib()
        dropDown()
        shadowView()
        DateTextFeild.locale = .current
        DateTextFeild.date = Date()
        DateTextFeild.preferredDatePickerStyle = .automatic
      
    }

    func shadowView(){
        complaintView.layer.cornerRadius = 10
        complaintView.layer.shadowColor = UIColor.gray.cgColor
        complaintView.layer.shadowOpacity = 0.8
        complaintView.layer.shadowOffset = .zero
        complaintView.layer.shadowRadius = 3
        
        CategoryView.layer.cornerRadius = 10
        CategoryView.layer.shadowColor = UIColor.gray.cgColor
        CategoryView.layer.shadowOpacity = 0.8
        CategoryView.layer.shadowOffset = .zero
        CategoryView.layer.shadowRadius = 3
        
        descriptionView.layer.cornerRadius = 10
        descriptionView.layer.shadowColor = UIColor.gray.cgColor
        descriptionView.layer.shadowOpacity = 0.8
        descriptionView.layer.shadowOffset = .zero
        descriptionView.layer.shadowRadius = 3
        
        dateView.layer.cornerRadius = 10
        dateView.layer.shadowColor = UIColor.gray.cgColor
        dateView.layer.shadowOpacity = 0.8
        dateView.layer.shadowOffset = .zero
        dateView.layer.shadowRadius = 3
        
        registerView.layer.cornerRadius = 10
        registerView.layer.shadowColor = UIColor.gray.cgColor
        registerView.layer.shadowOpacity = 0.8
        registerView.layer.shadowOffset = .zero
        registerView.layer.shadowRadius = 3
    }
    
    
    func dropDown(){
        complaintArray = ["Personal","Community"]
        complaintTextFeild.optionArray = complaintArray
        complaintTextFeild.didSelect{(selectedText , index ,id) in
                 self.complaintTextFeild.text = "\(selectedText)"

                 }
        
        registerArray = ["Society Incharge","Treasure","Secretary","Block Incharge","Chairmen"]
        RegisterTextfeild.optionArray = registerArray
        RegisterTextfeild.didSelect{(selectedText , index ,id) in
           self.RegisterTextfeild.text = "\(selectedText)"
            self.Register = "\(selectedText)"
            print("RegisterData--\(self.Register)")
            self.delegate1?.Registerdata(RegisterText:self.Register ?? "" )
            }
    }
    
    @IBAction func TextFeildAction(_ sender: Any) {
     
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .medium
        dateFormatter.dateFormat = "yyyy-MM-dd , HH:MM:ss"
       
        let date1 = dateFormatter.string(from: DateTextFeild.date)
        print("datepicker1----\(date1)")
              let complaint = complaintTextFeild.text ?? ""
          
        print("RegisterData1--\( self.Register)")
               let dateString = date1
               let CategoryTxt = CategoryTxtFeild.text ?? ""
              let DescriptionText = DescriptionTextFeild.text ?? ""
        delegate?.didEnterData(complaintText: complaint, RegisterText:  self.Register ?? "",DateTextFeild:"\(String(describing: dateString))",CategoryTxtFeild:CategoryTxt,DescriptionTextFeild:DescriptionText)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
