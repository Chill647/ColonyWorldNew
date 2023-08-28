//
//  GetBlockModal.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 03/06/23.
//

import Foundation

// MARK: - GetBlockModal
struct GetBlockModal: Codable {
    let err, success: Int
    let data: [blockList]
}

// MARK: - Datum
struct blockList: Codable {
    let blockID: Int
    let blockName: String

    enum CodingKeys: String, CodingKey {
        case blockID = "block_id"
        case blockName = "block_name"
    }
}
