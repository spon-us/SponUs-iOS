//
//  SentViewModel.swift
//  Spon-us
//
//  Created by yubin on 2/13/24.
//

import Foundation
import Combine
import Moya

class SentViewModel: ObservableObject {
    @Published var proposalSent: [SentResponse] = []
    @Published var errorMessage: String?
    
    private let provider = MoyaProvider<SponusAPI>()
    
    func fetchProposalSent() {
        provider.request(.getSent) { result in
            switch result {
            case let .success(response):
                do {
                    let sentResponse = try response.map(SentModel.self)
                    self.proposalSent = sentResponse.content
                    print("보낸 제안 \(self.proposalSent.count)")
                } catch {
                    print("Error parsing response: \(error)")
                }
                
            case let .failure(error):
                print("Network request failed: \(error)")
            }
        }
    }
}
