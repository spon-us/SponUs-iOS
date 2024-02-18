//
//  SavedModel.swift
//  Spon-us
//
//  Created by yubin on 2/19/24.
//

import Foundation

struct SavedModel: Codable {
    let statusCode: String
    let message: String
    let content: SavedResponse
}

struct SavedResponse: Codable {
    let id: Int
    let organizationId: Int
    let announcementId: Int
    let bookmarked: Bool
}
