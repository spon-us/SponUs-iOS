//
//  MyAnnouncementsModel.swift
//  Spon-us
//
//  Created by 박현수 on 2/14/24.
//

import Foundation

struct MyAnnouncementsModel: Codable {
    var statusCode: String
    var message: String
    var content: [MyAnnouncementsContent]
}

struct MyAnnouncementsContent: Codable {
    var id: Int
    var writerId: Int
    var writerName: String
    var title: String
    var type: String
    var category: String
    var mainImage: MainImage
    var status: String
    var viewCount: Int
    var createdAt: String
    var updatedAt: String
}
