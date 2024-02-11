//
//  LoginViewModel.swift
//  Spon-us
//
//  Created by 박현수 on 2/12/24.
//

import Foundation
import Moya

class LoginViewModel: ObservableObject {
    @Published var login200: LoginModel200?
    @Published var login401: LoginModel401?
    
    private let provider = MoyaProvider<SponusAPI>(plugins: [NetworkLoggerPlugin()])
    
    func postLogin(email: String, password: String, fcmToken: String) {
        provider.request(.postLogin(email: email, password: password, fcmToken: fcmToken)) { result in
            switch result {
            case let .success(response):
                do {
                    if response.statusCode == 200 {
                        let loginResponse = try response.map(LoginModel200.self)
                        self.login200 = loginResponse
                    }
                    else {
                        let loginResponse = try response.map(LoginModel401.self)
                        self.login401 = loginResponse
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
