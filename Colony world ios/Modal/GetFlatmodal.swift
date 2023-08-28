//
//  GetFlatmodal.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 03/06/23.
//

import Foundation

// MARK: - GetFlatmodal
struct GetFlatmodal: Codable {
    let err, success: Int?
    let data: [flatList]
}

// MARK: - Datum
struct flatList: Codable {
    let flatID: Int?
    let flatNameNo: String?

    enum CodingKeys: String, CodingKey {
        case flatID = "flat_id"
        case flatNameNo = "flat_name_no"
    }
}
