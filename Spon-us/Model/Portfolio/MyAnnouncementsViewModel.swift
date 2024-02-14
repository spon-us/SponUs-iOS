//
//  MyAnnouncementsViewModel.swift
//  Spon-us
//
//  Created by 박현수 on 2/14/24.
//

import Foundation
import Moya

class MyAnnouncementsViewModel: ObservableObject {
    @Published var category: String?
    @Published var type: String?
    @Published var isLoading = false
    @Published var myAnnouncementsContents: [MyAnnouncementsContent] = []
    
    let provider = MoyaProvider<SponusAPI>(plugins: [NetworkLoggerPlugin()])
    
    func getMyAnnouncements() {
        self.isLoading = true
        provider.request(.getMyAnnouncements) { result in
            switch result {
            case .success(let response):
                    if let jsonString = String(data: response.data, encoding: .utf8) {
                        print("서버 응답 JSON 데이터: \(jsonString)")
                    }

                    do {
                        let myAnnouncements = try JSONDecoder().decode(MyAnnouncementsModel.self, from: response.data)
                        DispatchQueue.main.async {
                            self.myAnnouncementsContents = myAnnouncements.content
                            self.isLoading = false
                            print(self.myAnnouncementsContents)
                        }
                    } catch {
                        print("JSON 디코딩 오류: \(error)")
                    }
            case .failure(let error):
                print(error)
            }
        }
    }

}
