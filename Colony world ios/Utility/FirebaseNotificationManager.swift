//
//  FirebaseNotificationManager.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 04/05/23.
//

import Foundation

//class MTNotification {
//    let alert: [String: AnyHashable]
//    var title: String?
//    var body: String?
//
//    init(alert: [String: AnyHashable]) {
//        self.alert = alert
//    }
//}
//class MTNotificationBuilder {
//
//     /// Build a notification from raw data
//     ///
//     /// - Parameter data: Classic notification payload, received from app delegate
//     /// - Returns: customized MTNotification
//     /// - Throws: error while building a valid MTNotification object
//    static func build(from data: [AnyHashable : Any]) throws -> MTNotification {
//        guard let aps = data["aps"] as? [String: AnyHashable] else {
//            // Do some error handlig
//            throw MTError.missingProperty(id: "aps")
//        }
//
//        guard let alert = aps["alert"] as? [String: AnyHashable] else {
//            // Do some error handlig
//            throw MTError.missingProperty(id: "aps")
//        }
//
//        let notification = MTNotification(alert: alert)
//        // Assign values read as optionals from alert dictionary
//        notification.title = alert["title"] as? String
//        notification.body = alert["body"] as? String
//
//        return notification
//    }
//}
