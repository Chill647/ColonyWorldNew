//
//  complaintLogsModel.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 30/05/23.
//

import Foundation

// MARK: - ComplaintLogsModel
struct ComplaintLogsModel: Codable {
    let err, success: Int?
    let data: [ComplaintList]?
}

// MARK: - Datum
struct ComplaintList: Codable {
    let compID, id, societyID, createdBy: Int?
    let complaintType, registerTo: Int?
    let category, desc, date: String?
    let complaintStatus, status: Int?
    let createdAt, updatedAt: String?
    let flatID: Int?
    let closedOn: String?
    let closedBy: Int?
    let flatNameNo, blockName, registerToRole: String?

    enum CodingKeys: String, CodingKey {
        case compID = "comp_id"
        case id
        case societyID = "society_id"
        case createdBy = "created_by"
        case complaintType = "complaint_type"
        case registerTo = "register_to"
        case category, desc, date
        case complaintStatus = "complaint_status"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case flatID = "flat_id"
        case closedOn = "closed_on"
        case closedBy = "closed_by"
        case flatNameNo = "flat_name_no"
        case blockName = "block_name"
        case registerToRole = "register_to_role"
    }
}
