//
//  TutorialModel.swift
//  Colony world ios
//
//  Created by Getepay 2022 on 13/04/23.
//

import Foundation

// MARK: - TutorialModel
struct TutorialModel: Codable {
    let err, success: Int?
    let videos: [Video]?
}

// MARK: - Video
struct Video: Codable {
    let path, title, description: String?
}
