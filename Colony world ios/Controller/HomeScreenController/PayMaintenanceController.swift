//
//  PayMaintenanceController.swift
//  Colony world ios
//
//  Created by Getepay 2022 on 26/12/22.
//

import UIKit

class PayMaintenanceController: UIViewController {

    @IBOutlet weak var mTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mTableView.delegate = self
        self.mTableView.dataSource = self
    }
    

  

}
extension UIViewController:UITableViewDelegate,UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 5
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
    }
    
    
}
