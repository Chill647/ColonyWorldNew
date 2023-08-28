//
//  UpdateVersionModel.swift
//  vertex  sadguru
//
//  Created by Getepay 2022 on 29/04/23.
//

import Foundation
struct UpdateVersionModel: Codable {
    let error, success: Int?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let androidVersion, iosVersion: String?

    enum CodingKeys: String, CodingKey {
        case androidVersion = "android_version"
        case iosVersion = "ios_version"
    }
}
