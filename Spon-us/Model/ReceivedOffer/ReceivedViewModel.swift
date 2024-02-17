//
//  ReceivedViewModel.swift
//  Spon-us
//
//  Created by yubin on 2/14/24.
//

import Foundation
import Combine
import Moya

class ReceivedViewModel: ObservableObject {
    @Published var proposalReceived: [ProposalResponse] = []
    
    private let provider = MoyaProvider<SponusAPI>(session: Session(interceptor: AuthInterceptor.shared))
    
    func fetchProposalReceived(announcementId : Int) {
        provider.request(.getReceived(announcementId: announcementId)) { result in
            switch result {
            case let .success(response):
                do {
                    let receivedResponse = try response.map(ProposalModel.self)
                    self.proposalReceived = receivedResponse.content
                    print("받은 제안 \(self.proposalReceived.count)")
                } catch {
                    print("Error parsing response: \(error)")
                }
                
            case let .failure(error):
                print("Network request failed: \(error)")
            }
        }
    }
}
