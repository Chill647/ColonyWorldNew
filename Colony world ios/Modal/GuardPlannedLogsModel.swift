//
//  GuardPlannedLogsModel.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 02/06/23.
//

import Foundation
// MARK: - GuardPlannedLogsModel
struct GuardPlannedLogsModel: Codable {
    let err, success: Int?
    let data: [GuardLogs]
}

// MARK: - Datum
struct GuardLogs: Codable {
    let id, societyID, flatID, blockID: Int?
    let createdBy: Int?
    let visitorName: String?
    let visitorCount, visitToken: Int?
    let visitDate: String?
    let status: Int?
    let remark: String?
    let visitorType, visitType: Int?
    let createdAt, updatedAt, flatName: String?

    enum CodingKeys: String, CodingKey {
        case id
        case societyID = "society_id"
        case flatID = "flat_id"
        case blockID = "block_id"
        case createdBy = "created_by"
        case visitorName = "visitor_name"
        case visitorCount = "visitor_count"
        case visitToken = "visit_token"
        case visitDate = "visit_date"
        case status, remark
        case visitorType = "visitor_type"
        case visitType = "visit_type"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case flatName = "flat_name"
    }
}
