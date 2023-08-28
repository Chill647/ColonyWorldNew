//
//  JSON.swift
//  Colony world ios
//
//  Created by Getepay 2022 on 23/12/22.
//

import Foundation



let baseSeverUrl = "http://democolony.getekart.com/cwgatepay/index.php?plugin=MobileAPI&action=getRequest"
//let baseSeverUrl = "https://colony.getekart.com/index.php?plugin=MobileAPI&action=getRequest"
//let imageUrl = "http://democolony.getekart.com/cwgatepay/"
let imageUrl2 = "https://colony.getekart.com"
let xlsPath = "https://colony.getekart.com"




var fcmTocken_Val = ""
let PrintDataResponse = true
let API_Key = ""
let HttpMethod = "POST"
let ContentType = "application/x-www-form-urlencoded"
public var kUserHash: String? {
    set{
        let preferences = UserDefaults.standard
        preferences.set(newValue, forKey: "HASH")
        preferences.synchronize()
    }
    
    get{
        return UserDefaults.standard.value(forKey: "HASH") as? String
    }
}

public typealias JSONCallBack = (AnyObject?, Error? , String?)->Void

public final class JSONRequest{
    
    public static func makeRequest(_ url: String, parameters inputParameters: [String: String], callback: JSONCallBack?){
        print("Requesting url ==> \(url)")
        var parameters: [String: String] = inputParameters
        parameters["hash"] = kUserHash ?? ""
        parameters["platform"] = "IOS"
        for (key, value) in parameters{
           print("\(key)==> \(value)")
        }
        
        DispatchQueue(label: "JSON_REQUEST_QUEUE", attributes: []).async(execute: {
            
            let postString:NSMutableString = ""
            
            postString.append(url)
            
            postString.append("?")

            while let value = parameters.popFirst(){
                postString.append("&"+value.0+"="+value.1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            }
            
            print(postString)
      
            var request = URLRequest(url: URL(string: postString as String)!)
            
            request.httpMethod = HttpMethod
            
            request.setValue(ContentType, forHTTPHeaderField: "Content-Type")
            
            request.setValue(API_Key, forHTTPHeaderField: "api_key")
            
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
                
                guard error == nil && data != nil else {
                    
                    // check for fundamental networking error
                    self.processResponce(nil, error: error, str: "Error in Api", callback: callback)
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse , httpStatus.statusCode != 200 {
                    // check for http errors
                    let error = NSError(domain: "Error", code: httpStatus.statusCode, userInfo: [NSLocalizedDescriptionKey: response!])
                    self.processResponce(nil, error: error, str: "Error in Api", callback: callback)
                    return
                }
                
                let object = self.getJSONObject(data!)
                
                self.processResponce(object.0, error: object.1, str: object.2, callback: callback)
            })
            task.resume()
        })
        
    }
    
    public static func makeRequest(urlForData urlString:String,completion:@escaping ((Data?,Error?) -> ())){
        
        print("Request URL ====> \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("JSONRequest ====> Error in URL")
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error == nil{
                if let data = data{
                    completion(data,error)
                }
            }else{
                completion(nil,error)
            }
        }
        
        dataTask.resume()
    }


    
    private static func processResponce(_ object: AnyObject?, error: Error?, str:String?, callback: JSONCallBack?){
        
        DispatchQueue.main.async(execute: {
            callback?(object, error, str)
        })
    }
    
 
    private static func getJSONObject(_ inputData: Data) -> (AnyObject?,Error?,String?){
        
        if PrintDataResponse{
            print("-------------------------------------JSON Request Data----------------------------------------")
            print("\(String(data: inputData, encoding: String.Encoding.utf8)!)")
            print("----------------------------------------------------------------------------------------------")
        }
        
        do{
            let value = try JSONSerialization.jsonObject(with: inputData, options: .allowFragments)
            return (value as? AnyObject,nil,nil)
        }catch{
            print(error)
            if let err = String(data: inputData, encoding: String.Encoding.utf8),err.contains("Error"){
                return (nil,error,err)
            }else if let err = String(data: inputData, encoding: String.Encoding.utf8),(err.contains("success")||err.contains("Success")){
                return (nil,nil,err)
            }else if let err = String(data: inputData, encoding: String.Encoding.utf8),(err.contains("update")||err.contains("Update")){
                return (nil,nil,err)
            }else {
                return (nil,nil,nil)
            }
            
            
        }
        
    }
    
    private static func getDataFromJSON(_ json: [String:Any]) -> Data?{
        do{
            let data = try JSONSerialization.data(withJSONObject: json)
            return data as Data?
        }catch{
            print(error)
            return nil
        }
    }
    
}
