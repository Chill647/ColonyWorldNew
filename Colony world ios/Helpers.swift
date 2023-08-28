//
//  Helpers.swift
//  Colony world ios
//
//  Created by Getepay 2022 on 19/12/22.
//

import Foundation
import UIKit

extension Data {
    
    func hexString() -> String {
        let string = self.map{ String($0, radix:16) }.joined()
        return string
    }
    
}
extension String {
    func toDate(withFormat format: String = "MM/DD/YYYY") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: self) else {
            preconditionFailure("Take a look to your format")
        }
        return date
    }
    func toDates(withFormat format: String = "yyyy-MM-dd") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: self) else {
            preconditionFailure("Take a look to your format")
        }
        return date
    }
    
    func toDate(byFormat : String = "yyyy-MM-dd HH:mm:ss ZZZ" , byZone : String = "") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = byFormat
        if byZone != "" {
            dateFormatter.timeZone = TimeZone(abbreviation: byZone) // "UTC"
        }
        let outdate = dateFormatter.date(from: self) ?? Date()
        return outdate
    }
}


extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    func underlined(){
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.black.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
extension UIView {
    
    @IBInspectable var CornerRadius: CGFloat{
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
    
    
    
    
    @IBInspectable var shadowOffsetWidth1: CGFloat{
        set{
            layer.shadowOffset.width = newValue
        }
        
        get{
            return layer.shadowOffset.width
        }
    }
    
    @IBInspectable var shadowOffsetHeight1: CGFloat{
        set{
            layer.shadowOffset.height = newValue
        }
        
        get{
            return layer.shadowOffset.height
        }
    }
    
    @IBInspectable var shadowColor1: UIColor{
        set{
            layer.shadowColor = newValue.cgColor
        }
        
        get{
            return UIColor(cgColor:layer.shadowColor ?? UIColor.white.cgColor)
        }
    }
    
    @IBInspectable var shadowRadius1: CGFloat{
        set{
            layer.shadowRadius = newValue
        }
        
        get{
            return layer.shadowRadius
        }
    }
    
    @IBInspectable var shadowOpacity1: Float{
        set{
            layer.shadowOpacity = newValue
        }
        
        get{
            return layer.shadowOpacity
        }
    }
    
    @IBInspectable var clipsToBound1: Bool{
        set{
            clipsToBounds = newValue
        }
        
        get{
            return clipsToBounds
        }
    }
    
    @IBInspectable var masksToBound1: Bool{
        set{
            layer.masksToBounds = newValue
        }
        
        get{
            return layer.masksToBounds
        }
    }
    
    @IBInspectable var path1: Bool{
        set{
            if path {
                self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
            }
        }
        
        get{
            return (self.layer.shadowPath != nil) ? true : false
        }
    }
    
    @IBInspectable var borderWidth1: CGFloat{
        set{
            layer.borderWidth = newValue
        }

        get{
            return layer.borderWidth
        }
    }

    @IBInspectable var borderColr1: UIColor{
        set{
            layer.borderColor = newValue.cgColor
        }

        get{
            return UIColor(cgColor:layer.borderColor ?? UIColor.white.cgColor)
        }
    }

    
    
    func shake1(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
    
}

extension UIApplication {
    
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
@IBDesignable open class CustomGradientView: UIView {
    
    @IBInspectable var StartColor: UIColor = .white
    
    @IBInspectable var EndColor: UIColor = .black
    
    override open class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func awakeFromNib() {
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.colors = [ StartColor.cgColor , EndColor.cgColor ]
        gradientLayer.startPoint = CGPoint(x: 0.3, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.05)
    }
}

@IBDesignable open class GradientButton: UIButton {
    
    @IBInspectable var StartColor: UIColor = .white
    
    @IBInspectable var EndColor: UIColor = .black
    
    open override class var layerClass : AnyClass{
        return CAGradientLayer.self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    public override init(frame: CGRect) {
        super.init(frame:frame)
    }
    
    open override func awakeFromNib() {
        let thisLayer = layer as! CAGradientLayer
        thisLayer.colors = [StartColor.cgColor, EndColor.cgColor];
        thisLayer.startPoint = CGPoint(x: 0.3, y: 0.0)
        thisLayer.endPoint = CGPoint(x: 1.0, y: 0.05)
    }
    
}
class FileDownloader {
    
    static func loadFileSync(url: URL, completion: @escaping (String?, Error?) -> Void)
    {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)
        
        if FileManager().fileExists(atPath: destinationUrl.path)
        {
            print("File already exists [\(destinationUrl.path)]")
            completion(destinationUrl.path, nil)
        }
        else if let dataFromURL = NSData(contentsOf: url)
        {
            if dataFromURL.write(to: destinationUrl, atomically: true)
            {
                print("file saved [\(destinationUrl.path)]")
                completion(destinationUrl.path, nil)
            }
            else
            {
                print("error saving file")
                let error = NSError(domain:"Error saving file", code:1001, userInfo:nil)
                completion(destinationUrl.path, error)
            }
        }
        else
        {
            let error = NSError(domain:"Error downloading file", code:1002, userInfo:nil)
            completion(destinationUrl.path, error)
        }
    }
    
    static func loadFileAsync(url: URL, completion: @escaping (String?, Error?) -> Void)
    {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)
        
        if FileManager().fileExists(atPath: destinationUrl.path)
        {
            print("File already exists [\(destinationUrl.path)]")
            completion(destinationUrl.path, nil)
        }
        else
        {
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = session.dataTask(with: request, completionHandler:
                                            {
                                                data, response, error in
                                                
                                                print(data)
                                                print(response)
                                                print(error)
                                                if error == nil
                                                {
                                                    if let response = response as? HTTPURLResponse
                                                    {
                                                        if response.statusCode == 200
                                                        {
                                                            if let data = data
                                                            {
                                                                if let _ = try? data.write(to: destinationUrl, options: Data.WritingOptions.atomic)
                                                                {
                                                                    completion(destinationUrl.path, error)
                                                                }
                                                                else
                                                                {
                                                                    completion(destinationUrl.path, error)
                                                                }
                                                            }
                                                            else
                                                            {
                                                                completion(destinationUrl.path, error)
                                                            }
                                                        }
                                                    }
                                                }
                                                else
                                                {
                                                    completion(destinationUrl.path, error)
                                                }
                                            })
            task.resume()
        }
    }
}
extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
extension Data {
    
    /// Data into file
    ///
    /// - Parameters:
    ///   - fileName: the Name of the file you want to write
    /// - Returns: Returns the URL where the new file is located in NSURL
    func dataToFile(fileName: String) -> NSURL? {
        
        // Make a constant from the data
        let data = self
        
        // Make the file path (with the filename) where the file will be loacated after it is created
        let filePath = getDocumentsDirectory().appendingPathComponent(fileName)
        
        do {
            // Write the file from data into the filepath (if there will be an error, the code jumps to the catch block below)
            try data.write(to: URL(fileURLWithPath: filePath))
            
            // Returns the URL where the new file is located in NSURL
            return NSURL(fileURLWithPath: filePath)
            
        } catch {
            // Prints the localized description of the error from the do block
            print("Error writing the file: \(error.localizedDescription)")
        }
        
        // Returns nil if there was an error in the do-catch -block
        return nil
        
    }
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory as NSString
    }
    
}
extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}
extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
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
extension UIViewController {
    
    func presentAlert(withTitle title: String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            print("You've pressed OK Button")
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func showToast(message : String, seconds: Double = 2.0) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        self.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
}
