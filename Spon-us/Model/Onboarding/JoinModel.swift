//
//  JoinModel.swift
//  Spon-us
//
//  Created by 박현수 on 2/9/24.
//

import Foundation

enum OrgType {
    case student, company
}

enum SubOrgType {
    case studentCouncil, studentClub
}

struct JoinRequestBody: Codable {
    let name: String
    let email: String
    let password: String
    let organizationType: String
    let suborganizationType: String?
}

struct JoinContent: Codable {
    let id: Int
    let email, name: String
}

struct JoinModel: Codable {
    let statusCode, message: String
    let content: JoinContent
}
