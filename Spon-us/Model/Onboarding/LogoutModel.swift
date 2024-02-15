//
//  LogoutModel.swift
//  Spon-us
//
//  Created by 박현수 on 2/15/24.
//

import Foundation

struct LogoutModel401: Codable {
    let statusCode, message, content: String
}

struct LogoutModel400: Codable {
    let statusCode, message: String
}
