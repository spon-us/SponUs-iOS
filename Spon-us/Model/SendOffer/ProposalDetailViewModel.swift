//
//  ProposalDetailViewModel.swift
//  Spon-us
//
//  Created by yubin on 2/13/24.
//

import Foundation
import Combine
import Moya

class ProposalDetailViewModel: ObservableObject {
    @Published var proposalDetail: ProposalDetailResponse?
    
    private let provider = MoyaProvider<SponusAPI>(plugins: [NetworkLoggerPlugin()])
    
    func fetchProposalDetail(proposeId : Int) {
        provider.request(.getProposalDetail(proposeId: proposeId)) { result in
            switch result {
            case let .success(response):
                do {
                    let proposalDetailResponse = try response.map(ProposalDetailModel.self)
                    self.proposalDetail = proposalDetailResponse.content
                    //print("넘어온 Propose ID: \(proposeId)")
                } catch {
                    print("Error parsing response: \(error)")
                }
                
            case let .failure(error):
                print("Network request failed: \(error)")
            }
        }
    }
}
