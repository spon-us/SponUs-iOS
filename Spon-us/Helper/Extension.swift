//
//  Extension.swift
//  Spon-us
//
//  Created by 황인성 on 1/25/24.
//

import Foundation
import UIKit
import SwiftUI
import Alamofire
import Moya

extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}


extension View {
    func navigationBarBackground(_ background: Color = Color(.sponusBlack).opacity(0.6)) -> some View {
        return self
            .modifier(ColoredNavigationBar(background: background))
    }
    func mynavigationBarBackground(_ background: Color = Color(.sponusBlack)) -> some View {
        return self
            .modifier(ColoredNavigationBar(background: background))
    }
}

struct ColoredNavigationBar: ViewModifier {
    var background: Color
    
    func body(content: Content) -> some View {
        content
            .toolbarBackground(
                background,
                for: .navigationBar
            )
            .toolbarBackground(.visible, for: .navigationBar)
    }
}

func changeToEnglish(category: String? = nil, type: String? = nil) -> String? {
    // 카테고리 처리
    if let category = category {
        switch category {
        case "전체":
            return nil
        case "기획/아이디어":
            return "IDEA"
        case "광고/마케팅":
            return "MARKETING"
        case "디자인":
            return "DESIGN"
        case "사진/영상":
            return "MEDIA"
        case "IT/소프트웨어/게임":
            return "DEVELOPMENT"
        case "기타":
            return "OTHER"
        default:
            return nil
        }
    }

    // 타입 처리
    if let type = type {
        switch type {
        case "전체":
            return nil
        case "협찬":
            return "SPONSORSHIP"
        case "제휴":
            return "PARTNERSHIP"
        case "연계프로젝트":
            return "COLLABORATION"
        default:
            return nil
        }
    }

    return nil
}

func changeToKorean(category: String? = nil, type: String? = nil) -> String? {
    if let category = category {
        switch category {
        case "IDEA":
            return "기획/아이디어"
        case "MARKETING":
            return "광고/마케팅"
        case "DESIGN":
            return "디자인"
        case "MEDIA":
            return "사진/영상"
        case "DEVELOPMENT":
            return "IT/소프트웨어/게임"
        case "OTHER":
            return "기타"
        default:
            return "전체"
        }
    }
    if let type = type {
        switch type {
        case "SPONSORSHIP":
            return "협찬"
        case "PARTNERSHIP":
            return "제휴"
        case "COLLABORATION":
            return "연계프로젝트"
        default:
            return "전체"
        }
    }
    return nil
}

final class AuthInterceptor: RequestInterceptor {
    static var currentRetryCount = 0
    static var maximumRetryCount = 1
    static let shared = AuthInterceptor()
    let provider = MoyaProvider<SponusAPI>()
    private init() {}

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
//            guard urlRequest.url?.absoluteString.hasPrefix(Config.baseURL) == true,
//                  let accessToken = UserManager.shared.accessToken,
//                  let refreshToken = UserManager.shared.refreshToken
//            else {
//                completion(.success(urlRequest))
//                return
//            }
//            
//            var urlRequest = urlRequest
//            urlRequest.setValue(accessToken, forHTTPHeaderField: "accessToken")
//            urlRequest.setValue(refreshToken, forHTTPHeaderField: "refreshToken")
//            print("adator 적용 \(urlRequest.headers)")
            print("adapt")
            completion(.success(urlRequest))
        }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("retry 진입")
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401
        else {
            completion(.doNotRetryWithError(error))
            return
        }
        guard AuthInterceptor.currentRetryCount < AuthInterceptor.maximumRetryCount else {
            AuthInterceptor.currentRetryCount = 0
            completion(.doNotRetry)
            return
        }
        provider.request(.getRenewToken) { result in
            switch result {
            case let .success(response):
                switch response.statusCode {
                case 200:
                    print(response.statusCode)
                    print("success")
                    print(try? response.mapJSON())
                    let renewResponse = try? response.map(RefreshTokenModel200.self)
                    saveAccessToken(userID: UserDefaults.standard.string(forKey: "loginAccount") ?? "userID Error", accessToken: renewResponse?.content.accessToken ?? "renewAccessTokenError")
                    saveRefreshToken(userID: UserDefaults.standard.string(forKey: "loginAccount") ?? "userID Error", refreshToken: renewResponse?.content.refreshToken ?? "renewRefreshTokenError")
                    print(renewResponse as Any)
                    completion(.retry)
                default:
                    print("failed")
                    print("token renew error")
                    print(response.statusCode)
                    print(response.data)
                    completion(.doNotRetry)
                }
            case let .failure(response):
                print("failure")
                completion(.doNotRetryWithError(error))
            }
        }
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
