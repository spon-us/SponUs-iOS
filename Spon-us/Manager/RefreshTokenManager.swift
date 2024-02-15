//
//  RefreshTokenManager.swift
//  Spon-us
//
//  Created by 박현수 on 2/15/24.
//

import Foundation
import Moya

func renewToken() {
    let provider = MoyaProvider<SponusAPI>(plugins: [NetworkLoggerPlugin()])
    
    provider.request(.getRenewToken) { result in
        switch result {
        case let .success(response):
            switch response.statusCode {
            case 200:
                print(response.statusCode)
                print("success")
                let renewResponse = try? response.map(RefreshTokenModel200.self)
                saveAccessToken(userID: UserDefaults.standard.string(forKey: "loginAccount") ?? "userID Error", accessToken: renewResponse?.content.accessToken ?? "renewAccessTokenError")
                saveRefreshToken(userID: UserDefaults.standard.string(forKey: "loginAccount") ?? "userID Error", refreshToken: renewResponse?.content.refreshToken ?? "renewRefreshTokenError")
                print(renewResponse as Any)
            
            default:
                print("failed")
                print("token renew error")
                print(response.statusCode)
                print(response.data)
            }
        case let .failure(response):
            print(response.errorDescription)
            print("renew error")
        }
    }
}
