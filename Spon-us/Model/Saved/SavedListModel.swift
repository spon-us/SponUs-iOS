//
//  SavedListModel.swift
//  Spon-us
//
//  Created by yubin on 2/19/24.
//

import Foundation

struct SavedListModel: Codable {
    let statusCode: String
    let message: String
    let content: [SavedListResponse]
}

struct SavedListResponse: Codable, Hashable {
    static func == (lhs: SavedListResponse, rhs: SavedListResponse) -> Bool {
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
    let mainImage: MainImage
    let createdAt: String
    let viewCount: Int
    let saveCount: Int
}
