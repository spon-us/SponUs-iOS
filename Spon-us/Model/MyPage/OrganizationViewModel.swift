//
//  OrganizationViewModel.swift
//  Spon-us
//
//  Created by yubin on 2/13/24.
//

import Foundation
import Combine
import Moya

class OrganizationViewModel: ObservableObject {
    @Published var organization: OrganizationResponse?
    @Published var errorMessage: String?

    private let provider = MoyaProvider<SponusAPI>()

    func fetchMyOrganization() {
        provider.request(.getMe) { result in
            switch result {
            case let .success(response):
                do {
                    let organizationResponse = try response.map(OrganizationModel.self)
                    self.organization = organizationResponse.content
                } catch {
                    self.errorMessage = "Error parsing response: \(error)"
                }

            case let .failure(error):
                self.errorMessage = "Network request failed: \(error)"
            }
        }
    }
}
