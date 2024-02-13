//
//  SentModel.swift
//  Spon-us
//
//  Created by yubin on 2/13/24.
//

import Foundation

struct SentModel: Codable {
    let statusCode: String
    let message: String
    let content: [SentResponse]
}

struct SentResponse: Codable, Hashable {
    let proposeId: Int
    let title: String
    let status: String
    let proposedOrganizationId: Int
    let proposedOrganizationName: String
    let proposingOrganizationId: Int
    let proposingOrganizationName: String
    let announcementSummary: AnnouncementSummary
    let createdDate: String
    let createdDay: String
    static func == (lhs: SentResponse, rhs: SentResponse) -> Bool {
            return lhs.proposeId == rhs.proposeId
        }
        func hash(into hasher: inout Hasher) {
            hasher.combine(proposeId)
        }
}

struct AnnouncementSummary: Codable {
    let id: Int
    let writerId: Int
    let writerName: String
    let title: String
    let type: String
    let category: String
    let mainImage: MainImage
    let status: String
    let viewCount: Int
    let createdAt: String
    let updatedAt: String
}

struct MainImage: Codable {
    let id: Int
    let name: String
    let url: String
}
