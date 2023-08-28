//
//  ParkingModal.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 29/05/23.
//

import Foundation


// MARK: - ParkingModal
struct ParkingModal: Codable {
    let err, success: Int
    let data: [parkingArray]
}

// MARK: - Datum
struct parkingArray: Codable {
    let id, societyID, blockID, flatID: Int
    let slotName, createdDate, updatedDate: String
    let status, builderID: Int
    let flatNameNo: String
    let flatCoveredArea, flatCarpetArea: Int
    let flatFullAddress, blockName: String
    let blockInchargeUserID: Int?
    let createDate: String
    let blockSecretaryUserID, blockTreasureUserID, blockChairmenUserID: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case societyID = "society_id"
        case blockID = "block_id"
        case flatID = "flat_id"
        case slotName = "slot_name"
        case createdDate = "created_date"
        case updatedDate = "updated_date"
        case status
        case builderID = "builder_id"
        case flatNameNo = "flat_name_no"
        case flatCoveredArea = "flat_covered_area"
        case flatCarpetArea = "flat_carpet_area"
        case flatFullAddress = "flat_full_address"
        case blockName = "block_name"
        case blockInchargeUserID = "block_incharge_user_id"
        case createDate = "create_date"
        case blockSecretaryUserID = "block_Secretary_user_id"
        case blockTreasureUserID = "block_Treasure_user_id"
        case blockChairmenUserID = "block_Chairmen_user_id"
    }
}
