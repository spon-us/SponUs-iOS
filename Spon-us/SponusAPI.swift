//
//  SponusAPI.swift
//  Spon-us
//
//  Created by yubin on 2/7/24.
//

import Foundation
import Moya
import KeychainSwift
import SwiftUI

enum OrgType {
    case student, company
}

enum SubOrgType {
    case studentCouncil, studentClub
}

struct JoinRequestBody: Codable {
    let name: String
    let email: String
    let password: String
    let organizationType: String
    let suborganizationType: String?
}

enum SponusAPI {
    case postEmail(email: String)
    case postJoin(name: String, email: String, password: String, orgType: OrgType, subOrgType: SubOrgType?)
    case postAnnouncement(title: String, type: String, category: String, content: String, images: [UIImage])
    case getCategory(category: String?, type: String?)
    case getAnnouncement(announcementId: Int)
    case propose(title: String, content: String, announcementId: Int, attachments: [URL])
}

extension SponusAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://3.38.233.66:8080")!
    }
    
    var path: String {
        switch self {
        case .postEmail:
            return "/api/v1/organizations/email"
        case .postJoin:
            return "/api/v1/organizations/join"
        case .postAnnouncement(title: let title, type: let type, category: let category, content: let content, images: let images):
            return "/api/v1/announcements"
        case .getCategory(category: let category, type: let type):
            return "/api/v1/announcements/category"
        case .getAnnouncement(announcementId: let announcementId):
            return "/api/v1/announcements/\(announcementId)"
        case .propose(title: let title, content: let content, announcementId: let announcementId, attachments: let attachments):
            return "/api/v1/proposes"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postEmail:
            return .post
        case .postJoin:
            return .post
        case .postAnnouncement(title: let title, type: let type, category: let category, content: let content, images: let images):
            return .post
        case .getCategory(category: let category, type: let type):
            return .get
        case .getAnnouncement(announcementId: let announcementId):
            return .get
        case .propose(title: let title, content: let content, announcementId: let announcementId, attachments: let attachments):
                return .post
        }
    }
    
    var sampleData: Data {
        switch self {
        case .postEmail:
            return Data()
        case .postJoin:
            let response: [String : Any] = [
                        "statusCode": "OK",
                        "message": "OK",
                        "content": [
                            "id": 0,
                            "email": "test@test.com",
                            "name": "test"
                        ]
            ]
            return try! JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
        case .postAnnouncement(title: let title, type: let type, category: let category, content: let content, images: let images):
                let sampleResponse: [String: Any] = [
                    "statusCode": "string",
                    "message": "string",
                    "content": [
                        "id": 0,
                        "writerId": 0,
                        "title": "string",
                        "type": "SPONSORSHIP",
                        "category": "IDEA",
                        "content": "string",
                        "status": "OPENED",
                        "viewCount": 0
                    ]
                ]
                return try! JSONSerialization.data(withJSONObject: sampleResponse, options: .prettyPrinted)
        case .getCategory(category: let category, type: let type):
            return Data()
        case .getAnnouncement(announcementId: let announcementId):
            return Data()
        case .propose(title: let title, content: let content, announcementId: let announcementId, attachments: let attachments):
            return Data()
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postEmail(let email):
            let parameters: [String: Any] = ["email": email]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .postJoin(let name, let email, let password, let orgType, let subOrgType):
            switch orgType {
            case .student:
                switch subOrgType! {
                case .studentCouncil:
                    let requestBody = JoinRequestBody(name: name, email: email, password: password, organizationType: "STUDENT", suborganizationType: "STUDENT_COUNCIL")
                    return .requestJSONEncodable(requestBody)
                case .studentClub:
                    let requestBody = JoinRequestBody(name: name, email: email, password: password, organizationType: "STUDENT", suborganizationType: "STUDENT_CLUB")
                    return .requestJSONEncodable(requestBody)
                }
            case .company:
                let requestBody = JoinRequestBody(name: name, email: email, password: password, organizationType: "STUDENT", suborganizationType: nil)
                return .requestJSONEncodable(requestBody)
            }
        case .postAnnouncement(title: let title, type: let type, category: let category, content: let content, images: let images):
            let requestParams = [
               "title": title,
               "type": type,
               "category": category,
               "content": content
           ]
           let requestJSON = try? JSONEncoder().encode(requestParams)

           let imageMultipartData = images.enumerated().map { (index, image) -> MultipartFormData in
               let imageData = image.jpegData(compressionQuality: 0.7) ?? Data()
               return MultipartFormData(provider: .data(imageData), name: "images", fileName: "image\(index).jpg", mimeType: "image/jpeg")
           }
           var multipartData = [MultipartFormData]()
           if let requestData = requestJSON {
               multipartData.append(MultipartFormData(provider: .data(requestData), name: "request"))
           }
           multipartData.append(contentsOf: imageMultipartData)
           
           return .uploadMultipart(multipartData)
        case .getCategory(category: let category, type: let type):
            var parameters: [String: Any] = [:]
            if let category = category {
                parameters["category"] = category
            }
            if let type = type {
                parameters["type"] = type
            }
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .getAnnouncement(announcementId: let announcementId):
            return .requestPlain
        case .propose(let title, let content, let announcementId, let attachments):
            var multipartData: [MultipartFormData] = []
            let requestParameters = [
                "title": title,
                "content": content,
                "announcementId": announcementId
            ] as [String : Any]
            if let requestData = try? JSONSerialization.data(withJSONObject: requestParameters, options: []) {
                multipartData.append(MultipartFormData(provider: .data(requestData), name: "request"))
            }
            attachments.forEach { url in
                if let data = try? Data(contentsOf: url) {
                    let formData = MultipartFormData(provider: .data(data), name: "attachments", fileName: url.lastPathComponent, mimeType: "application/octet-stream") //MimeType 실제로 바꾸기, 아직 구현 x
                    multipartData.append(formData)
                }
            }
            if attachments.isEmpty {
                let formData = MultipartFormData(provider: .data("string".data(using: .utf8)!), name: "attachments")
                multipartData.append(formData)
            }
            return .uploadMultipart(multipartData)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .postEmail:
            return nil
        case .postJoin:
            return nil
        /*
        case .postLike:
            return ["Content-Type": "application/json",
                    "Accept": "application/json",
                    "atk": KeychainSwift().get("accessToken") ?? ""] */
        case .postAnnouncement(title: let title, type: let type, category: let category, content: let content, images: let images):
            return [
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwiZW1haWwiOiJzcG9udXNAZ21haWwuY29tIiwiYXV0aCI6IkNPTVBBTlkiLCJpYXQiOjE3MDc3NDcwMzMsImV4cCI6MTcwODM1MTgzM30.fuPOq7cbQys7PwM0td9AEd6kVGfAPpcn1lQWOvlDTDU"
            ]
        case .getCategory(category: let category, type: let type):
            return [
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwiZW1haWwiOiJzcG9udXNAZ21haWwuY29tIiwiYXV0aCI6IkNPTVBBTlkiLCJpYXQiOjE3MDc3NDcwMzMsImV4cCI6MTcwODM1MTgzM30.fuPOq7cbQys7PwM0td9AEd6kVGfAPpcn1lQWOvlDTDU"
            ]
        case .getAnnouncement(announcementId: let announcementId):
            return [
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwiZW1haWwiOiJzcG9udXNAZ21haWwuY29tIiwiYXV0aCI6IkNPTVBBTlkiLCJpYXQiOjE3MDc3NDcwMzMsImV4cCI6MTcwODM1MTgzM30.fuPOq7cbQys7PwM0td9AEd6kVGfAPpcn1lQWOvlDTDU"
            ]
        case .propose(title: let title, content: let content, announcementId: let announcementId, attachments: let attachments):
            return [
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwiZW1haWwiOiJzcG9udXNfc3R1ZGVudEBnbWFpbC5jb20iLCJhdXRoIjoiU1RVREVOVCIsImlhdCI6MTcwNzgxNzkwNCwiZXhwIjoxNzA4NDIyNzA0fQ.r1QRU91tLjvDbiPco3RBnapB4j4DsXmbn-D7c0yfU6E"
            ]
        }
    }
}
