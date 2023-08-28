//
//  LoginModal.swift
//  Colony world ios
//
//  Created by Getepay 2022 on 23/12/22.
//

import Foundation

struct LoginModal: Codable {
      let loggedRole,society_name,society_id: String?
    let builder_id,success,user_id:Int?
    

      enum CodingKeys: String, CodingKey {
          case loggedRole, society_name,society_id
          case builder_id,success,user_id
        
      }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        loggedRole = try values.decodeIfPresent(String.self, forKey: .loggedRole) ?? ""
        society_name = try values.decodeIfPresent(String.self, forKey: .society_name) ?? ""
        builder_id = try values.decodeIfPresent(Int.self, forKey: .builder_id) ?? 0
        society_id = try values.decodeIfPresent(String.self, forKey: .society_id) ?? ""
        success = try values.decodeIfPresent(Int.self, forKey: .success) ?? 0
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id) ?? 0
    }
  }
