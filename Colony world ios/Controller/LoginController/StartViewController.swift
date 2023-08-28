//
//  StartViewController.swift
//  Au Biz Pay
//
//  Created by shayam on 16/09/20.
//  Copyright © 2020 eshiksa. All rights reserved.
//

import UIKit
class StartViewController: UIViewController {
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ControllerScreen -> StartViewController")
       
        self.startApp()
       
        NotificationCenter.default.addObserver(self, selector: #selector(startApp), name: NSNotification.Name.init("Logout"), object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc func startApp() {
        var isLoggedIn : String = UserDefaults.standard.string(forKey: "isLoggedIn") ?? ""
        if (isLoggedIn != nil && isLoggedIn == "true"){
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.2) {
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as? SWRevealViewController {
                    self.navigationController?.pushViewController(vc, animated: true)

                }
            }
        }else{
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.2) {
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                    vc.callback = {
                        self.startApp()
                    }
                }
            }
        }
    }

    
  
 
}
