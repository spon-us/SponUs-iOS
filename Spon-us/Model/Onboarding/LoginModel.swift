//
//  LoginModel.swift
//  Spon-us
//
//  Created by 박현수 on 2/12/24.
//

import Foundation

struct LoginModelContent201: Codable {
    let accessToken: String
    let refreshToken: String
}

struct LoginModel201: Codable {
    let statusCode: String
    let message: String
    let content: LoginModelContent201
}

struct LoginModel401: Codable {
    let statusCode: String
    let message: String
}

struct LoginRequestBody: Codable {
    let email: String
    let password: String
    let fcmToken: String
}
