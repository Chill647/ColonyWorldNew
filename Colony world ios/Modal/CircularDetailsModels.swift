//
//  CircularDetailsModels.swift
//  Colony world ios
//
//  Created by Getepay 2022 on 12/04/23.
//

import Foundation

// MARK: - CircularDetailsModal
struct CircularDetailsModal: Codable {
    let circular: CircularDetails?
}

// MARK: - Circular
struct CircularDetails: Codable {
    let id, societyID: Int?
    let title, description, cirFile, publishDate: String?
    let publishTodate, createdDate, updatedDate: String?
    let status: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case societyID = "society_id"
        case title, description
        case cirFile = "cir_file"
        case publishDate = "publish_date"
        case publishTodate = "publish_todate"
        case createdDate = "created_date"
        case updatedDate = "updated_date"
        case status
    }
}
