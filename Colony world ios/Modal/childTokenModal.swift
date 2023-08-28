//
//  childTokenModal.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 17/05/23.
//

import Foundation

// MARK: - ChildTokenModal
struct ChildTokenModal: Codable {
    let err, success, securityToken: Int
    let msg: String

    enum CodingKeys: String, CodingKey {
        case err, success
        case securityToken = "security_token"
        case msg
    }
}
