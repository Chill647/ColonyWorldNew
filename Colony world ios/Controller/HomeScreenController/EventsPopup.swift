//
//  EventsPopup.swift
//  Colony world ios
//
//  Created by Getepay 2022 on 14/04/23.
//

import UIKit

class EventsPopup: UIViewController {
    @IBOutlet weak var popupLabel: UILabel!
    @IBOutlet weak var Popupview: UIView!
    @IBOutlet weak var InnerPopUpView: UIView!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var mainView: UIView!
    
    var descData = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popupLabel.text = descData
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func okPopupbtn(_ sender: Any) {
        self.dismiss(animated: true,completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          setupView()
      }
      
      override func viewDidLayoutSubviews() {
          super.viewDidLayoutSubviews()
          view.layoutIfNeeded()

          
      }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
       {
           let touch = touches.first
           
           if touch?.view == self.mainView
           {
                
               self.dismiss(animated: true, completion: nil) }
       }
      func setupView(){
          Popupview.layer.cornerRadius = 15
          self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)

      }
}
