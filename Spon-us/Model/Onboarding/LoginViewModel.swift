//
//  LoginViewModel.swift
//  Spon-us
//
//  Created by 박현수 on 2/12/24.
//

import Foundation
import Moya

class LoginViewModel: ObservableObject {
    @Published var login201: LoginModel201?
    @Published var login401: LoginModel401?
    @Published var isBadRequest = false
    
    private let provider = MoyaProvider<SponusAPI>(plugins: [NetworkLoggerPlugin()])
    
    func postLogin(email: String, password: String, fcmToken: String, completion: @escaping (Bool) -> Void) {
        provider.request(.postLogin(email: email, password: password, fcmToken: fcmToken)) { result in
            switch result {
            case let .success(response):
                do {
                    if response.statusCode == 201 {
                        let loginResponse = try response.map(LoginModel201.self)
                        self.login201 = loginResponse
                        self.isBadRequest = false
                        print(loginResponse)
                        completion(true)
                    }
                    else {
                        let loginResponse = try response.map(LoginModel401.self)
                        self.login401 = loginResponse
                        self.isBadRequest = true
                        completion(false)
                    }
                } catch {
                    print("Error parsing response: \(error)")
                }

            case let .failure(error):
                print("Network request failed: \(error)")
            }
        }
    }
}
