//
//  NotificationModel.swift
//  Spon-us
//
//  Created by 김수민 on 2/18/24.
//

import Foundation

struct NotificationModel: Codable {
    let statusCode: String
    let message: String
    let content: [NotificationContent]
}

struct NotificationContent: Codable, Identifiable {
      let id: Int
      let title: String
      let body: String
      let organizationId: Int?
      let announcementId: Int?
      let proposeId: Int?
      let isRead: Bool
}
