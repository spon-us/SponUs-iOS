//
//  ChangeBookMarkModel.swift
//  Spon-us
//
//  Created by 황인성 on 2/18/24.
//

import Foundation

// MARK: - ChangeBookMarkModel
struct ChangeBookMarkResponse: Codable {
    let statusCode, message: String
    let content: ChangeBookMarkResponseDetail
}

// MARK: - Content
struct ChangeBookMarkResponseDetail: Codable {
    let id, organizationID, announcementID: Int
    let bookmarked: Bool

}
