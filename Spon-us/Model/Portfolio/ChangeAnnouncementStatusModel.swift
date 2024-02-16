//
//  ChangeAnnouncementStatusModel.swift
//  Spon-us
//
//  Created by 박현수 on 2/16/24.
//

import Foundation
import Moya

struct ChangeAnnouncementStatusContent: Codable {
    let id, viewCount: Int
    let writerId: Int?
    let title, type, category, content, status: String
}

struct ChangeAnnouncementStatusModel200: Codable {
    let statusCode, message: String
    let content: ChangeAnnouncementStatusContent
}

struct ChangeAnnouncementStatusModel400: Codable {
    let statusCode, message: String
}
