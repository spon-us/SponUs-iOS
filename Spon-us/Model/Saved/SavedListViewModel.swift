//
//  SavedListViewModel.swift
//  Spon-us
//
//  Created by yubin on 2/19/24.
//

import Foundation
import Combine
import Moya

class SavedListViewModel: ObservableObject {
    @Published var savedResponse: [SavedListResponse] = []
    private let provider = MoyaProvider<SponusAPI>(session: Session(interceptor: AuthInterceptor.shared))
    
    func fetchSaved(sort: String) {
        provider.request(.getBookmarked(sort: sort)) { result in
            switch result {
            case let .success(response):
                do {
                    print(try! response.mapJSON())
                    let savedListResponse = try response.map(SavedListModel.self)
                    self.savedResponse = savedListResponse.content
                    print("북마크 리스트: \(self.savedResponse.count)")
                    
                } catch {
                    print("Error parsing response: \(error)")
                }

            case let .failure(error):
                if let responsee = error.response {
                    // 실패한 요청의 응답 본문이 있는 경우
                    if let responseBody = String(data: responsee.data, encoding: .utf8) {
                        print("Response body: \(responseBody)")
                    } else {
                        print("Failed to decode response body.")
                    }
                } else {
                    print("No response body.")
                }
                print("Bookmark Network request failed: \(error)")
            }
        }
    }
}

