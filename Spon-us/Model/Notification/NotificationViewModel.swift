//
//  NotificationViewModel.swift
//  Spon-us
//
//  Created by 김수민 on 2/18/24.
//

import Foundation
import Moya

class NotificationViewModel: ObservableObject {
    @Published var notificationContents: [NotificationContent] = []
    @Published var isLoading = false
    let provider = MoyaProvider<SponusAPI>()
    
    func getNotifications(){
        self.isLoading = true
        provider.request(.getNotification){result in 
            switch result {
            case .success(let response):
                do {
                    // 성공적으로 데이터를 받아온 경우, JSON 디코딩을 시도합니다.
                    let searchResults = try JSONDecoder().decode(NotificationModel.self, from: response.data)
                    self.notificationContents = searchResults.content
                } catch let error {
                    // 디코딩 과정에서 오류가 발생한 경우, 오류를 처리합니다.
                    print("Error decoding data: \(error)")
                }
            case .failure(let error):
                print("Error decoding data: \(error)")
            }
        }
    }
}
