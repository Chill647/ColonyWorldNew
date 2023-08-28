//
//  galleryModal.swift
//  Colony world ios
//
//  Created by Getepay 2022 on 27/01/23.
//

import Foundation

// MARK: - GalleryModal
struct GalleryModal: Codable {
    let folders: [Folder]
}

// MARK: - Folder
struct Folder: Codable {
    let folderID, societyID: Int
    let folderName: String
    let status: Int

    enum CodingKeys: String, CodingKey {
        case folderID = "folder_id"
        case societyID = "society_id"
        case folderName = "folder_name"
        case status
    }
}
