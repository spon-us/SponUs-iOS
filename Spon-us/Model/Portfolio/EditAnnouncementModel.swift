//
//  EditAnnouncementModel.swift
//  Spon-us
//
//  Created by 박현수 on 2/17/24.
//

import Foundation

struct EditAnnouncementModel: Codable {
    let statusCode: String
    let message: String
    let content: EditAnnouncementContent
}

struct EditAnnouncementContent: Codable {
    let id: Int
    let writerId: Int
    let title: String
    let type: String
    let category: String
    let content: String
    let status: String
    let viewCount: Int
}
