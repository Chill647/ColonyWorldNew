//
//  GuardGenerateModel.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 03/06/23.
//

import Foundation
// MARK: - GuardGenerateModel
struct GuardGenerateModal: Codable {
    let err, success, visitToken: Int
    let ownerMobile, ownerName, msg: String

    enum CodingKeys: String, CodingKey {
        case err, success
        case visitToken = "visit_token"
        case ownerMobile = "owner_mobile"
        case ownerName = "owner_name"
        case msg
    }
}
