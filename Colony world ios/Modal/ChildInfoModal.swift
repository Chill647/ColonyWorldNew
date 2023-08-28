//
//  ChildInfoModal.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 05/05/23.
//

import Foundation
import UIKit
struct ChildInfoModal: Codable {
    let err, success: Int?
    let data: [Datum1]?
}

// MARK: - Datum
struct Datum1: Codable {
    let societyID, id: Int?
    let childName1: String?
    let childName2, childName3, childName4, childName5: String?
    let childName6, childName7, childName8, childName9: String?
    let childName10: String?
    let createdBy: Int?
    let visitToken: String?
    let flatID, blockID, status, childCount: Int?
    let visitType: String?
    let approvalStatus: Int?
    let visitDateTime: String?
    let remark: String?
    let createdDate, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case societyID = "society_id"
        case id
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

struct logsModal:Codable{
    var totalcount:String?
    var time:String?
    var personName:String?
    var token:String?
    
    enum CodingKeys: String, CodingKey {
        case totalcount = "totalcount"
        case time
        case personName = "personName"
        case token
        
    }
}
