//
//  MethodCollection.swift
//  Colony world ios
//
//  Created by Futuretek on 22/12/22.
//

import Foundation
import UIKit
extension UIViewController {
    //MARK: For adding AppIcon && Make NavigationBar transparent !!
    func UpdateNavigationBar() {
//        self.navigationController?.isNavigationBarHidden = false
//
//
//        let imageView = UIImageView(frame: CGRect(x:30 , y:40, width: 50, height: 50))
//        imageView.contentMode = .scaleAspectFit
//        imageView.CornerRadious = 17
//        imageView.backgroundColor = UIColor.white
//        imageView.masksToBound = true
//        //scaleAspectFit
//        let image = UIImage(named: "AppImage")
//        imageView.image = image
// //       let spacer = UIView()
////        let constraint = spacer.widthAnchor.constraint(greaterThanOrEqualToConstant: CGFloat.greatestFiniteMagnitude)
////        constraint.isActive = true
////        constraint.priority = .defaultLow
////        let stack = UIStackView(arrangedSubviews: [imageView,spacer])
////        stack.axis = .horizontal
//
//        navigationItem.titleView = imageView
//        let label = UILabel(frame: CGRect(x: 0, y: 5, width: 20, height: 20))
//        label.font = UIFont(name: "Futura", size: 16)
//        self.navigationItem.title = label.text
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()

        var headerView = UIView()
        let headerImage  = UIImageView(frame: CGRect(x:170 ,y:60,width: 50,height: 50))

        headerImage.layer.cornerRadius = 25
        headerImage.layer.borderColor = UIColor.black.cgColor
        headerImage.layer.borderWidth = 1
        headerImage.contentMode = .center
        
        headerImage.image = UIImage(named: "AppImage")
        headerImage.backgroundColor = UIColor.white
        headerImage.masksToBound = true

        let headerLabel = UILabel(frame: CGRect(x: 160, y: 105, width: 160, height: 80))
        headerLabel.text = "calynx vanalika society"
        headerLabel.font = UIFont(name: "Futura", size: 12)
        headerLabel.contentMode = .center
        headerLabel.textColor = UIColor.white
        headerView = UIView(frame: CGRect(x:0, y: -12, width: 70, height: 20))
        headerView.addSubview(headerImage)
        headerView.addSubview(headerLabel)
        
      //  headerView.contentMode = .top
        view.addSubview(headerView)
        
        view.contentMode = .center
       
    }
    
    
    
}
