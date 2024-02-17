//
//  SearchAnnouncementModel.swift
//  Spon-us
//
//  Created by 김수민 on 2/17/24.
//

import Foundation

struct SearchAnnouncementModel: Codable {
    let statusCode: String
    let message: String
    let content: [SearchAnnouncementContent]
}

struct SearchAnnouncementContent: Codable, Hashable, Equatable,Identifiable {
    static func == (lhs: SearchAnnouncementContent, rhs: SearchAnnouncementContent) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: Int
    let writerId: Int
    let writerName: String
    let title: String
    let type: String
    let category: String
    let mainImage: SearchAnnouncementMainImage
    let status: String
    let viewCount: Int
    let createdAt: String
    let updatedAt: String
    let saveCount: Int
}

struct SearchAnnouncementMainImage: Codable, Hashable, Equatable, Identifiable {
    static func == (lhs: SearchAnnouncementMainImage, rhs: SearchAnnouncementMainImage) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    let id: Int
    let name: String
    let url: String
}

