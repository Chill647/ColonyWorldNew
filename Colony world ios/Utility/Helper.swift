////
////  Helper.swift
////  Colony world ios
////
////  Created by Asim Getepay 2022 on 17/12/22.
////
//
//import Foundation
//import UIKit
////import NVActivityIndicatorView
//
//
//var grayColor = UIColor(red: 0.235, green: 0.231, blue: 0.247, alpha: 1.0)
//let kApp_Primary_Color = UIColor(red: 70/255, green: 23/255, blue: 133/255, alpha: 1.0)
//let kApp_Secondary_Color = UIColor(red: 0.911, green: 0.160, blue: 0.460, alpha: 1.0)
//let yellowColor = UIColor(red: 252/255, green: 240/255, blue: 204/255, alpha: 1.0)
//
//extension UIView {
//
//    @IBInspectable var CornerRadious: CGFloat{
//        set{
//            layer.cornerRadius = newValue
//            if newValue > 0{
//                layer.masksToBounds = true
//            }else{
//                layer.masksToBounds = false
//            }
//        }
//
//        get{
//            return layer.cornerRadius
//        }
//    }
//
//
//
//
//    @IBInspectable var shadowOffsetWidth: CGFloat{
//        set{
//            layer.shadowOffset.width = newValue
//        }
//
//        get{
//            return layer.shadowOffset.width
//        }
//    }
//
//    @IBInspectable var shadowOffsetHeight: CGFloat{
//        set{
//            layer.shadowOffset.height = newValue
//        }
//
//        get{
//            return layer.shadowOffset.height
//        }
//    }
//
//    @IBInspectable var shadowColor: UIColor{
//        set{
//            layer.shadowColor = newValue.cgColor
//        }
//
//        get{
//            return UIColor(cgColor:layer.shadowColor ?? UIColor.white.cgColor)
//        }
//    }
//
//    @IBInspectable var shadowRadius: CGFloat{
//        set{
//            layer.shadowRadius = newValue
//        }
//
//        get{
//            return layer.shadowRadius
//        }
//    }
//
//    @IBInspectable var shadowOpacity: Float{
//        set{
//            layer.shadowOpacity = newValue
//        }
//
//        get{
//            return layer.shadowOpacity
//        }
//    }
//
//    @IBInspectable var clipsToBound: Bool{
//        set{
//            clipsToBounds = newValue
//        }
//
//        get{
//            return clipsToBounds
//        }
//    }
//
//    @IBInspectable var masksToBound: Bool{
//        set{
//            layer.masksToBounds = newValue
//        }
//
//        get{
//            return layer.masksToBounds
//        }
//    }
//
//    @IBInspectable var path: Bool{
//        set{
//            if path {
//                self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
//            }
//        }
//
//        get{
//            return (self.layer.shadowPath != nil) ? true : false
//        }
//    }
//
//    @IBInspectable var borderWidth: CGFloat{
//        set{
//            layer.borderWidth = newValue
//        }
//
//        get{
//            return layer.borderWidth
//        }
//    }
//
//    @IBInspectable var borderColor: UIColor{
//        set{
//            layer.borderColor = newValue.cgColor
//        }
//
//        get{
//            return UIColor(cgColor:layer.borderColor ?? UIColor.white.cgColor)
//        }
//    }
//
//
//
//    func shake(){
//        let animation = CABasicAnimation(keyPath: "position")
//        animation.duration = 0.07
//        animation.repeatCount = 4
//        animation.autoreverses = true
//        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
//        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
//        self.layer.add(animation, forKey: "position")
//    }
//
//}
//
//extension UITextField{
//    @IBInspectable var placeHolderColor: UIColor? {
//        get {
//            return self.placeHolderColor
//        }
//        set {
//            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
//        }
//    }
//    func underlined(){
//        let border = CALayer()
//        let width = CGFloat(1.0)
//        border.borderColor = UIColor.black.cgColor
//        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
//        border.borderWidth = width
//        self.layer.addSublayer(border)
//        self.layer.masksToBounds = true
//    }
//}
//
//public typealias WaitView = (first: UIView, second: UIView)
//extension UITableView{
//
//
//    func indicatorView() -> UIActivityIndicatorView{
//        var activityIndicatorView = UIActivityIndicatorView()
//        if self.tableFooterView == nil{
//            let indicatorFrame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 40)
//            activityIndicatorView = UIActivityIndicatorView(frame: indicatorFrame)
//            activityIndicatorView.isHidden = false
//            activityIndicatorView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
//            activityIndicatorView.isHidden = true
//            self.tableFooterView = activityIndicatorView
//            return activityIndicatorView
//        }else{
//            return activityIndicatorView
//        }
//    }
//
//
//    func addLoading(_ indexPath:IndexPath, closure: @escaping (() -> Void)){
//        indicatorView().startAnimating()
//        if let lastVisibleIndexPath = self.indexPathsForVisibleRows?.last {
//            if indexPath == lastVisibleIndexPath && indexPath.row == self.numberOfRows(inSection: 0) - 1 {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                    closure()
//                }
//            }
//        }
//        indicatorView().isHidden = false
//    }
//
//
//    func stopLoading(){
//        indicatorView().stopAnimating()
//        indicatorView().isHidden = true
//    }
//
//
//}
//
//
//extension UIViewController{
//    public func displayMessage(title: String?, msg: String?, callback:(()->(Void))? = nil){
//
//        if parent != nil{
//            parent!.displayMessage(title: title, msg: msg, callback: callback)
//            return
//        }
//
//        let alertView:UIAlertController!
//
//        if UIDevice.current.userInterfaceIdiom == .pad{
//            alertView = UIAlertController(title: msg, message: title, preferredStyle: .alert)
//        }
//        else{
//            alertView = UIAlertController(title: msg, message: title, preferredStyle: .actionSheet)
//        }
//
//        let alertAction = UIAlertAction(title: "ok", style: .cancel, handler: { _ in
//            alertView.dismiss(animated: true, completion: nil)
//            callback?()
//        })
//        alertView.addAction(alertAction)
//        present(alertView, animated: true, completion: nil)
//
//    }
//
//
//
////    public func addWaitSpinner()-> WaitView {
////
////        let backView = UIView(frame: view.bounds)
////
////        let indicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50), type: .circleStrokeSpin, color: kApp_Primary_Color)
////        view.addSubview(backView)
////
////
////        backView.addSubview(indicatorView)
////        indicatorView.center = backView.center
////        backView.bringSubviewToFront(indicatorView)
////        indicatorView.startAnimating()
////        backView.alpha = 0.0
////        backView.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
////
////        UIView.animate(withDuration: 0.25, animations: {
////            backView.alpha = 1.0
////        })
////
////        return (backView, indicatorView)
////    }
//
//    public func removeWaitSpinner(waitView: WaitView){
//        UIView.animate(withDuration: 0.25, animations: {
//            waitView.first.alpha = 0.0
//        }, completion: { _ in
//            waitView.second.removeFromSuperview()
//            waitView.first.removeFromSuperview()
//        })
//    }
//
//}
//
//
//extension UIApplication {
//
//    var statusBarView: UIView? {
//        return value(forKey: "statusBar") as? UIView
//    }
//}
//@IBDesignable open class CustomGradientView: UIView {
//
//    @IBInspectable var StartColor: UIColor = .white
//
//    @IBInspectable var EndColor: UIColor = .black
//
//    override open class var layerClass: AnyClass {
//        return CAGradientLayer.classForCoder()
//    }
//
//    public override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//
//    required public init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//
//    open override func awakeFromNib() {
//        let gradientLayer = layer as! CAGradientLayer
//        gradientLayer.colors = [ StartColor.cgColor , EndColor.cgColor ]
//        gradientLayer.startPoint = CGPoint(x: 0.3, y: 0.0)
//        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.05)
//    }
//}
//
//@IBDesignable open class GradientButton: UIButton {
//
//    @IBInspectable var StartColor: UIColor = .white
//
//    @IBInspectable var EndColor: UIColor = .black
//
//    open override class var layerClass : AnyClass{
//        return CAGradientLayer.self
//    }
//
//    required public init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//
//    }
//    public override init(frame: CGRect) {
//        super.init(frame:frame)
//    }
//
//    open override func awakeFromNib() {
//        let thisLayer = layer as! CAGradientLayer
//        thisLayer.colors = [StartColor.cgColor, EndColor.cgColor];
//        thisLayer.startPoint = CGPoint(x: 0.3, y: 0.0)
//        thisLayer.endPoint = CGPoint(x: 1.0, y: 0.05)
//    }
//
//}
//class FileDownloader {
//
//    static func loadFileSync(url: URL, completion: @escaping (String?, Error?) -> Void)
//    {
//        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//
//        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)
//
//        if FileManager().fileExists(atPath: destinationUrl.path)
//        {
//            print("File already exists [\(destinationUrl.path)]")
//            completion(destinationUrl.path, nil)
//        }
//        else if let dataFromURL = NSData(contentsOf: url)
//        {
//            if dataFromURL.write(to: destinationUrl, atomically: true)
//            {
//                print("file saved [\(destinationUrl.path)]")
//                completion(destinationUrl.path, nil)
//            }
//            else
//            {
//                print("error saving file")
//                let error = NSError(domain:"Error saving file", code:1001, userInfo:nil)
//                completion(destinationUrl.path, error)
//            }
//        }
//        else
//        {
//            let error = NSError(domain:"Error downloading file", code:1002, userInfo:nil)
//            completion(destinationUrl.path, error)
//        }
//    }
//
//    static func loadFileAsync(url: URL, completion: @escaping (String?, Error?) -> Void)
//    {
//        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//
//        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)
//
//        if FileManager().fileExists(atPath: destinationUrl.path)
//        {
//            print("File already exists [\(destinationUrl.path)]")
//            completion(destinationUrl.path, nil)
//        }
//        else
//        {
//            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
//            var request = URLRequest(url: url)
//            request.httpMethod = "GET"
//            let task = session.dataTask(with: request, completionHandler:
//                                            {
//                                                data, response, error in
//
//                                                print(data)
//                                                print(response)
//                                                print(error)
//                                                if error == nil
//                                                {
//                                                    if let response = response as? HTTPURLResponse
//                                                    {
//                                                        if response.statusCode == 200
//                                                        {
//                                                            if let data = data
//                                                            {
//                                                                if let _ = try? data.write(to: destinationUrl, options: Data.WritingOptions.atomic)
//                                                                {
//                                                                    completion(destinationUrl.path, error)
//                                                                }
//                                                                else
//                                                                {
//                                                                    completion(destinationUrl.path, error)
//                                                                }
//                                                            }
//                                                            else
//                                                            {
//                                                                completion(destinationUrl.path, error)
//                                                            }
//                                                        }
//                                                    }
//                                                }
//                                                else
//                                                {
//                                                    completion(destinationUrl.path, error)
//                                                }
//                                            })
//            task.resume()
//        }
//    }
//}
//
//
//extension UIImage {
//    func toBase64() -> String? {
//        guard let imageData = self.pngData() else { return nil }
//        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
//    }
//}
import Foundation
import UIKit
//import  CryptoSwift
//import NVActivityIndicatorView
import CommonCrypto
extension UIView {
    
