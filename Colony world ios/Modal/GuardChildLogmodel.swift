//
//  GuardChildLogmodel.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 02/06/23.
//

import Foundation
// MARK: - GuardChildLogmodel
struct GuardChildLogmodel: Codable {
    let err, success: Int?
    let data: [childsLogs]
}

// MARK: - Datum
struct childsLogs: Codable {
    var isButtonHidden:String?
    let societyID, id: Int?
    let childName1, childName2: String?
    let childName3, childName4: String?
    let childName5, childName6, childName7, childName8: String?
    let childName9, childName10: String?
    let createdBy: Int?
    let visitToken: String
    let flatID, blockID, status, childCount: Int?
    let visitType: String?
    let approvalStatus: Int?
    let visitDateTime: String?
    let remark: String?
    let createdDate, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case societyID = "society_id"
        case id
        case isButtonHidden = "isButtonHidden"
        case childName1 = "child_name_1"
        case childName2 = "child_name_2"
        case childName3 = "child_name_3"
        case childName4 = "child_name_4"
        case childName5 = "child_name_5"
        case childName6 = "child_name_6"
        case childName7 = "child_name_7"
        case childName8 = "child_name_8"
        case childName9 = "child_name_9"
        case childName10 = "child_name_10"
        case createdBy = "created_by"
        case visitToken = "visit_token"
        case flatID = "flat_id"
        case blockID = "block_id"
        case status
        case childCount = "child_count"
        case visitType = "visit_type"
        case approvalStatus = "approval_status"
        case visitDateTime = "visit_date_time"
        case remark
        case createdDate = "created_date"
        case updatedAt = "updated_at"
    }
}
