//
//  LoginModel.swift
//  Spon-us
//
//  Created by 박현수 on 2/12/24.
//

import Foundation

struct LoginModelContent200: Codable {
    let accessToken: String
    let refreshToken: String
}

struct LoginModel200: Codable {
    let statusCode: String
    let message: String
    let content: LoginModelContent200
}

struct LoginModel401: Codable {
    let statusCode: String
    let message: String
    let content: String
}

struct LoginRequestBody: Codable {
    let email: String
    let password: String
    let fcmToken: String
}
