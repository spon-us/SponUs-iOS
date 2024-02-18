//
//  MakeReportViewModel.swift
//  Spon-us
//
//  Created by 박현수 on 2/18/24.
//

import Foundation
import Moya

struct PostReportResponse: Codable {
    let statusCode: String
    let message: String
    let content: PostReportContent
}

// 'content' 필드 내용을 담을 구조체
struct PostReportContent: Codable {
    let id: Int
    let writerId: Int
    let title: String
    let content: String
}

struct RequestParams: Codable {
    let title: String
    let content: String
    let proposeId: Int
}

struct PatchProposeReportBody: Codable {
    let isReported: Bool
    let reportId: Int?
}

class MakeReportViewModel: ObservableObject {
    @Published var filename = ""
    
    
}