    @IBInspectable var CornerRadious: CGFloat{
        set{
            layer.cornerRadius = newValue
            if newValue > 0{
                layer.masksToBounds = true
            }else{
                layer.masksToBounds = false
            }
        }
        
        get{
            return layer.cornerRadius
        }
    }
    
    
    
    
    @IBInspectable var shadowOffsetWidth: CGFloat{
        set{
            layer.shadowOffset.width = newValue
        }
        
        get{
            return layer.shadowOffset.width
        }
    }
    
    @IBInspectable var shadowOffsetHeight: CGFloat{
        set{
            layer.shadowOffset.height = newValue
        }
        
        get{
            return layer.shadowOffset.height
        }
    }
    
    @IBInspectable var shadowColor: UIColor{
        set{
            layer.shadowColor = newValue.cgColor
        }
        
        get{
            return UIColor(cgColor:layer.shadowColor ?? UIColor.white.cgColor)
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat{
        set{
            layer.shadowRadius = newValue
        }
        
        get{
            return layer.shadowRadius
        }
    }
    
    @IBInspectable var shadowOpacity: Float{
        set{
            layer.shadowOpacity = newValue
        }
        
        get{
            return layer.shadowOpacity
        }
    }
    
    @IBInspectable var clipsToBound: Bool{
        set{
            clipsToBounds = newValue
        }
        
        get{
            return clipsToBounds
        }
    }
    
    @IBInspectable var masksToBound: Bool{
        set{
            layer.masksToBounds = newValue
        }
        
        get{
            return layer.masksToBounds
        }
    }
    
    @IBInspectable var path: Bool{
        set{
            if path {
                self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
            }
        }
        
        get{
            return (self.layer.shadowPath != nil) ? true : false
        }
    }
    
    @IBInspectable var borderWidth: CGFloat{
        set{
            layer.borderWidth = newValue
        }
        
        get{
            return layer.borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor{
        set{
            layer.borderColor = newValue.cgColor
        }
        
        get{
            return UIColor(cgColor:layer.borderColor ?? UIColor.white.cgColor)
        }
    }
    
    
    
    func shake(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
  
    
    
}

extension UIViewController{
    
    public func displayMessage(_ msg: String?, callback:(()->(Void))? = nil){
            DispatchQueue.main.async {
                self.displayMessage(title: nil, msg: msg, callback: callback)
            }
        }
        public func displayMessage(title: String?, msg: String?, callback:(()->(Void))? = nil){
            
            if parent != nil{
                parent!.displayMessage(title: title, msg: msg, callback: callback)
                return
            }
            
            let alertView:UIAlertController!
            
            if UIDevice.current.userInterfaceIdiom == .pad{
                alertView = UIAlertController(title: msg, message: title, preferredStyle: .alert)
            }
            else{
                alertView = UIAlertController(title: msg, message: title, preferredStyle: .actionSheet)
            }
            
            let alertAction = UIAlertAction(title: "ok", style: .cancel, handler: { _ in
                alertView.dismiss(animated: true, completion: nil)
                callback?()
            })
            alertView.addAction(alertAction)
            present(alertView, animated: true, completion: nil)
            
        }
    
    
    public func signatureGeneration(MobileNo:String, params : [String]) -> String {
        printStringsJoinedWithSpaceAfterEach(params: params, mobileno: MobileNo)
    }
    
    public func printStringsJoinedWithSpaceAfterEach(params: [String] , mobileno: String) -> String {
        print("\(mobileno.count) password count")
        var pass : String = ""
        if mobileno.count>20 {
            pass = mobileno
        }else{
            if mobileno == "GetePay@2019"{
                pass = mobileno
            }else {
                pass = mobileno.md5()
                print("md5------12345"+pass)

            }
        }
        var temp = ""
        for value in params {
            temp = temp+""+value
        }
        return hmac(key: pass, data: temp)
    }
    
    
    
    
    public func signatureGenerationVersion(password:String, params : [String]) -> String {
        printStringsJoinedWithSpaceAfterEachVersion(params: params, password: password)
    }
    public func printStringsJoinedWithSpaceAfterEachVersion(params: [String] , password : String) -> String {
        print("\(password.count) password count")
        var pass : String = ""
        pass = password
        var temp = ""
        for value in params {
            temp = temp+""+value
        }
        return hmac(key: pass, data: temp)
    }
    
    
    
    
    
    public func byteToHexString( _ byte : [UInt8]) -> String {
        var str = [String]()
        for i in 0...byte.count - 1{
            let v : Int = Int(byte[i] & 0xff)
            if v < 16 {
                str.append("0")
                str.append(NSString(format: "%2x", v) as String)
            }
            
        }
        
        var newString = ""
        for val in str {
            newString = newString+""+val
        }
        
        // let newString = "\"[\"" + str.joined(separator: "\",\"") + "\"]\""
        
        return newString
    }
    enum HMACAlgorithm {
        case MD5, SHA1, SHA224, SHA256, SHA384, SHA512
        
        func toCCHmacAlgorithm() -> CCHmacAlgorithm {
            var result: Int = 0
            switch self {
            case .MD5:
                result = kCCHmacAlgMD5
            case .SHA1:
                result = kCCHmacAlgSHA1
            case .SHA224:
                result = kCCHmacAlgSHA224
            case .SHA256:
                result = kCCHmacAlgSHA256
            case .SHA384:
                result = kCCHmacAlgSHA384
            case .SHA512:
                result = kCCHmacAlgSHA512
            }
            return CCHmacAlgorithm(result)
        }
        
        func digestLength() -> Int {
            var result: CInt = 0
            switch self {
            case .MD5:
                result = CC_MD5_DIGEST_LENGTH
            case .SHA1:
                result = CC_SHA1_DIGEST_LENGTH
            case .SHA224:
                result = CC_SHA224_DIGEST_LENGTH
            case .SHA256:
                result = CC_SHA256_DIGEST_LENGTH
            case .SHA384:
                result = CC_SHA384_DIGEST_LENGTH
            case .SHA512:
                result = CC_SHA512_DIGEST_LENGTH
            }
            return Int(result)
        }
    }
    
    //    func hmacSha256(string:String, key:String) -> [UInt8] {
    //        var mac = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
    //        if let dataBytes = string.data(using: String.Encoding.utf8) {
    //            if let keyBytes = key.data(using: String.Encoding.utf8) {
    //    CC_SHA512(CCHmacAlgorithm(kCCHmacAlgSHA512),
    //    keyBytes.bytes,
    //    &mac)
    //    }
    //    }
    //
    //    return mac;
    //    }
    func hmac(key: String,data: String) -> String {
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA512), key, key.count, data, data.count, &digest)
        let data = Data(bytes: digest)
        return data.map { String(format: "%02hhx", $0) }.joined()
    }
    
    func sha512Hex( string: String , key : String) -> [UInt8] {
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
        if let data = key.data(using: String.Encoding.utf8) {
            let value = data as NSData
            var p = CC_SHA512(value.bytes, CC_LONG(data.count), &digest)
            // CC_SHA512(value.bytes, CC_LONG(datas.count), &digest)
            //        if let datas = key.data(using: String.Encoding.utf8){
            //
            //            let value = data as NSData
            CC_SHA512(value.bytes, CC_LONG(data.count), &digest)
            //            CC_SHA512(value.bytes, CC_LONG(datas.count), &digest)
            //        }
            
            
        }
        
        let buf = [UInt8](string.utf8)
        
        return digest
    }
    
    
}
var vSpinner : UIView?

extension UIViewController {
    
   
    func showSpinner_N(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        vSpinner = spinnerView
    }
    
    func removeSpinner_N() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
    
    
    func convertToSecureText(originalText: String) -> NSAttributedString {
        let secureText = String(repeating: "*", count: originalText.count)
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 17),
            .foregroundColor: getepayYellowColor
        ]
        
        let attributedString = NSMutableAttributedString(string: secureText, attributes: attributes)
        
        return attributedString
    }
}

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
extension String {
    func md5() -> String {
        let data = Data(utf8) as NSData
        var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(data.bytes, CC_LONG(data.length), &hash)
        return hash.map { String(format: "%02hhx", $0) }.joined()
    }
}
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
    
    
}
extension ProfileViewController{
    
