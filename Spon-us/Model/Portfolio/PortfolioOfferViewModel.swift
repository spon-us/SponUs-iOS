//
//  PortfolioOfferViewModel.swift
//  Spon-us
//
//  Created by 박현수 on 2/16/24.
//

import Foundation
import Moya

class PortfolioOfferViewModel: ObservableObject {
    @Published var announcements: [MyAnnouncementsContent] = []
    @Published var announcementIDs: [Int] = []
    @Published var offerContents: [ProposalResponse] = []
    @Published var isLoading = false
    @Published var myProposes: [Propose] = []
    
    let provider = MoyaProvider<SponusAPI>()
    
    func getMyAnnouncements(completion: @escaping (Bool) -> Void) {
        self.isLoading = true
        provider.request(.getMyAnnouncements) { result in
            switch result {
            case .success(let response):
                print(response.statusCode)
                print(response.data)
                if let jsonString = String(data: response.data, encoding: .utf8) {
                    print("서버 응답 JSON 데이터: \(jsonString)")
                }
                do {
                    let myAnnouncements = try JSONDecoder().decode(MyAnnouncementsModel.self, from: response.data)
                    DispatchQueue.main.async {
                        self.announcements = myAnnouncements.content
                        completion(true)
                    }
                } catch {
                    print("JSON 디코딩 오류: \(error)")
                    completion(false)
                }
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
    
    func appendIDs(completion: @escaping (Bool) -> Void) {
        for elem in announcements {
            announcementIDs.append(elem.id)
        }
        completion(true)
    }
    
    func getOffers(completion: @escaping (Bool) -> Void) {
        for aID in announcementIDs {
            provider.request(.getReceived(announcementId: aID)) { result in
                switch result {
                case let .success(response):
                    do {
                        let myOffers = try JSONDecoder().decode(ProposalModel.self, from: response.data)
                        self.offerContents.append(contentsOf: myOffers.content)
                        completion(true)
                    }
                    catch {
                        print("catcherrororororor")
                        completion(false)
                    }
                case let .failure(response):
                    print("failureerrororororo")
                    completion(false)
                }
            }
        }
    }
    func getProposes() {
        for elem in offerContents {
            let props = elem.proposes
            for prop in props {
                myProposes.append(prop)
            }
        }
        self.isLoading = false
    }
}
