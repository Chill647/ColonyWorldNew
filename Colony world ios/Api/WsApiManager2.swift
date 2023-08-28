//
//  WsApiManager2.swift
//  Colony world ios
//
//  Created by Getepay 2022 on 24/01/23.
//
import Foundation
import Alamofire
class WebParamsApiManager: NSObject {
    
    class func perFormRequest(url : String, params : Parameters, completion : @escaping ( _ reponse : Any? ,   _ error : Error? ,  _ errorCode : Int) -> Void ){
      
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        
        Alamofire.request(url,method: .post,parameters: params,encoding: URLEncoding.httpBody, headers: headers).responseJSON{(response) in
            
            guard let _ = response.data , response.error == nil else {
                completion(["data" : response.data,"url":response.request?.url],response.error,0)
                return print("errior")
            }
            
            if let res : HTTPURLResponse = response.response {
                if res.statusCode == 200 {
                    if let value : NSArray = response.value as? NSArray {
                        completion(value,nil,0)
                        
                        return
                    } else if let value : NSDictionary = response.value as? NSDictionary {
                        completion(value,nil,0)
                    }
                } else {
                    var errorMessgae = ""
                    if let result = response.result.value {
                        if let resultDict : NSDictionary = result as? NSDictionary {
                            if let errors : [Any] = resultDict["errors"] as? [Any] {
                                for error in errors {
                                    if let messageDict : [String : Any] =  error as? [String : Any] {
                                        if let message : String = messageDict["message"] as? String {
                                            if !errorMessgae.isEmpty {
                                                errorMessgae = errorMessgae + ","
                                            }
                                            
                                            errorMessgae = errorMessgae + message
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    if errorMessgae.isEmpty {
                        
                    }
                    
                    if errorMessgae.isEmpty {
                        errorMessgae = response.error?.localizedDescription ?? "Response Error"
                    }
                    
                    completion(nil,NSError(domain: "\(res.statusCode)", code: res.statusCode, userInfo: ["message" : errorMessgae]),res.statusCode)
                    return
                }
            }
        }
        
        
        
    }
    
    class func jsonToString(json: Any) -> String{
        do {
            let data =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
            let convertedString = String(data: data, encoding: String.Encoding.utf8)
            return convertedString ?? ""
        } catch let myJSONError {
            print(myJSONError)
        }
        return ""
    }
}
//
//extension String {
//
//    func base64Encoded() -> String? {
//        data(using: .utf8)?.base64EncodedString()
//    }
//
//    func base64Decoded() -> String? {
//        guard let data = Data(base64Encoded: self) else { return nil }
//        return String(data: data, encoding: .utf8)
//    }
//}
