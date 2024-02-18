//
//  OrganizationViewModel.swift
//  Spon-us
//
//  Created by yubin on 2/13/24.
//

import Foundation
import Combine
import Moya
import Alamofire



//// Construct your request parameters
//let parameters: [String: Any] = [
//    "request": ["name": "string"]
//]
//
//// Construct your headers if needed
//let headers: HTTPHeaders = [
//    "Authorization": "Bearer YOUR_ACCESS_TOKEN",
//    "Content-Type": "application/json"
//]
//
//// Construct your URL
//let url = "https://your.api.endpoint/path"
//
//// Send the PATCH request
//AF.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
//    .responseJSON { response in
//        switch response.result {
//        case .success(let value):
//            print("Request succeeded with response: \(value)")
//            // Handle the response data here
//        case .failure(let error):
//            print("Request failed with error: \(error)")
//            // Handle the error here
//        }
//    }

class MyOrganizationViewModel: ObservableObject {
    @Published var myOrganization: OrganizationResponse?
    
    @Published var patchOrganization: PatchOrganizationModel?
    
    var dictionary: [String: String] = [
        :
    ]
    
    private let provider = MoyaProvider<SponusAPI>(session: Session(interceptor: AuthInterceptor.shared))
    
    func fetchMyOrganization() {
        provider.request(.getMe) { result in
            switch result {
            case let .success(response):
                do {
                    let myOrganizationResponse = try response.map(OrganizationModel.self)
                    self.myOrganization = myOrganizationResponse.content
                    print(myOrganizationResponse)
                } catch {
                    print(try! response.mapJSON())
                    print("Error parsing response: \(error)")
                }
                
            case let .failure(error):
                print("Network request failed: \(error)")
            }
        }
    }
    
    func fetchPatchMyOrganization() {
        let headers: HTTPHeaders = ["Authorization": "Bearer \(loadAccessToken(userID: UserDefaults.standard.string(forKey: "loginAccount") ?? "loadAccessToken Error"))"]
        
        let url = "http://3.38.233.66:8080/api/v1/organizations/me"
        
        print(dictionary)
        
        AF.upload(multipartFormData: { multipartFormData in
            // Append the request parameter as JSON data
            if let requestData = try? JSONSerialization.data(withJSONObject: self.dictionary) {
                multipartFormData.append(requestData, withName: "request")
            }
        }, to: url, method: .patch, headers: headers)
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                print("Request succeeded with response: \(value)")
                // Handle the response data here
            case .failure(let error):
                print("Request failed with error: \(error)")
                // Handle the error here
            }
        }
    }
}
