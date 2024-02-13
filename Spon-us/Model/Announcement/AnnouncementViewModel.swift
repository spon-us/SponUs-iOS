//
//  AnnouncementViewModel.swift
//  Spon-us
//
//  Created by 김수민 on 2/13/24.
//

import Foundation
import Combine
import Moya

class AnnouncementViewModel{
    var announcementContent: AnnouncementContent?
    var errorMessage: String?
    var announcementId: Int
    private let provider = MoyaProvider<SponusAPI>()
    init(announcementId: Int){
        self.announcementId = announcementId
    }
    func fetchAnnouncement() {
        provider.request(.getAnnouncement(announcementId: announcementId)) { result in
            switch result {
            case let .success(response):
                do {
                    let announcementModel = try response.map(AnnouncementModel.self)
                    self.announcementContent = announcementModel.content
                } catch {
                    self.errorMessage = "Error parsing response: \(error)"
                }

            case let .failure(error):
                self.errorMessage = "Network request failed: \(error)"
            }
        }
    }
}
