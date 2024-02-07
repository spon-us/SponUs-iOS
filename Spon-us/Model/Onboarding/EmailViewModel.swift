//
//  EmailViewModel.swift
//  Spon-us
//
//  Created by yubin on 2/7/24.
//

import Foundation
import Combine
import Moya

class EmailViewModel: ObservableObject {
    @Published var email: EmailModel?
    private let provider = MoyaProvider<SponusAPI>(plugins: [NetworkLoggerPlugin()])

    func postEmail(email: String) {
        provider.request(.postEmail(email: email)) { result in
            switch result {
            case let .success(response):
                do {
                    let emailResponse = try response.map(EmailModel.self)
                    self.email = emailResponse
                } catch {
                    print("Error parsing response: \(error)")
                }

            case let .failure(error):
                print("Network request failed: \(error)")
            }
        }
    }
}
