//
//  RefreshTokenModel.swift
//  Spon-us
//
//  Created by 박현수 on 2/15/24.
//

import Foundation

struct RefreshTokenContent: Codable {
    let accessToken, refreshToken: String
}

struct RefreshTokenModel200: Codable {
    let statusCode, message: String
    let content: RefreshTokenContent
}

struct RefreshTokenModel401: Codable {
    let statusCode, message: String
}
