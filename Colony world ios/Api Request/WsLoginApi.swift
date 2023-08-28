//
//  WsLoginApi.swift
//  Colony world ios
//
//  Created by Getepay 2022 on 23/12/22.
//

import Foundation


class WSLoginAPI: WSRequestManager {

    var tag : String = ""
    var userEmail : String = ""
    var userPass : String = ""
    var society_id: String = ""
    init(_ tag: String,_ userEmail: String,_ userPass: String,_ society_id:String) {
        super.init("")
        self.tag = tag
        self.userEmail = userEmail
        self.userPass = userPass
        self.society_id = society_id
    }

    override func prePareRequest() -> URLRequest? {
        let strUrl = "\(baseSeverUrl)"
        let url : URL = URL.init(string: strUrl)!
        var urlRequest : URLRequest = URLRequest.init(url: url)
        urlRequest.httpMethod = "POST"
        let requestBody : String = getParameter()
        if !requestBody.isEmpty {
            urlRequest.httpBody = requestBody.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        }
         // urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        print("WSLoginAPI-----\(urlRequest)")
        print("WSLoginAPIReqBody---\(requestBody)")
       // urlRequest.httpBody = WebAPIManager.jsonToString(json: [:])
        return urlRequest
    }
    
    
    
    
    override func getParameter() -> String {
        var commonParams : [String:Any] = [String:Any]()
            commonParams["tag"] = tag
            commonParams["userEmail"] = userEmail
            commonParams["userPass"] = userPass
           commonParams["society_id"] = society_id

         let retVal : String = WebAPIManager.jsonToString(json: commonParams)
            return retVal
    }
    
           
    
}
