//
//  ProfileModal.swift
//  Colony world ios
//
//  Created by Getepay 2022 on 01/02/23.
//

import Foundation
struct ProfileModal: Codable {
    var userID: Int?
     let email: String?
      var entityID: Int?
     var name, address, contact1, contact2: String?
        //  let pic, idProof: String?
     var blockName: String?
    var blockID: Int?
       let flatNameNo: String?
    var flatID, societyID: Int?
       let regNo: String?
    let support: Support?
    
    enum CodingKeys: String, CodingKey {
            case userID = "user_id"
            case email
            case entityID = "entity_id"
            case name, address
            case contact1 = "contact_1"
            case contact2 = "contact_2"
            //case pic
          //  case idProof = "id_proof"
            case blockName = "block_name"
            case blockID = "block_id"
            case flatNameNo = "flat_name_no"
            case flatID = "flat_id"
            case societyID = "society_id"
            case regNo = "reg_no"
            case support
        }
    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        userID = try values.decodeIfPresent(Int.self, forKey: .userID) ?? 0
//        entityID = try values.decodeIfPresent(Int.self, forKey: .entityID) ?? 0
//        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
//        address = try values.decodeIfPresent(String.self, forKey: .address) ?? ""
//        contact1 = try values.decodeIfPresent(String.self, forKey: .contact1) ?? ""
//        contact2 = try values.decodeIfPresent(String.self, forKey: .contact2) ?? ""
//        blockName = try values.decodeIfPresent(String.self, forKey: .blockName) ?? ""
//        blockID = try values.decodeIfPresent(Int.self, forKey: .blockID) ?? 0
//        flatNameNo = try values.decodeIfPresent(String.self, forKey: .flatNameNo) ?? ""
//        blockID = try values.decodeIfPresent(Int.self, forKey: .blockID) ?? 0
//        flatID = try values.decodeIfPresent(Int.self, forKey: .flatID) ?? 0
//        self.flatID = try values.decodeIfPresent(Int.self, forKey: .flatID) ?? 0
//        
//        
//        
//        
//    }
   
}
// MARK: - Support
struct Support: Codable {
    let supportEmail, supportMobile1, supportMobile2: String

    enum CodingKeys: String, CodingKey {
        case supportEmail = "support_email"
        case supportMobile1 = "support_mobile1"
        case supportMobile2 = "support_mobile2"
    }
}
