//
//  ChangeBookMarkViewModel.swift
//  Spon-us
//
//  Created by 황인성 on 2/18/24.
//

import Foundation
import Moya
import SwiftUI
import Alamofire

class ChangeBookMarkViewModel: ObservableObject {
    @Published var changeBookmark: ChangeBookMarkResponseDetail?
    
    private let provider = MoyaProvider<SponusAPI>(session: Session(interceptor: AuthInterceptor.shared))
    
    
    func fetchBookMark(announcementID: Int) {
        // JSON 데이터 생성
        let json: [String: Any] = [
            "announcementId": announcementID
        ]
        
        // HTTP 요청에 필요한 헤더 생성
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(loadAccessToken(userID: UserDefaults.standard.string(forKey: "loginAccount") ?? "loadAccessToken Error"))"
        ]
        
        // 요청 보낼 URL
        let url = "http://3.38.233.66:8080/api/v1/me/announcements/bookmarked"
        
        AF.request(url, method: .post, parameters: json, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        print("Request succeeded with response: \(value)")
                        // Process response data
                    case .failure(let error):
                        print("Request failed with error: \(error)")
                        // Error handling
                    }
                }
    }
}
