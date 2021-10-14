//
//  VerificationCode.swift
//  Vacatio
//
//  Created by Stephen Davis on 10/14/21.
//

import Foundation

struct TopLevelVerificationCodes: Decodable {
    let verificationCodes: [VerificationCode]
}

struct VerificationCode: Decodable {
    let code: String
}
