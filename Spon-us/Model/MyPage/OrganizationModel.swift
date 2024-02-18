//
//  OrganizationModel.swift
//  Spon-us
//
//  Created by yubin on 2/13/24.
//

//{
//  "statusCode": "OK",
//  "message": "OK",
//  "content": {
//    "organizationId": 4,
//    "name": "스포너스 3",
//    "email": "00yhsp@naver.com",
//    "password": "$2a$10$wDR3UKiiKvdv2QDO9zSprO4Wv1ku6VIrhaDFRFYpOmTzSflq9cKyW",
//    "location": null,
//    "description": null,
//    "imageUrl": "https://sponus.s3.ap-northeast-2.amazonaws.com/images/43b4bc56-ebb5-4eeb-bf91-86aca1d4456d.jpeg",
//    "organizationType": "STUDENT",
//    "suborganizationType": null,
//    "managerName": null,
//    "managerPosition": null,
//    "managerEmail": null,
//    "managerPhone": null,
//    "managerAvailableDay": null,
//    "managerAvailableHour": null,
//    "managerContactPreference": null,
//    "organizationStatus": "ACTIVE",
//    "tags": [],
//    "links": []
//  }
//}
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
//    let imageUrl: String?
    let imageUrl: String
    let organizationType: String
//    let suborganizationType: String
    let suborganizationType: String?
    let managerName: String?
    let managerPosition: String?
    let managerEmail: String?
    let managerPhone: String?
    let managerAvailableDay: String?
    let managerAvailableHour: String?
    let managerContactPreference: String?
    let organizationStatus: String
    let tags: [Tag]
    let links: [Links] // 'Links'에서 'Link'로 변경
}

struct Links: Codable { // 'Links'에서 'Link'로 이름 변경
    let organizationLinkId: Int
    let organizationId: Int
    let name: String
    let url: String
}

struct PatchOrganizationModel: Codable {
    let statusCode: String
    let message: String
}
