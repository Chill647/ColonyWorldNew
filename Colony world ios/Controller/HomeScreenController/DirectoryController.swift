//
//  DirectoryController.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 20/05/23.
//

import UIKit

class DirectoryController: UIViewController {

    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var cornerView: UIView!
    @IBOutlet var mainView: UIView!
    var nameArraay = ["Sahil","raJ","Vinnit"]
    var selectedIndex = -1
    var isCollapse = false
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mTableView.delegate = self
        self.mTableView.dataSource = self
        updateScreen()
        mTableView.estimatedRowHeight = 243
        mTableView.rowHeight = UITableView.automaticDimension
        mTableView.register(UINib(nibName: "DirectoryCell", bundle: nil), forCellReuseIdentifier: "DirectoryCell")
    }
    
    func updateScreen(){
        cornerView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        mainView.backgroundColor = getepayYellowColor
        
        cornerView.CornerRadious  = 20
    }

    
    
//
}
extension DirectoryController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mTableView.dequeueReusableCell(withIdentifier: "DirectoryCell", for: indexPath) as! DirectoryCell
        cell.titleLbl.text = nameArraay[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if  self.selectedIndex == indexPath.row && isCollapse == true{
           return 243
        }else{
            return 80
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if selectedIndex == indexPath.row{
            if self.isCollapse == false{
                self.isCollapse = true
            }else{
                self.isCollapse = false
            }
        }else{
            isCollapse = true
        }
        self.selectedIndex = indexPath.row
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
