//
//  SearchOrganizationViewModel.swift
//  Spon-us
//
//  Created by 김수민 on 2/17/24.
//

import Foundation
import Moya

class SearchOrganizationViewModel: ObservableObject {
    @Published var searchOrganizationResult: SearchOrganizationModel?
    @Published var searchOrganizationContents: [SearchOrganizationContent] = []
    @Published var isLoading = false
    let provider = MoyaProvider<SponusAPI>(plugins: [NetworkLoggerPlugin()])
    
    func getSearchOrganization(keyword: String) {
        self.isLoading = true
        provider.request(.searchOrganization(keyword: keyword ?? "")){ result in
            switch result {
            case .success(let response):
                do {
                    // 성공적으로 데이터를 받아온 경우, JSON 디코딩을 시도합니다.
                    let searchResults = try JSONDecoder().decode(SearchOrganizationModel.self, from: response.data)
                    self.searchOrganizationResult = searchResults
                    self.searchOrganizationContents = searchResults.content
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
