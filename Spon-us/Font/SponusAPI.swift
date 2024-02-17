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

enum SponusAPI {
    case postEmail(email: String)
    case postJoin(name: String, email: String, password: String, orgType: OrgType, subOrgType: SubOrgType?)
    case postAnnouncement(title: String, type: String, category: String, content: String, images: [UIImage])
    case getCategory(category: String?, type: String?)
    case getAnnouncement(announcementId: Int)
    case propose(title: String, content: String, announcementId: Int, attachments: [URL])
    case postLogin(email: String, password: String, fcmToken: String)
    case getLogout
    case getMe
    case getSent
    case getProposalDetail(proposeId: Int)
    case getOrganization(organizationId: Int)
    case getReceived(announcementId: Int)
    case getMyAnnouncements
    case getRenewToken
    case patchChangeAnnouncementStatus(announcementID: Int, status: String)
    case patchChangeOfferStatus(proposeID: Int, status: String)
    case deleteAnnouncement(announcementId: Int)
    case patchModifyAnnouncement(announcementId: Int, title: String?, type: String?, category: String?, content: String?)
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
        case .postLogin:
            return "/api/v1/organizations/login"
        case .getLogout:
            return "/api/v1/organizations/logout"
        case .getMe:
            return "/api/v1/organizations/me"
        case .getSent:
            return "/api/v1/proposes/sent"
        case .getProposalDetail(let proposeId):
            return "/api/v1/proposes/\(proposeId)"
        case .getOrganization(let organizationId):
            return "/api/v1/organizations/\(organizationId)"
        case .getReceived:
            return "/api/v1/proposes/received"
        case .getMyAnnouncements:
            return "/api/v1/announcements/me/opened"
        case .getRenewToken:
            return "/api/v1/auth/reissue"
        case .patchChangeAnnouncementStatus(let announcementID, _):
            return "/api/v1/announcements/\(announcementID)/status"
        case .patchChangeOfferStatus(let proposeID, let status):
            return "/api/v1/propose/\(proposeID)"
        case .deleteAnnouncement(let announcementId):
            return "/api/v1/announcements/\(announcementId)"
        case .patchModifyAnnouncement(let announcementId, _, _, _, _):
            return "/api/v1/announcements/\(announcementId)"
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
        case .postLogin:
            return .post
        case .getLogout:
            return .get
        case .getMe:
            return .get
        case .getSent:
            return .get
        case .getProposalDetail:
            return .get
        case .getOrganization:
            return .get
        case .getReceived:
            return .get
        case .getMyAnnouncements:
            return .get
        case .getRenewToken:
            return .get
        case .patchChangeAnnouncementStatus:
            return .patch
        case .patchChangeOfferStatus:
            return .patch
        case .deleteAnnouncement:
            return .delete
        case .patchModifyAnnouncement:
            return .patch
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
        case .postLogin:
            let response: [String : Any] = [
                "statusCode": "200",
                "message": "OK",
                "content": [
                    "accessToken": "sfiulghsdkh",
                    "refreshToken": "alskdjfhaslkjgh"
                ]
            ]
            return try! JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
        case .getLogout:
            return Data()
        case .getMe:
            return Data()
        case .getSent:
            return Data()
        case .getProposalDetail:
            return Data()
        case .getOrganization:
            return Data()
        case .getReceived:
            return Data()
        case .getMyAnnouncements:
            return Data()
        case .getRenewToken:
            return Data()
        case .patchChangeAnnouncementStatus:
            return Data()
        case .patchChangeOfferStatus:
            return Data()
        case .deleteAnnouncement:
            return Data()
        case .patchModifyAnnouncement:
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
        case .postLogin(let email, let password, let fcmToken):
            let requestBody = LoginRequestBody(email: email, password: password, fcmToken: fcmToken)
            return .requestJSONEncodable(requestBody)
        case .getLogout:
            return .requestPlain
        case .getMe:
            return .requestPlain
        case .getSent:
            return .requestPlain
        case .getProposalDetail:
            return .requestPlain
        case .getOrganization:
            return .requestPlain
        case .getReceived(let announcementId):
            let parameters: [String: Any] = ["announcementId": announcementId]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .getMyAnnouncements:
            return .requestPlain
        case .getRenewToken:
            return .requestPlain
        case .patchChangeAnnouncementStatus(_, let status):
            let requestBody = ["status" : status]
            return .requestJSONEncodable(requestBody)
        case .patchChangeOfferStatus(_, let status):
            let requestBody = ["status" : status]
            return .requestJSONEncodable(requestBody)
        case .deleteAnnouncement(let announcementId):
            let requestBody = ["announcementId" : announcementId]
            return .requestJSONEncodable(requestBody)
        case .patchModifyAnnouncement(_, let title, let type, let category, let content):
            let requestBody = [
                "title" : title,
                "type" : type,
                "category" : category,
                "content" : content
            ]
            return .requestJSONEncodable(requestBody)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .postEmail:
            return nil
        case .postJoin:
            return nil
        case .postLogin:
            return nil
        case .getLogout:
            return ["Authorization": "Bearer \(loadAccessToken(userID: UserDefaults.standard.string(forKey: "loginAccount") ?? "loadAccessToken Error"))"]
        case .getMe:
            return ["Authorization": "Bearer \(loadAccessToken(userID: UserDefaults.standard.string(forKey: "loginAccount") ?? "loadAccessToken Error"))"]
        case .getSent:
            return ["Authorization": "Bearer \(loadAccessToken(userID: UserDefaults.standard.string(forKey: "loginAccount") ?? "loadAccessToken Error"))"]
        case .getProposalDetail:
            return ["Authorization": "Bearer \(loadAccessToken(userID: UserDefaults.standard.string(forKey: "loginAccount") ?? "loadAccessToken Error"))"]
        case .getOrganization:
            return ["Authorization": "Bearer \(loadAccessToken(userID: UserDefaults.standard.string(forKey: "loginAccount") ?? "loadAccessToken Error"))"]
        /*
        case .postLike:
            return ["Content-Type": "application/json",
                    "Accept": "application/json",
                    "atk": KeychainSwift().get("accessToken") ?? ""] */
        case .postAnnouncement(title: let title, type: let type, category: let category, content: let content, images: let images):
            return ["Authorization": "Bearer \(loadAccessToken(userID: UserDefaults.standard.string(forKey: "loginAccount") ?? "loadAccessToken Error"))"]
        case .getCategory(category: let category, type: let type):
            return ["Authorization": "Bearer \(loadAccessToken(userID: UserDefaults.standard.string(forKey: "loginAccount") ?? "loadAccessToken Error"))"]
        case .getAnnouncement(announcementId: let announcementId):
            return ["Authorization": "Bearer \(loadAccessToken(userID: UserDefaults.standard.string(forKey: "loginAccount") ?? "loadAccessToken Error"))"]
        case .propose(title: let title, content: let content, announcementId: let announcementId, attachments: let attachments):
            return ["Authorization": "Bearer \(loadAccessToken(userID: UserDefaults.standard.string(forKey: "loginAccount") ?? "loadAccessToken Error"))"]
        case .getReceived:
            return ["Authorization": "Bearer \(loadAccessToken(userID: UserDefaults.standard.string(forKey: "loginAccount") ?? "loadAccessToken Error"))"]
        case .getMyAnnouncements:
            return ["Authorization": "Bearer \(loadAccessToken(userID: UserDefaults.standard.string(forKey: "loginAccount") ?? "loadAccessToken Error"))"]
        case .getRenewToken:
            return ["RefreshToken": "\(loadRefreshToken(userID: UserDefaults.standard.string(forKey: "loginAccount") ?? "loadRefreshToken Error"))"]
        case .patchChangeAnnouncementStatus:
            return ["Authorization": "Bearer \(loadAccessToken(userID: UserDefaults.standard.string(forKey: "loginAccount") ?? "loadAccessToken Error"))"]
        case .patchChangeOfferStatus:
            return ["Authorization": "Bearer \(loadAccessToken(userID: UserDefaults.standard.string(forKey: "loginAccount") ?? "loadAccessToken Error"))"]
        case .deleteAnnouncement:
            return ["Authorization": "Bearer \(loadAccessToken(userID: UserDefaults.standard.string(forKey: "loginAccount") ?? "loadAccessToken Error"))"]
        case .patchModifyAnnouncement:
            return ["Authorization": "Bearer \(loadAccessToken(userID: UserDefaults.standard.string(forKey: "loginAccount") ?? "loadAccessToken Error"))"]
        }
    }
}

extension SponusAPI {
  var validationType: ValidationType {
      return .successCodes
  }
}
