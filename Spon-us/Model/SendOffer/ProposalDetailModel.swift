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
    let proposedOrganizationImage: String
    let proposingOrganizationId: Int
    let proposingOrganizationName: String
    let proposingOrganizationImage: String
    let proposeAttachmentUrl: [ProposeAttachmentUrl]
    let announcementDetails: AnnouncementDetails
    let createdDate, createdDay: String
}

struct ProposeAttachmentUrl: Codable {
    let id: Int
    let name: String
    let url: String
}

struct AnnouncementDetails: Codable {
    let id: Int
    let writerId: Int? //!!!!!!!!!!
    let title, type, category, content: String
    let announcementImages: [AnnouncementImage]
    let status: String
    let viewCount: Int
    
    init(id: Int = 0, writerId: Int? = nil, title: String = "", type: String = "",
         category: String = "", content: String = "",
         announcementImages: [AnnouncementImage] = [], status: String = "", viewCount: Int = 0) {
        self.id = id
        self.writerId = writerId
        self.title = title
        self.type = type
        self.category = category
        self.content = content
        self.announcementImages = announcementImages
        self.status = status
        self.viewCount = viewCount
    }
}

struct AnnouncementImage: Codable, Hashable {
    let id: Int
    let name, url: String
}

struct Writer: Codable {
    let id: Int
    let name: String
    let image: String? // 없을수도있음
    let tags: [Tag]
}

struct Tag: Codable {
    let id: Int
    let name: String
}
