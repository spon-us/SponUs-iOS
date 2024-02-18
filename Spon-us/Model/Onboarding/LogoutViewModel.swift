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
            case let .failure(response):
                print("response error")
                completion(false)
            }
        }
    }
}
