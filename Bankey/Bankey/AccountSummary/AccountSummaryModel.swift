//
//  AccountSummaryModel.swift
//  Bankey
//
//  Created by Nikos Galinos on 27/4/24.
//

import Foundation
import UIKit

enum AccountType: String, Equatable {
    case Banking
    case CreditCard
    case Investment
}

struct AccountSummaryModel: Equatable {
        let accountType: AccountType
        let accountName: String
        let balanceType: String
        let balanceDolars: String
        let balanceCents: String
    }
