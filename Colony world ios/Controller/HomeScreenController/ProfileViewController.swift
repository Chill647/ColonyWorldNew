//
//  ProfileViewController.swift
//  Colony world ios
//
//  Created by Futuretek on 21/12/22.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet var mTableView: UITableView!
    @IBOutlet weak var headerColor: UIView!
    var profileResponse:ProfileModal?
    override func viewDidLoad() {
        super.viewDidLoad()
       // UpdateNavigationBar()
        headerColor.backgroundColor = getepayYellowColor
        self.mTableView.delegate = self
        self.mTableView.dataSource = self
        mTableView.register(UINib(nibName: "ProfileViewCell", bundle: nil), forCellReuseIdentifier: "ProfileViewCell")
        mTableView.register(UINib(nibName: "ProfileImageViewCell", bundle: nil), forCellReuseIdentifier: "ProfileImageViewCell")
    }
}
extension ProfileViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            
            let cell = mTableView.dequeueReusableCell(withIdentifier: "ProfileImageViewCell", for: indexPath) as! ProfileImageViewCell
//            cell.buttonTouchedClosure = { [weak self] in
//                
//                ImagePickerManager().pickImage(self!){ image in
//                    cell.profileImgView.image = image
//                }
//                
//                
//            }
            

            return cell
        } else {
            let cell = mTableView.dequeueReusableCell(withIdentifier: "ProfileViewCell", for: indexPath) as! ProfileViewCell

            
            cell.FullName.text = UserDefaults.standard.string(forKey: "name") ?? "-"
            cell.ContactNo.text = UserDefaults.standard.string(forKey: "Mobileno")  ?? "-"
            cell.EmailAddress.text =  UserDefaults.standard.string(forKey: "UserEmail1")  ?? "-"
            cell.Address.text = UserDefaults.standard.string(forKey: "Address")  ?? "-"
            cell.BlockAddress.text = UserDefaults.standard.string(forKey: "blockName")  ?? "-"
            cell.FlatNo.text = UserDefaults.standard.string(forKey: "flatNo")  ?? "-"
            return cell
        }
        
        return UITableViewCell()
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.section == 0{
            return 250
        }else{
            return 350
        }
    }
}
