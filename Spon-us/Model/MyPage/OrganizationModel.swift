//
//  OrganizationModel.swift
//  Spon-us
//
//  Created by yubin on 2/13/24.
//

import Foundation

struct OrganizationModel: Codable {
    let statusCode: String
    let message: String
    let content: OrganizationResponse
}

struct OrganizationResponse: Codable {
    let organizationId: Int
    let name: String
    let email: String
    let password: String
    let location: String?
    let description: String?
    let imageUrl: String?
    let organizationType: String
    let suborganizationType: String
    let managerName: String?
    let managerPosition: String?
    let managerEmail: String?
    let managerPhone: String?
    let managerAvailableDay: String?
    let managerAvailableHour: String?
    let managerContactPreference: String?
    let organizationStatus: String
    let tags: [String]
    let links: [String]
}
