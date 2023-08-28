//
//  GalleryClickController.swift
//  Colony world ios
//
//  Created by Getepay 2022 on 12/04/23.
//

import UIKit

class GalleryClickController: UIViewController {
    var imageURl = ""
    @IBOutlet weak var ImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: imageURl ?? "")
        if url != nil {
                     DispatchQueue.global().async {
                            let data = try? Data(contentsOf: url!)
                            DispatchQueue.main.async {
                                if data != nil {
                                    self.ImageView.image = UIImage(data:data!)
            
                                }
                            }
                        }
        
        }
       
    }
    
    @IBAction func CloseBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func DownLoadBtn(_ sender: Any) {
        if !imageURl.isEmpty{
            print("FilepathService--->\(imageURl)")
             DownlondFromUrl()
        }else{
            displayMessage("Download Url Not Found !!")
        }
    }
    func DownlondFromUrl(){

        var k = ""
        
        let urlString = imageURl
        let url = URL(string: urlString)
        print("urlPaymentHistoryDownload--->\(url)")
        let fileName = String((url!.lastPathComponent)) as NSString
        let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL? ?? URL(string: "")!
        let destinationFileUrl = documentsUrl.appendingPathComponent("\(fileName).xlsx")
        print(fileName)
        let fileURL = URL(string: urlString)
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = URLRequest(url:fileURL!)
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)")
                }
                try? FileManager.default.removeItem(at: destinationFileUrl)
                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                    do {
                        let contents  = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
                        for indexx in 0..<contents.count {
                            if contents[indexx].lastPathComponent == destinationFileUrl.lastPathComponent {
                                let activityViewController = UIActivityViewController(activityItems: [contents[indexx]], applicationActivities: nil)
                                DispatchQueue.main.async {
                                    self.present(activityViewController, animated: true, completion: nil)
                                }
                                
                            }
                        }
                    }
                    catch (let err) {
                        print("error: \(err)")
                    }
                } catch (let writeError) {
                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
                }
            } else {
                print("Error took place while downloading a file. Error description: \(error?.localizedDescription ?? "")")
            }
        }
        task.resume()
        
        
        
    }
}
