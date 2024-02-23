//
//  LogoutViewModel.swift
//  Spon-us
//
//  Created by 박현수 on 2/15/24.
//

import Foundation
import Moya

class LogoutViewModel: ObservableObject {
    @Published var logoutModel200: LogoutModel200?
    @Published var logoutModel400: LogoutModel400?
    @Published var isLogoutProgressing = false
    
    let provider = MoyaProvider<SponusAPI>(session: Session(interceptor: AuthInterceptor.shared))
    func getLogout(completion: @escaping (Bool) -> Void) {
        provider.request(.getLogout) { result in
            switch result {
            case let .success(response):
                switch response.statusCode {
                case 200:
                    do {
                        print(response.statusCode)
                        let logoutResponse = try response.map(LogoutModel200.self)
                        self.logoutModel200 = logoutResponse
                        completion(true)
                    }
                    catch {
                        print("200Error")
                    }
                case 400:
                    do {
                        let logoutResponse = try response.map(LogoutModel400.self)
                        self.logoutModel400 = logoutResponse
                        completion(false)
                    }
                    catch {
                        print("400Error")
                    }
                default:
                    print(response.statusCode)
                    print(try! response.mapJSON())
                    print("Unexpected StatusCode")
                    completion(false)
                }
            case let .failure(res):
                if let responsee = res.response {
                    // 실패한 요청의 응답 본문이 있는 경우
                    if let responseBody = String(data: responsee.data, encoding: .utf8) {
                        print("Response body: \(responseBody)")
                    } else {
                        print("Failed to decode response body.")
                    }
                } else {
                    print("No response body.")
                }
                print("logout error")
                print(res.errorDescription)
                print("response error")
                completion(false)
            }
        }
    }
}
