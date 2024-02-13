//
//  ProposalDetailModel.swift
//  Spon-us
//
//  Created by yubin on 2/13/24.
//

import Foundation

struct ProposalDetailModel: Codable {
    let statusCode: String
    let message: String
    let content: ProposalDetailResponse
}

struct ProposalDetailResponse: Codable {
    let proposeId: Int
    let title, content, status: String
    let proposedOrganizationId: Int
    let proposedOrganizationName: String
    let proposingOrganizationId: Int
    let proposingOrganizationName: String
    let proposeAttachmentUrl: [String]
    let announcementDetails: AnnouncementDetails
    let createdDate, createdDay: String
}

struct AnnouncementDetails: Codable {
    let id: Int
    let writer: Writer
    let title, type, category, content: String
    let announcementImages: [AnnouncementImage]
    let status: String
    let viewCount: Int
}

struct AnnouncementImage: Codable {
    let id: Int
    let name, url: String
}

struct Writer: Codable {
    let id: Int
    let name, image: String
    let tags: [Tag]
}

struct Tag: Codable {
    let id: Int
    let name: String
}
