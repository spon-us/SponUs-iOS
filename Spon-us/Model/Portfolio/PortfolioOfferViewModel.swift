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
    
    let provider = MoyaProvider<SponusAPI>(session: Session(interceptor: AuthInterceptor.shared))
    
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
        
            provider.request(.getMyOffer) { result in
                switch result {
                case let .success(response):
                    do {
                        print(try? response.mapJSON())
                        let myOffers = try JSONDecoder().decode(ProposalModel.self, from: response.data)
                        self.offerContents.append(contentsOf: myOffers.content)
                        completion(true)
                    }
                    catch {
                        print("catcherrororororor")
                        completion(false)
                    }
                case .failure(_):
                    print("failureerrororororo")
                    completion(false)
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
        
        myProposes = Array(Set(myProposes))
        myProposes.sort {$0.proposeId > $1.proposeId}
//        for content in myProposes {
//            if content.status == "SUSPENDED" || content.status == "COMPLETED" {
//                
//            }
//        }
        self.isLoading = false
    }
    
    func stopOffer(proposeId: Int, completion: @escaping (Bool) -> Void) {
        provider.request(.patchChangeOfferStatus(proposeID: proposeId, status: "SUSPENDED")) { result in
            switch result {
            case let .success(response):
                if response.statusCode == 200 {
                    do {
                        print("stopoffer")
                        let responseBody = try JSONDecoder().decode(ChangeAnnouncementStatusModel400.self, from: response.data)
                        print(responseBody)
                        completion(true)
                    }
                    catch {
                        print("200 successError")
                        completion(false)
                    }
                }
                else {
                    do {
                        print(response.statusCode)
                        let responseBody = try JSONDecoder().decode(ChangeAnnouncementStatusModel400.self, from: response.data)
                        print(responseBody)
                        completion(false)
                    }
                    catch {
                        print("40x successError")
                        completion(false)
                    }
                }
            case let .failure(response):
                print(response.errorDescription)
                if let moyaError = response as? MoyaError, let response = moyaError.response {
                    if let responseBody = String(data: response.data, encoding: .utf8) {
                        print("실패 응답 본문: \(responseBody)")
                    }
                }
                print("failureError")
                completion(false)
            }
        }
    }
    
    func cancelStopOffer(proposeId: Int, status: String, completion: @escaping (Bool) -> Void) {
        provider.request(.patchChangeOfferStatus(proposeID: proposeId, status: status)) { result in
            switch result {
            case let .success(response):
                if response.statusCode == 200 {
                    do {
                        let responseBody = try JSONDecoder().decode(ChangeAnnouncementStatusModel400.self, from: response.data)
                        print(responseBody)
                        completion(true)
                    }
                    catch {
                        print("200 successError")
                        completion(false)
                    }
                }
                else {
                    do {
                        let responseBody = try JSONDecoder().decode(ChangeAnnouncementStatusModel400.self, from: response.data)
                        print(responseBody)
                        completion(false)
                    }
                    catch {
                        print("40x successError")
                        completion(false)
                    }
                }
            case .failure(_):
                print("failureError")
                completion(false)
            }
        }
    }
    
    func completeOffer(proposeId: Int, completion: @escaping (Bool) -> Void) {
        provider.request(.patchChangeOfferStatus(proposeID: proposeId, status: "COMPLETED")) { result in
            switch result {
            case let .success(response):
                if response.statusCode == 200 {
                    do {
                        print("여기")
                        let responseBody = try JSONDecoder().decode(ChangeAnnouncementStatusModel400.self, from: response.data)
                        print(responseBody)
                        completion(true)
                    }
                    catch {
                        print("200 successError")
                        completion(false)
                    }
                }
                else {
                    do {
                        print(response.statusCode)
                        let responseBody = try JSONDecoder().decode(ChangeAnnouncementStatusModel400.self, from: response.data)
                        print(responseBody)
                        completion(false)
                    }
                    catch {
                        print("40x successError")
                        completion(false)
                    }
                }
            case let .failure(response):
                print(response.errorDescription)
                if let moyaError = response as? MoyaError, let response = moyaError.response {
                    if let responseBody = String(data: response.data, encoding: .utf8) {
                        print("실패 응답 본문: \(responseBody)")
                    }
                }
                print("failureError")
                completion(false)
            }
        }
    }

    func cancelCompleteOffer(proposeId: Int, status: String, completion: @escaping (Bool) -> Void) {
        provider.request(.patchChangeOfferStatus(proposeID: proposeId, status: status)) { result in
            switch result {
            case let .success(response):
                if response.statusCode == 200 {
                    do {
                        let responseBody = try JSONDecoder().decode(ChangeAnnouncementStatusModel400.self, from: response.data)
                        print(responseBody)
                        completion(true)
                    }
                    catch {
                        print("200 successError")
                        completion(false)
                    }
                }
                else {
                    do {
                        let responseBody = try JSONDecoder().decode(ChangeAnnouncementStatusModel400.self, from: response.data)
                        print(responseBody)
                        completion(false)
                    }
                    catch {
                        print("40x successError")
                        completion(false)
                    }
                }
            case .failure(_):
                print("failureError")
                completion(false)
            }
        }
    }
}
