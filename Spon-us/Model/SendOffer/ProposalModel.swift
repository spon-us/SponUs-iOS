//
//  ProposalModel.swift
//  Spon-us
//
//  Created by yubin on 2/13/24.
//

import Foundation

struct ProposalModel: Codable {
    let statusCode: String
    let message: String
    let content: [ProposalResponse]
}

struct ProposalResponse: Codable, Hashable {
    let createdDate: String
    let proposes: [Propose]
}

struct Propose: Codable, Hashable {
    let proposeId: Int
    let title: String
    let status: String
    let proposedOrganizationId: Int
    let proposedOrganizationName: String
    let proposingOrganizationId: Int
    let proposingOrganizationImageUrl: String?
    let proposingOrganizationName: String
    let isReported: Bool
    let reportId: Int?
    let announcementSummary: AnnouncementSummary
    let createdDate: String
    let createdDay: String
    static func == (lhs: Propose, rhs: Propose) -> Bool {
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
    let saveCount: Int
}

struct MainImage: Codable {
    let id: Int
    let name: String
    let url: String
}
