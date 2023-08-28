//
//  VisitorModel.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 19/05/23.
//

import Foundation

// MARK: - VisitorModel
struct VisitorModel: Codable {
    let err, success, visitToken: Int
    let msg: String

    enum CodingKeys: String, CodingKey {
        case err, success
        case visitToken = "visit_token"
        case msg
    }
}
