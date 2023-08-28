//
//  CircularModal.swift
//  Colony world ios
//
//  Created by Futuretek on 27/01/23.
import Foundation
struct CircularModal: Decodable {
    let circulars: [Circular]
}
struct Circular: Codable {
    let circularID: Int?
    let title, publishDate, publishTodate: String?

    enum CodingKeys: String, CodingKey {
        case circularID = "circular_id"
        case title
        case publishDate = "publish_date"
        case publishTodate = "publish_todate"
    }
}
