//
//  SideMenu.swift
//  Colony world ios
//
//  Created by Getepay 2022 on 23/12/22.
//

import Foundation
import UIKit
protocol MenuControllerDelegate: class{
    func didSelectMenuItem(named: SideMenuItem)
}

enum SideMenuItem:String,CaseIterable{
     case Dashboard = "Dashboard"
     case Profile = "Profile"
     case PayNow = "Pay Now"
     case History = "History"
     case ChildSecurity = "Child Security"
     case Tutorial = "Tutorial"
     case Gallery = "Gallery"
     case Circular = "Circular"
     case Event = "Event"
     case Support = "Support"
     case Logout = "Logout"
  
    
}




class MenuController:UITableViewController{
    
  weak var delegate:MenuControllerDelegate?
    
    private let menuItems: [SideMenuItem]
    
    init(with menuItems: [SideMenuItem]){
        self.menuItems = menuItems
        super.init(nibName: nil, bundle: nil)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem!.title = "Back"
        self.tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        view.backgroundColor = .white
      
        
    }
   
   
    override func viewDidAppear(_ animated: Bool) {
  
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
   override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
       var image = AppImage
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
       let headerImage  = UIImageView(frame: CGRect(x:70 ,y:0,width: 110, height:110))
        headerImage.layer.cornerRadius = 55
       headerImage.layer.borderColor = UIColor.lightGray.cgColor
         headerImage.layer.borderWidth = 1
      headerImage.image = UIImage(named: "\(image)")
       headerImage.contentMode = .scaleAspectFit
//       let headerImage1  = UIImageView(frame: CGRect(x:30,y:25,width: 60, height:60))
//      var image = AppImage
//      headerImage1.image = UIImage(named: "\(image)")
//       headerImage1.contentMode = .scaleAspectFill
       
       
       let headerLabel = UILabel(frame: CGRect(x: 73, y: 95, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
       headerLabel.text = ""
        headerLabel.font = UIFont(name: "Futura", size: 16)
        headerLabel.textColor = UIColor.black
       
       let headerLabel1 = UILabel(frame: CGRect(x: 40, y: 110, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
      //UserDefaults.standard.string(forKey: "name")
       headerLabel1.textAlignment = .center
       //
         headerLabel1.text = UserDefaults.standard.string(forKey: "name")
       
        headerLabel1.font = UIFont(name: "Futura", size: 16)
        headerLabel1.textColor = UIColor.black
       
       let headerLabelLine = UIView(frame: CGRect(x: 10, y: 140, width: 220, height:2))
       headerLabelLine.backgroundColor = UIColor.black
       
       
              
      //  headerLabel.text = self.tableView(self.table_SideMenuList, titleForHeaderInSection: section)
      // headerImage1.sizeToFit()
       headerLabel.sizeToFit()
       headerLabel1.sizeToFit()
       headerLabelLine.sizeToFit()
      // headerImage.sizeToFit()
       
      //headerImage.addSubview(headerImage1)
       headerView.addSubview(headerImage)
        headerView.addSubview(headerLabel)
       headerView.addSubview(headerLabel1)
       headerView.addSubview(headerLabelLine)
        return headerView
    }
    
    
    override  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row].rawValue
        cell.textLabel?.textColor = .black
        cell.backgroundColor = .white
        cell.contentView.backgroundColor = .white
        
//        cell.imageView?.CornerRadious = 7.5
//        cell.imageView?.borderWidth = 1
//        cell.contentMode = .center
//        cell.imageView?.borderColor  = UIColor.black
        
        switch indexPath.row{
        case 0:
            cell.imageView?.image = UIImage(named:"DashboardSide")
        case 1:
            cell.imageView?.image = UIImage(named: "profileSide")
        case 2:
            cell.imageView?.image = UIImage(named: "PayMaintenanceSide")
        case 3:
            cell.imageView?.image = UIImage(named: "PayHistorySide")
        case 4:
            cell.imageView?.image = UIImage(named: "Visitiors")
        case 5:
            cell.imageView?.image = UIImage(named: "Visitiors")
        case 6:
            cell.imageView?.image = UIImage(named: "GallerySide")
        case 7:
            cell.imageView?.image = UIImage(named: "CircularSide")
        case 8:
            cell.imageView?.image = UIImage(named: "EventSide")
        case 9:
            cell.imageView?.image = UIImage(named: "SupportDrawer")
        case 10:
            cell.imageView?.image = UIImage(named: "LogoutSide")

        default:
         break
        }
        
        return cell
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//
//        let selectedItem = menuItems[indexPath.row]
//        delegate?.didSelectMenuItem(named: selectedItem)
        let transition: CATransition = CATransition()
       transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.dismiss(animated: false) { [self] in
         if "\(self.menuItems[indexPath.row])" != "Dashboard" {
                let selectedItem = self.menuItems[indexPath.row]
                  delegate?.didSelectMenuItem(named: selectedItem)
           }
        }
    }
  
}

//let transition: CATransition = CATransition()
//transition.duration = 0.3
//transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//transition.type = CATransitionType.push
//transition.subtype = CATransitionSubtype.fromRight
//self.dismiss(animated: false) {
//    if "\(self.MenuRowData[indexPath.section][indexPath.row] ?? "")" != "Home" {
//        self.delegate.navigateFromSideMenu(indexVal: "\(self.MenuRowData[indexPath.section][indexPath.row] ?? "")")
//    }
//}
