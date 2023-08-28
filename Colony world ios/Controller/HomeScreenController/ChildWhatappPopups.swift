//
//  ChildWhatappPopups.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 10/05/23.
//

import UIKit

class ChildWhatappPopups: UIViewController {

    @IBOutlet weak var UserNameLbl: UILabel!
    @IBOutlet weak var passCode: UILabel!
    @IBOutlet weak var SoceityName: UILabel!
    @IBOutlet weak var flataddresLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var ScreenShotView: UIView!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet var mainView: UIView!
    var date:String?
    var tokenno:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSet()
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layoutIfNeeded()

        
    }
    
    func dataSet(){
        dateLbl.text = date
        flataddresLbl.text = "\(UserDefaults.standard.string(forKey: "blockName") ?? "") Block \(UserDefaults.standard.string(forKey: "flatNo") ?? "") FlatNo"
        print("flataddresLbl--\( flataddresLbl)")
        SoceityName.text = UserDefaults.standard.string(forKey: "SoceityName")
        passCode.text = tokenno

    }
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          setupView()
      }
    
    @IBAction func ShareButton(_ sender: UIButton) {
        let imgss = ScreenShotView.takeScreenshot
        
        let image = imgss()
                // set up activity view controller
        let imageToShare = [ image ]
                let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
                // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]

                // present the view controller
                self.present(activityViewController, animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
       {
           let touch = touches.first
           
           if touch?.view == self.mainView
           {
                
               self.dismiss(animated: true, completion: nil) }
       }
    func setupView(){
    //    Popupview.layer.cornerRadius = 15
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)

    }
}
