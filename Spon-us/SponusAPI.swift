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
    //MARK: 검색
    case searchOrganization(keyword: String)
    case searchAnnouncement(keyword: String)
    case getMyOffer
    case patchPullUp(announcementID: Int)
    //MARK: 알림
    case getNotification
    case postReport(title: String, content: String, proposeID: Int, images: [UIImage], attatchments: [URL])
    case patchProposeReportId(proposeId: Int, reportId: Int)
    case getReport(reportId: Int)
    case postBookmarked(organizationId: Int)
    case getBookmarked(sort: String)
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
            return "/api/v1/proposes/\(proposeID)/status"
        case .deleteAnnouncement(let announcementId):
            return "/api/v1/announcements/\(announcementId)"
        case .patchModifyAnnouncement(let announcementId, _, _, _, _):
            return "/api/v1/announcements/\(announcementId)"
            //MARK: 검색
        case .searchOrganization(keyword: let keyword):
            return "/api/v1/organizations"
        case .searchAnnouncement(keyword: let keyword):
            return "/api/v1/announcements"
        case .getMyOffer:
            return "/api/v1/proposes/received"
        case .patchPullUp(let announcementID):
            return "/api/v1/announcements/\(announcementID)/pullUp"
        case .getNotification:
            return "/api/v1/organizations/notifications"
        case .postReport:
            return "/api/v1/reports"
        case .patchProposeReportId(let proposeId, _):
            return "/api/v1/proposes/\(proposeId)"
        case .getReport(let reportId):
            return "/api/v1/reports/\(reportId)"
        case .postBookmarked(let organizationId):
            return "/api/v1/me/announcements/bookmarked"
        case .getBookmarked:
            return "/api/v1/me/announcements/bookmarked"
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
        case .searchOrganization(keyword: let keyword):
            return .get
        case .searchAnnouncement(keyword: let keyword):
            return .get
        case .getMyOffer:
            return .get
        case .patchPullUp:
            return .patch
        case .getNotification:
            return .get
        case .postReport:
            return .post
        case .patchProposeReportId:
            return .patch
        case .getReport:
            return .get
        case .postBookmarked:
            return .post
        case .getBookmarked:
            return .get
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
        case .searchOrganization(keyword: let keyword):
            return Data()
        case .searchAnnouncement(keyword: let keyword):
            return Data()
        case .getMyOffer:
            return Data()
        case .patchPullUp:
            return Data()
        case .getNotification:
            return Data()
        case .postReport:
            return Data()
        case .patchProposeReportId:
            return Data()
        case .getReport:
            return Data()
        case .postBookmarked:
            return Data()
        case .getBookmarked:
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
                    let requestBody = JoinRequestBody(name: name, email: email, password: password, organizationType: "STUDENT", suborganizationType: "CLUB")
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
            //MARK: 검색
        case .searchOrganization(keyword: let keyword):
            return .requestParameters(parameters: ["search": keyword], encoding: URLEncoding.queryString)
        case .searchAnnouncement(keyword: let keyword):
            return .requestParameters(parameters: ["search": keyword], encoding: URLEncoding.queryString)
        case .getMyOffer:
            return .requestPlain
        case .patchPullUp:
            return .requestPlain
        case .getNotification:
            return .requestPlain
        case .postReport(let title, let content, let proposeID, let images, let attatchments):
            let requestParams = RequestParams(title: title, content: content, proposeId: proposeID)
            let requestJSON = try? JSONEncoder().encode(requestParams)
            let imageMultipartData = images.enumerated().map { (index, image) -> MultipartFormData in
                let imageData = image.jpegData(compressionQuality: 0.7) ?? Data()
                return MultipartFormData(provider: .data(imageData), name: "images", fileName: "image\(index).jpg", mimeType: "image/jpeg")
            }
            let test = images.enumerated().map { (index, image) -> MultipartFormData in
                let imageData = image.jpegData(compressionQuality: 0.7) ?? Data()
                return MultipartFormData(provider: .data(imageData), name: "attatchments", fileName: "image\(index).jpg", mimeType: "image/jpeg")
            }
            let filename = attatchments[0].lastPathComponent
            
            let pdfMultipartData = attatchments.enumerated().map { (index, pdf) -> MultipartFormData in
                let pdfData = try! Data(contentsOf: attatchments[0])
                print(attatchments[0])
                return MultipartFormData(provider: .data(pdfData), name: "attachments", fileName: attatchments[0].lastPathComponent, mimeType: "application/pdf")
            }
            var multipartData = [MultipartFormData]()
            if let requestData = requestJSON {
                multipartData.append(MultipartFormData(provider: .data(requestData), name: "request"))
            }
            multipartData.append(contentsOf: imageMultipartData)
            multipartData.append(contentsOf: pdfMultipartData)
            return .uploadMultipart(multipartData)
        case .patchProposeReportId(_, let reportId):
            let requestBody = PatchProposeReportBody(isReported: true, reportId: reportId)
            let requestJSON = try? JSONEncoder().encode(requestBody)
            var multipartData = [MultipartFormData]()
            if let requestData = requestJSON {
                multipartData.append(MultipartFormData(provider: .data(requestData), name: "request"))
            }
            return .uploadMultipart(multipartData)
        case .getReport:
            return .requestPlain
        case .postBookmarked(let announcementId):
            let requestBody = ["announcementId" : announcementId]
            return .requestJSONEncodable(requestBody)
        case let .getBookmarked(sort):
            let params: [String: Any] = ["sort": sort]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
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
        case .searchOrganization(keyword: let keyword):
            return ["Authorization": "Bearer \(loadAccessToken(userID: UserDefaults.standard.string(forKey: "loginAccount") ?? "loadAccessToken Error"))"]
        case .searchAnnouncement(keyword: let keyword):
            return ["Authorization": "Bearer \(loadAccessToken(userID: UserDefaults.standard.string(forKey: "loginAccount") ?? "loadAccessToken Error"))"]
        case .getMyOffer:
            return ["Authorization": "Bearer \(loadAccessToken(userID: UserDefaults.standard.string(forKey: "loginAccount") ?? "loadAccessToken Error"))"]
        case .patchPullUp:
            return ["Authorization": "Bearer \(loadAccessToken(userID: UserDefaults.standard.string(forKey: "loginAccount") ?? "loadAccessToken Error"))"]
        case .getNotification:
            return ["Authorization": "Bearer \(loadAccessToken(userID: UserDefaults.standard.string(forKey: "loginAccount") ?? "loadAccessToken Error"))"]
        case .postReport:
            return ["Authorization": "Bearer \(loadAccessToken(userID: UserDefaults.standard.string(forKey: "loginAccount") ?? "loadAccessToken Error"))"]
        case .patchProposeReportId:
            return ["Authorization": "Bearer \(loadAccessToken(userID: UserDefaults.standard.string(forKey: "loginAccount") ?? "loadAccessToken Error"))"]
        case .getReport:
            return ["Authorization": "Bearer \(loadAccessToken(userID: UserDefaults.standard.string(forKey: "loginAccount") ?? "loadAccessToken Error"))"]
        case .postBookmarked:
            return ["Authorization": "Bearer \(loadAccessToken(userID: UserDefaults.standard.string(forKey: "loginAccount") ?? "loadAccessToken Error"))"]
        case .getBookmarked:
            return ["Authorization": "Bearer \(loadAccessToken(userID: UserDefaults.standard.string(forKey: "loginAccount") ?? "loadAccessToken Error"))"]
        }
    }
}

extension SponusAPI {
    var validationType: ValidationType {
        return .successCodes
    }
}
