//
//  EditAnnouncementViewModel.swift
//  Spon-us
//
//  Created by 박현수 on 2/17/24.
//

import Foundation
import Moya

class EditAnnouncementViewModel: ObservableObject {
    let provider = MoyaProvider<SponusAPI>(session: Session(interceptor: AuthInterceptor.shared))
    
    func modifyAnnouncement(announcementId: Int, title: String?, type: String?, category: String?, content: String?) {
        provider.request(.patchModifyAnnouncement(announcementId: announcementId, title: title, type: type, category: category, content: content)) { result in
            switch result {
            case let .success(response):
                do {
                    let responseBody = try response.map(EditAnnouncementModel.self)
                    print(responseBody)
                } catch {
                    print(error)
                    print("parse error")
                    //self.errorMessage = "Error parsing response: \(error)"
                }
                
            case let .failure(error):
                print(error.localizedDescription)
                print("failure error")
            }
        }
    }
}
