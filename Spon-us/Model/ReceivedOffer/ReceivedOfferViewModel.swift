//
//  ReceivedOfferViewModel.swift
//  Spon-us
//
//  Created by yubin on 2/19/24.
//

import Foundation
import Moya

class ReceivedOfferViewModel: ObservableObject {
    @Published var myAnnouncementsContents: [MyAnnouncementsContent] = []
    
    private let provider = MoyaProvider<SponusAPI>(session: Session(interceptor: AuthInterceptor.shared))
    
    func fetchMyAnnouncements() {
        provider.request(.getMyAnnouncements) { result in
            switch result {
            case let .success(response):
                do {
                    let MyAnnouncementsResponse = try response.map(MyAnnouncementsModel.self)
                    self.myAnnouncementsContents = MyAnnouncementsResponse.content
                    print("받은 제안!! \(self.myAnnouncementsContents)")
                } catch {
                    print("Error parsing response: \(error)")
                }
                
            case let .failure(error):
                print("Network request failed: \(error)")
            }
        }
    }
}
