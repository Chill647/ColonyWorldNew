//
//  WsRequestManager.swift
//  Colony world ios
//
//  Created by Futuretek on 22/12/22.
//
import Foundation

class WSRequestManager: NSObject {
    var endPoint : String = ""
    
    init(_ endPoint : String) {
    }
    
    func prePareRequest() -> URLRequest? {
        return nil
    }
    
    func getParameter() -> String {
        return ""
    }
}

