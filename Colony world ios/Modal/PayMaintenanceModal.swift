//
//  PayMaintenanceModal.swift
//  Colony world ios
//
//  Created by Getepay 2022 on 02/02/23.
//

import Foundation

struct PayMaintenanceModal: Codable {
    let advancedAmount: Int?
    let totalPaid: Double?
    let totalDue, outstanding: Int?
    let maintenanse: [Maintenanse]?
    let paymentID: String?
   
    enum CodingKeys: String, CodingKey {
//        case totalDue, outstanding, maintenanse,totalPaid,advanced_amount
//        case paymentID = "payment_id"
        case totalDue, totalPaid
        case advancedAmount = "advanced_amount"
        case outstanding, maintenanse
        case paymentID = "payment_id"
    }
}
struct Maintenanse: Codable {
   var feesName: [FeesName]
    var isCheck = "false"
   
    enum CodingKeys: String, CodingKey {
        case feesName = "fees_name"
    }
}
// MARK: - FeesName
struct FeesName: Codable {
   // let isCheck:String = "false"
    let paymentID, societyID, userID, headID: Int?
  //  let billID: JSONNull?
    let amount, dues: Int?
 //   let paidAmt: JSONNull?
    let createdDate: String?
    let dueDate: String?
    let updatedDate: String?
    let status: Int?
    let payStatus: String?
  //  let headType: JSONNull?
    let resbillID, feesID, flatID: Int?
  //  let blockID: JSONNull?
    let maintainID: Int?
    let maintainName:String
    let maintainCost, maintainIsAlways: Int?
    let maintainDescription: String?
    let dueDateMonth: Int?
    let fees: String?
    var isCheck = "false"
    enum CodingKeys: String, CodingKey {
      
        case paymentID = "payment_id"
        case societyID = "society_id"
        case userID = "user_id"
        case headID = "head_id"
     //   case billID = "bill_id"
        case amount, dues
    //    case paidAmt = "paid_amt"
        case createdDate = "created_date"
        case dueDate = "due_date"
        case updatedDate = "updated_date"
        case status
        case payStatus = "pay_status"
      //  case headType = "head_type"
        case resbillID = "resbill_id"
        case feesID = "fees_id"
        case flatID = "flat_id"
     //   case blockID = "block_id"
        case maintainID = "maintain_id"
        case maintainName = "maintain_name"
        case maintainCost = "maintain_cost"
        case maintainIsAlways = "maintain_isAlways"
        case maintainDescription = "maintain_description"
        case dueDateMonth, fees
    }
}

enum AtedDate: String, Codable {
    case the20230123221321 = "2023-01-23 22:13:21"
    case the20230123221344 = "2023-01-23 22:13:44"
}

enum MaintainDescription: String, Codable {
    case empty = " "
}

enum MaintainName: String, Codable {
    case dc = "DC"
    case nb = "NB"
   
}

enum PayStatus: String, Codable {
    case unpaid = "UNPAID"
}

// MARK: - Encode/decode helpers

class JSONNull1: Codable, Hashable {
    static func == (lhs: JSONNull1, rhs: JSONNull1) -> Bool {
        return true
    }
    

    public static func == (lhs: JSONNull1, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
