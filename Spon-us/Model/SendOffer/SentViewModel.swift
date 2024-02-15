//
//  SentViewModel.swift
//  Spon-us
//
//  Created by yubin on 2/13/24.
//

import Foundation
import Combine
import Moya

import Foundation
import Combine
import Moya

class SentViewModel: ObservableObject {
    @Published var proposalSent: [ProposalResponse] = []
    @Published var groupedProposalsByDate: [ProposalDate: [Propose]] = [:]
    @Published var sortedUniqueDates: [ProposalDate] = []
    
    private let provider = MoyaProvider<SponusAPI>()
    
    func fetchProposalSent() {
        provider.request(.getSent) { result in
            switch result {
            case let .success(response):
                do {
                    let sentResponse = try response.map(ProposalModel.self)
                    self.proposalSent = sentResponse.content
                    
                    self.groupedProposalsByDate = self.groupProposalsByDate(sentResponse.content)
                    
                    self.sortedUniqueDates = Array(self.groupedProposalsByDate.keys.sorted())
                    
                    print("보낸 제안 날짜 \(self.proposalSent.count)")
                } catch {
                    print("Error parsing response: \(error)")
                }
                
            case let .failure(error):
                print("Network request failed: \(error)")
            }
        }
    }
    
    private func groupProposalsByDate(_ proposals: [ProposalResponse]) -> [ProposalDate: [Propose]] {
        var groupedByDate = [ProposalDate: [Propose]]()
        
        for proposal in proposals {
            for propose in proposal.proposes {
                let date = ProposalDate(date: propose.createdDate, day: propose.createdDay)
                if groupedByDate[date] == nil {
                    groupedByDate[date] = [propose]
                } else {
                    groupedByDate[date]?.append(propose)
                }
            }
        }
        
        return groupedByDate
    }
}

struct ProposalDate: Comparable, Hashable, CustomStringConvertible {
    let date: String
    let day: String

    var description: String {
        let uppercaseDay = day.uppercased()
        return "\(date) \(uppercaseDay)"
    }

    static func < (lhs: ProposalDate, rhs: ProposalDate) -> Bool {
        if lhs.date != rhs.date {
            return lhs.date > rhs.date
        }
        
        return lhs.day > rhs.day
    }
}
