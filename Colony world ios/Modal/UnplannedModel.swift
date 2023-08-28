//
//  UnplannedModel.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 22/05/23.
//

import Foundation

struct UnplannedModel: Codable {
    let err, success: Int
    let data: [Datum3]
}

// MARK: - Datum
struct Datum3: Codable {
    let id, societyID, flatID, blockID: Int
    let createdBy: Int
    let visitorName: String
    let visitorCount, visitorType, visitType, visitToken: Int
    let visitDate: String
    let status: Int
    let remark: String?
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case societyID = "society_id"
        case flatID = "flat_id"
        case blockID = "block_id"
        case createdBy = "created_by"
        case visitorName = "visitor_name"
        case visitorCount = "visitor_count"
        case visitorType = "visitor_type"
        case visitType = "visit_type"
        case visitToken = "visit_token"
        case visitDate = "visit_date"
        case status, remark
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
