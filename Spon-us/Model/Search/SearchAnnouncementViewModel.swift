//
//  SearchAnnouncementViewModel.swift
//  Spon-us
//
//  Created by 김수민 on 2/17/24.
//

import Foundation
import Moya

class SearchAnnouncementViewModel: ObservableObject {
    @Published var searchAnnouncementResult: SearchAnnouncementModel?
    @Published var searchAnnouncementContents: [SearchAnnouncementContent] = []
    @Published var isLoading = false
    let provider = MoyaProvider<SponusAPI>(plugins: [NetworkLoggerPlugin()])
    
    func getSearchAnnouncement(keyword: String) {
        self.isLoading = true
        provider.request(.searchAnnouncement(keyword: keyword ?? "")){ result in
            switch result {
            case .success(let response):
                do {
                    // 성공적으로 데이터를 받아온 경우, JSON 디코딩을 시도합니다.
                    let searchResults = try JSONDecoder().decode(SearchAnnouncementModel.self, from: response.data)
                    self.searchAnnouncementResult = searchResults
                    self.searchAnnouncementContents = searchResults.content
                } catch let error {
                    // 디코딩 과정에서 오류가 발생한 경우, 오류를 처리합니다.
                    print("Error decoding data: \(error)")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
