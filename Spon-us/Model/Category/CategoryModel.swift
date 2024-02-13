//
//  BookmarkModel.swift
//  Spon-us
//
//  Created by 김수민 on 2/12/24.
//


import Foundation

struct CategoryModel: Codable {
    var statusCode: String
    var message: String
    var content: [CategoryContent]
}

struct CategoryContent: Codable {
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

