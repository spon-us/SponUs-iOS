//
//  SponusAPI.swift
//  Spon-us
//
//  Created by yubin on 2/7/24.
//

import Foundation
import Moya
import KeychainSwift

enum SponusAPI {
    case postEmail(email: String)
    case postJoin(name: String, email: String, password: String, orgType: OrgType, subOrgType: SubOrgType?)
    case postLogin(email: String, password: String, fcmToken: String)
    case getMe
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
        case .postLogin:
            return "/api/v1/organizations/login"
        case .getMe:
            return "/api/v1/organizations/me"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postEmail:
            return .post
        case .postJoin:
            return .post
        case .postLogin:
            return .post
        case .getMe:
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
        case .getMe:
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
        case .postLogin(let email, let password, let fcmToken):
            let requestBody = LoginRequestBody(email: email, password: password, fcmToken: fcmToken)
            return .requestJSONEncodable(requestBody)
        case .getMe:
            return .requestPlain
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
        case .getMe:
            return ["Authorization": KeychainSwift().get("accessToken") ?? "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwiZW1haWwiOiJzcG9udXNAZ21haWwuY29tIiwiYXV0aCI6IkNPTVBBTlkiLCJpYXQiOjE3MDc4MTYxMjQsImV4cCI6MTcwNzgyMzMyNH0.xLvGR6VwNVFNPjt3u3PLJNhs1BU5yrz9nitBFgPjyrM"]
            
        /*
        case .postLike:
            return ["Content-Type": "application/json",
                    "Accept": "application/json",
                    "atk": KeychainSwift().get("accessToken") ?? ""] */
        }
    }
    
}
