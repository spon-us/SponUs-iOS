//
//  JoinViewModel.swift
//  Spon-us
//
//  Created by 박현수 on 2/9/24.
//

import Foundation
import Combine
import Moya

class JoinViewModel: ObservableObject {
    @Published var join: JoinModel?
    @Published var isButtonEnabled = false
    private let provider = MoyaProvider<SponusAPI>(plugins: [NetworkLoggerPlugin()])

    func postJoin(name: String, email: String, password: String, orgType: OrgType, subOrgType: SubOrgType?) {
        provider.request(.postJoin(name: name, email: email, password: password, orgType: orgType, subOrgType: subOrgType)) { result in
            switch result {
            case let .success(response):
                do {
                    if response.statusCode == 200 {
                        self.isButtonEnabled = true
                    }
                    print(self.isButtonEnabled)
                    print(try response.mapJSON())
                    let joinResponse = try response.map(JoinModel.self)
                    self.join = joinResponse
                } catch {
                    print("Error parsing response: \(error)")
                }

            case let .failure(error):
                print("Network request failed: \(error)")
            }
        }
    }
}
