//
//  AccountSummaryModel.swift
//  Bankey
//
//  Created by Nikos Galinos on 27/4/24.
//

import Foundation
import UIKit

enum AccountType: String, Equatable, Decodable {
    case Banking
    case CreditCard
    case Investment
}

struct AccountSummaryModel: Equatable, Decodable {
    let accountType: AccountType
    let accountName: String
    let balanceType: String
    let balanceDollars: String
    let balanceCents: String
}
