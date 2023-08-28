//
//  DirectoryModal.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 24/05/23.
//

import Foundation
// MARK: - Welcome
struct DirectoryModal: Codable {
    let residentList: [ResidentList]
   // let ownerList: [OwnerList]
    let societyInchargeList, blockInchargeList: [InchargeList]
    let builderDetails: Bool
}

// MARK: - InchargeList
struct InchargeList: Codable {
    let groupName, societyName: String?
    let id, societyID, gid: Int?
    let email, password, mobile, token: String?
    let firstName, lastName, country, state: String?
    let city: String?
    let lastLoggedDate: String?
    let lastLoggedFrom: String?
    let isLoggedIn: Int?
    let createdDate, updatedDate: String?
    let status, selUserid: Int?
    let logopath, logopathresize: String?
    let username: String?

    enum CodingKeys: String, CodingKey {
        case groupName = "group_name"
        case societyName = "society_name"
        case id
        case societyID = "society_id"
        case gid, email, password, mobile, token
        case firstName = "first_name"
        case lastName = "last_name"
        case country, state, city
        case lastLoggedDate = "last_logged_date"
        case lastLoggedFrom = "last_logged_from"
        case isLoggedIn = "is_logged_in"
        case createdDate = "created_date"
        case updatedDate = "updated_date"
        case status
        case selUserid = "sel_userid"
        case logopath, logopathresize, username
    }
}

// MARK: - OwnerList
//struct OwnerList: Codable {
//    let userID: Int?
//    let email, firstName: String?
//    let lastName: LastName?
//    let mobile, blockName: String?
//    let blockID: Int?
//    let flatNameNo: String?
//    let flatID, ownerID, societyID: Int?
//    let ownerName, ownerAddress, contact1, contact2: String?
//    let flatPurchaseDate, flatPurchasePrice: String?
//    let ownerPic, ownerIDProof: String?
//    let createdDate, updatedDate: String?
//    let status, shCertificateID: Int?
//    let flatArea: String?
//    let twowhQuantity, fourwhQuantity: Int?
//    let memberID, emailID: String?
//
//    enum CodingKeys: String, CodingKey {
//        case userID = "user_id"
//        case email
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case mobile
//        case blockName = "block_name"
//        case blockID = "block_id"
//        case flatNameNo = "flat_name_no"
//        case flatID = "flat_id"
//        case ownerID = "owner_id"
//        case societyID = "society_id"
//        case ownerName = "owner_name"
//        case ownerAddress = "owner_address"
//        case contact1 = "contact_1"
//        case contact2 = "contact_2"
//        case flatPurchaseDate = "flat_purchase_date"
//        case flatPurchasePrice = "flat_purchase_price"
//        case ownerPic = "owner_pic"
//        case ownerIDProof = "owner_id_proof"
//        case createdDate = "created_date"
//        case updatedDate = "updated_date"
//        case status
//        case shCertificateID = "sh_certificate_id"
//        case flatArea = "flat_area"
//        case twowhQuantity = "twowh_quantity"
//        case fourwhQuantity = "fourwh_quantity"
//        case memberID = "member_id"
//        case emailID = "email_id"
//    }
//}
//
//enum LastName: String, Codable {
//    case colonyWorld = "colony world"
//    case empty = ""
//    case jain = "JAIN"
//    case kandoi = "Kandoi"
//    case katariya = "katariya"
//    case khandelwal = "Khandelwal"
//    case lastNameJain = "jain"
//    case pareek = "pareek"
//    case society = "SOCIETY"
//}

// MARK: - ResidentList
struct ResidentList: Codable {
    let userID: Int?
    let email: String?
    let firstName, lastName, mobile, blockName: String?
    let blockID: Int?
    let flatNameNo: String?
    let residentID,flatID, societyID: Int?
    let  residentName,residentAddress, contact1, contact2: String?
    let residentPic, residentIDProof: String?
    let isOwner: Int?
    let createdDate, updatedDate: String?
    let status: Int?
    let rentFromDate: String?
    let rentToDate: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case mobile
        case blockName = "block_name"
        case blockID = "block_id"
        case flatNameNo = "flat_name_no"
        case flatID = "flat_id"
        case residentID = "resident_id"
        case societyID = "society_id"
       case residentName = "resident_name"
        case residentAddress = "resident_address"
        case contact1 = "contact_1"
        case contact2 = "contact_2"
        case residentPic = "resident_pic"
        case residentIDProof = "resident_id_proof"
        case isOwner = "is_owner"
        case createdDate = "created_date"
        case updatedDate = "updated_date"
        case status
        case rentFromDate = "rent_from_date"
        case rentToDate = "rent_to_date"
    }
}

