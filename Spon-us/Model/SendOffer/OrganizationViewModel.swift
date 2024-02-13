//
//  OrganizationViewModel.swift
//  Spon-us
//
//  Created by yubin on 2/14/24.
//

import Foundation
import Combine
import Moya

class OrganizationViewModel: ObservableObject {
    @Published var organization: OrganizationResponse?

    private let provider = MoyaProvider<SponusAPI>()

    func fetchOrganization(organizationId : Int) {
        provider.request(.getOrganization(organizationId: organizationId)) { result in
            switch result {
            case let .success(response):
                do {
                    let organizationResponse = try response.map(OrganizationModel.self)
                    self.organization = organizationResponse.content
                    //print("담당자 정보 \(self.organization)")
                } catch {
                    print("Error parsing response: \(error)")
                }

            case let .failure(error):
                print("Network request failed: \(error)")
            }
        }
    }
}