    class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var picker = UIImagePickerController();
        var alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        var viewController: UIViewController?
        var pickImageCallback : ((UIImage) -> ())?;
        
        override init(){
            super.init()
            let cameraAction = UIAlertAction(title: "Camera", style: .default){
                UIAlertAction in
                self.openCamera()
            }
            let galleryAction = UIAlertAction(title: "Gallery", style: .default){
                UIAlertAction in
                self.openGallery()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
                UIAlertAction in
            }
            // Add the actions
            picker.delegate = self
            alert.addAction(cameraAction)
            alert.addAction(galleryAction)
            alert.addAction(cancelAction)
        }
        
        func pickImage(_ viewController: UIViewController, _ callback: @escaping ((UIImage) -> ())) {
            pickImageCallback = callback;
            self.viewController = viewController;
            
            alert.popoverPresentationController?.sourceView = self.viewController!.view
            
            viewController.present(alert, animated: true, completion: nil)
        }
        func openCamera(){
            alert.dismiss(animated: true, completion: nil)
            if(UIImagePickerController .isSourceTypeAvailable(.camera)){
                picker.sourceType = .camera
                self.viewController!.present(picker, animated: true, completion: nil)
            } else {
                let alertWarning = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle:.alert)
                alertWarning.show(alertWarning, sender: nil)
            }
        }
        func openGallery(){
            alert.dismiss(animated: true, completion: nil)
            picker.sourceType = .photoLibrary
            self.viewController!.present(picker, animated: true, completion: nil)
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true, completion: nil)
            let asset = info.description
            print("\(asset) desname")
            guard let image = info[.originalImage] as? UIImage else {
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
            }
            pickImageCallback?(image)
        }
        @objc func imagePickerController(_ picker: UIImagePickerController, pickedImage: UIImage?) {
        }
        
    }
}
extension UIView {
    
