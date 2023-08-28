//
//  GallleryDetailsModal.swift
//  Colony world ios
//
//  Created by Getepay 2022 on 27/01/23.
//

import Foundation
// MARK: - GalleryDetailsModal

struct GalleryDetailsModal : Codable {
    let images : [Images]?
    //let videos : [String]?

    enum CodingKeys: String, CodingKey {

        case images = "images"
     //   case videos = "videos"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        images = try values.decodeIfPresent([Images].self, forKey: .images)
   //     videos = try values.decodeIfPresent([String].self, forKey: .videos)
    }

}
struct Images : Codable {
    let id : Int?
    let society_id : Int?
    let folder_id : Int?
    let status : Int?
    let cdate : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case society_id = "society_id"
        case folder_id = "folder_id"
        case status = "status"
        case cdate = "cdate"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        society_id = try values.decodeIfPresent(Int.self, forKey: .society_id)
        folder_id = try values.decodeIfPresent(Int.self, forKey: .folder_id)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        cdate = try values.decodeIfPresent(String.self, forKey: .cdate)
    }

}
