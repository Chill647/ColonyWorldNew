//
//  payOptionModal.swift
//  Colony world ios
//
//  Created by Getepay 2022 on 06/04/23.
//

import Foundation
struct PayOptionModal: Codable {
    let pgName, pgID, pgPasswd: String?
    let scPGlink, pgSurl, pgFurl: String?
    let pgCcCharge, pgDcCharge, pgNbCharge: Int?
    let txnid: String?
    let mode, societyID: Int?
    let product: String?

    enum CodingKeys: String, CodingKey {
        case pgName = "PG_name"
        case pgID = "PG_id"
        case pgPasswd = "PG_passwd"
        case scPGlink
        case pgSurl = "pg_surl"
        case pgFurl = "pg_furl"
        case pgCcCharge = "pg_cc_charge"
        case pgDcCharge = "pg_dc_charge"
        case pgNbCharge = "pg_nb_charge"
        case txnid, mode
        case societyID = "society_id"
        case product
    }
}