    func takeScreenshot() -> UIImage {
        
        // Begin context
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        
        // Draw view in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if (image != nil)
        {
            return image!
        }
        return UIImage()
    }
}

extension UIImage {
    func toBase64() -> String? {
        guard let imageData = self.pngData() else { return nil }
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
}
extension UIImageView {
    func downloadedProfileImage(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
}

extension UISegmentedControl {
    private struct AssociatedKeys {
        static var fontColorKey = "fontColorKey"
        static var fontSizeKey = "fontSizeKey"
    }
    
    @IBInspectable var fontColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.fontColorKey) as? UIColor
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.fontColorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            if let color = newValue {
                let attributes = [NSAttributedString.Key.foregroundColor: color]
                setTitleTextAttributes(attributes, for: .normal)
            }
        }
    }
    
    @IBInspectable var fontSize: CGFloat {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.fontSizeKey) as? CGFloat ?? UIFont.systemFontSize
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.fontSizeKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            let font = UIFont.systemFont(ofSize: newValue)
            let attributes = [NSAttributedString.Key.font: font]
            setTitleTextAttributes(attributes, for: .normal)
        }
    }
}
extension UISegmentedControl {
    func setFontColor(_ color: UIColor, for state: UIControl.State = .normal) {
        let attributes = [NSAttributedString.Key.foregroundColor: color]
        setTitleTextAttributes(attributes, for: state)
    }

    func setFontSize(_ size: CGFloat, for state: UIControl.State = .normal) {
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: size)]
        setTitleTextAttributes(attributes, for: state)
    }
}
