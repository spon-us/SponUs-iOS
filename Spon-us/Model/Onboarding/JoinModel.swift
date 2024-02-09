//
//  JoinModel.swift
//  Spon-us
//
//  Created by 박현수 on 2/9/24.
//

import Foundation

struct JoinContent: Codable {
    let id: Int
    let email, name: String
}

struct JoinModel: Codable {
    let statusCode, message: String
    let content: JoinContent
}
