//
//  File.swift
//  Spon-us
//
//  Created by 황인성 on 2/19/24.
//

import Foundation
import Combine
import Moya
import Alamofire

class ReceivedOfferMyAnnouncementsViewModel: ObservableObject {
    
    var subscription = Set<AnyCancellable>()
    
    @Published var myAnnouncementsContents: [MyAnnouncementsContent] = []
    
    let headers: HTTPHeaders = ["Authorization": "Bearer \(loadAccessToken(userID: UserDefaults.standard.string(forKey: "loginAccount") ?? "loadAccessToken Error"))"]
    
    let url = "http://3.38.233.66:8080/api/v1/announcements/me"
    
    let provider = MoyaProvider<SponusAPI>(session: Session(interceptor: AuthInterceptor.shared))
    
    
        func fetchReceivedOfferMyAnnouncements(){
            print(#fileID, #function, #line, "")
            AF.request(url, method: .get, headers: headers)
                .publishDecodable(type: MyAnnouncementsModel.self)
                .compactMap{ $0.value }
                .map{ $0.content }
                .sink(receiveCompletion: { completion in
                    print("데이터스트림 완료 ")
                }, receiveValue: { receivedValue in
                    print(receivedValue)
                    print("받은 값 : \(receivedValue.count)")
                    self.myAnnouncementsContents = receivedValue
                }).store(in: &subscription)
        }
    
//    func fetchReceivedOfferMyAnnouncements(){
//        
//        provider.request(.getReceivedOfferMyAnnouncements) { result in
//            switch result {
//            case .success(let response):
//                print(response.statusCode)
//                //                if response.data.isEmpty {
//                //                    renewToken()
//                //                }
//                print(response.data)
//                if let jsonString = String(data: response.data, encoding: .utf8) {
//                    print("서버 응답 JSON 데이터: \(jsonString)")
//                }
//                do {
//                    let myAnnouncements = try JSONDecoder().decode(MyAnnouncementsModel.self, from: response.data)
//                    DispatchQueue.main.async {
//                        self.myAnnouncementsContents = myAnnouncements.content
//                        self.myAnnouncementsContents.sort {$0.updatedAt > $1.updatedAt}
//                        print(self.myAnnouncementsContents)
//                    }
//                } catch {
//                    print("JSON 디코딩 오류: \(error)")
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
}
