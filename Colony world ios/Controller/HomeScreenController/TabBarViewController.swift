//
//  TabBarViewController.swift
//  Au Biz Pay
//
//  Created by shayam on 19/10/20.
//  Copyright © 2020 eshiksa. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
       // self.tabBar.isTranslucent = false
       self.tabBar.backgroundColor = getepayYellowColor
        self.tabBar.CornerRadious = 20
      
      
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}
//getepayYellowColor
