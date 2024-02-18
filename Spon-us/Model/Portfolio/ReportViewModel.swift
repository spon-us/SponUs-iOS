//
//  ReportViewModel.swift
//  Spon-us
//
//  Created by 박현수 on 2/19/24.
//

import Foundation

// 최상위 응답 객체
struct ReportResponseModel: Codable {
    let statusCode: String
    let message: String
    let content: ReportContent
}

// 'content' 필드 내용
struct ReportContent: Codable {
    let id: Int
    let writerId: Int
    let title: String
    let content: String
    let reportImages: [ReportImage]
    let reportAttachments: [ReportAttachment]
}

// 'reportImages' 배열 내의 객체
struct ReportImage: Codable {
    let id: Int
    let name: String
    let url: String
}

// 'reportAttachments' 배열 내의 객체
struct ReportAttachment: Codable {
    let id: Int
    let name: String
    let url: String
}
