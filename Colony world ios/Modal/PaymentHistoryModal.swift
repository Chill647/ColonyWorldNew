//
//  PaymentHistoryModal.swift
//  Colony world ios
//
//  Created by Futuretek on 30/01/23.
//

import Foundation
struct PaymentHistoryModal: Codable {
    let paymentHistory: [PaymentHistory]
}
struct PaymentHistory: Codable {
    let fees_name:String?
    let maintainName: String?
    let id, societyID, billNumber: Int?
   // let paidAmount: Int?
    let paidBy, transactionNumber: String?
    let paidFrom, payStatus: String?
    let paymentMode: String?
    let bankName, ddChequeNo, createdDate, updatedDate: String?
    let receiptBillNumber: Int?
    let excessID: JSONNull?
    let payeeName, ddChequeDate, billDate, byCash: String?
    let byChequeDD, bankName2, ddChequeNo2, payeeName2: String?
    let ddChequeDate2, bankName3, ddChequeNo3, payeeName3: String?
    let ddChequeDate3, byChequeDd2, byChequeDd3: String?
    let status: Int?
    let opyear, orgID: JSONNull?
    let advancePay, approveBill, chequeBounce, discount: Int?
    let fineAmount, outstandingAmount: Int?
    let neftRefNumber, remarksPayment, firstName, lastName: String?
    let flatID: Int?
    let flatNameNo: String?
    let blockID: Int?
    let blockName: String?
    let total_paid_amount:String?
    
    enum CodingKeys: String, CodingKey {
        case fees_name = "fees_name"
        case maintainName = "maintain_name"
        case id
        case societyID = "society_id"
        case billNumber = "bill_number"
   //     case residentID = "resident_id"
     //  case paidAmount = "paid_amount"
     //   case pgCommission = "pg_commission"
     //   case onlineDiscount = "online_discount"
        case paidBy = "paid_by"
        case transactionNumber = "transaction_number"
        case paidFrom = "paid_from"
        case payStatus = "pay_status"
        case paymentMode = "payment_mode"
        case bankName = "bank_name"
        case ddChequeNo = "dd_cheque_no"
        case createdDate = "created_date"
        case updatedDate = "updated_date"
        case receiptBillNumber = "receipt_bill_number"
        case excessID = "excess_id"
        case payeeName = "payee_name"
        case ddChequeDate = "dd_cheque_date"
        case billDate = "bill_date"
        case byCash = "by_cash"
        case byChequeDD = "by_cheque_dd"
        case bankName2 = "bank_name2"
        case ddChequeNo2 = "dd_cheque_no2"
        case payeeName2 = "payee_name2"
        case ddChequeDate2 = "dd_cheque_date2"
        case bankName3 = "bank_name3"
        case ddChequeNo3 = "dd_cheque_no3"
        case payeeName3 = "payee_name3"
        case ddChequeDate3 = "dd_cheque_date3"
        case byChequeDd2 = "by_cheque_dd2"
        case byChequeDd3 = "by_cheque_dd3"
        case status, opyear
        case orgID = "org_id"
        case advancePay = "advance_pay"
        case approveBill = "approve_bill"
        case chequeBounce = "cheque_bounce"
        case discount
        case fineAmount = "fine_amount"
        case outstandingAmount = "outstanding_amount"
        case neftRefNumber = "neft_ref_number"
        case remarksPayment = "remarks_payment"
        case firstName = "first_name"
        case lastName = "last_name"
        case flatID = "flat_id"
        case flatNameNo = "flat_name_no"
        case blockID = "block_id"
        case blockName = "block_name"
        case total_paid_amount = "total_paid_amount"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
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
