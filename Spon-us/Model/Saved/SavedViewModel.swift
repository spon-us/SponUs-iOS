//
//  SavedViewModel.swift
//  Spon-us
//
//  Created by yubin on 2/19/24.
//

import Foundation
import Combine
import Moya

class SavedViewModel: ObservableObject {
    @Published var savedResponse: SavedResponse? = nil
    
    private let provider = MoyaProvider<SponusAPI>(session: Session(interceptor: AuthInterceptor.shared))
    
    func fetchSaved(organizationId: Int) {
        provider.request(.postBookmarked(organizationId: organizationId)) { result in
            switch result {
            case let .success(response):
                do {
                    let savedResponse = try response.map(SavedModel.self)
                    self.savedResponse = savedResponse.content
                    print("북마크 토글: \(self.savedResponse)")
                    
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
