//
//  PaymentWebViewController.swift
//  Colony world ios
//
//  Created by Getepay 2022 on 07/04/23.
//

import UIKit
import WebKit
class PaymentWebViewController: UIViewController {
    var url = ""
    
    @IBOutlet weak var HeaderView: UIView!
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        HeaderView.backgroundColor = getepayYellowColor
        webView.load(URLRequest(url: URL(string: url)!))
        // Do any additional setup after loading the view.
    }
    

}
