//
//  OrganizationViewModel.swift
//  Spon-us
//
//  Created by yubin on 2/13/24.
//

import Foundation
import Combine
import Moya

class MyOrganizationViewModel: ObservableObject {
    @Published var myOrganization: OrganizationResponse?

    private let provider = MoyaProvider<SponusAPI>()

    func fetchMyOrganization() {
        provider.request(.getMe) { result in
            switch result {
            case let .success(response):
                do {
                    let myOrganizationResponse = try response.map(OrganizationModel.self)
                    self.myOrganization = myOrganizationResponse.content
                } catch {
                    print("Error parsing response: \(error)")
                }

            case let .failure(error):
                print("Network request failed: \(error)")
            }
        }
    }
}
