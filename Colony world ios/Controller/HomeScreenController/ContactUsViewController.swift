//
//  ContactUsViewController.swift
//  Colony world ios
//
//  Created by Getepay 2022 on 28/01/23.
//

import UIKit
import MessageUI
class ContactUsViewController: UIViewController,MFMailComposeViewControllerDelegate {
    var supportEmail = ""
    var contact = ""
    var contactList = [String]()
    
    
    @IBOutlet weak var header: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateScreen()
        
        supportEmail = UserDefaults.standard.string(forKey: "Email") ?? "support1@eshiksa.com"
        contactList = UserDefaults.standard.object(forKey: "contactList") as! [String]
        print("contactList--\(contactList)")
        
        if contactList != nil && contactList.count>0{
            contact = contactList[Int.random(in: 0..<contactList.count)] ?? ""
            print("contactNo-->\(contact)")
        }else{
            contact = "0"
        }
   
    }
    func updateScreen(){
        header.backgroundColor = getepayYellowColor
    }
    @IBAction func onCallUsClick(){
        if contact != "0" {
            let number : Int = Int(contact) ?? 0
          if let url = URL(string: "tel://\(number)") {
              UIApplication.shared.openURL(url)
          }
        }
       
    }
    @IBAction func onEmailUsClick(){
           let mailComposeViewController = configureMailComposer()
               if MFMailComposeViewController.canSendMail(){
                   self.present(mailComposeViewController, animated: true, completion: nil)
               }else{
                   print("Can't send email")
               }
           }
           func configureMailComposer() -> MFMailComposeViewController{
               let mailComposeVC = MFMailComposeViewController()
               mailComposeVC.mailComposeDelegate = self
              mailComposeVC.setToRecipients([supportEmail])
               mailComposeVC.setSubject("")
               mailComposeVC.setMessageBody("", isHTML: false)
               return mailComposeVC
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

}
