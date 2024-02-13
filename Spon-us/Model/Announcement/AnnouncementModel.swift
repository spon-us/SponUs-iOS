//
//  AnnouncementModel.swift
//  Spon-us
//
//  Created by 김수민 on 2/13/24.
//

import Foundation
import SwiftUI
struct Tags: Decodable {
    let id: Int
    let name: String
}

struct AnnouncementImages: Decodable {
    let id: Int
    let name, url: String
}
struct AnnouncementContent: Decodable {
    let id: Int
    let writer: Writer
    let title, type, category, content: String
    let announcementImages: [AnnouncementImages]
    let status: String
    let viewCount: Int
}

struct AnnouncementModel: Decodable {
    let statusCode, message: String
    let content: AnnouncementContent
}

