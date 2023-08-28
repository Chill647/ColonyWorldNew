//
//  BannerModal.swift
//  Colony world ios
//
//  Created by Futuretek on 15/02/23.
//

import Foundation
// MARK: - BannerModal
struct BannerModal: Codable {
    let error, success: Int
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let imagePath: String
}
