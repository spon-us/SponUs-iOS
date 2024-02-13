//
//  CategoryModelData.swift
//  Spon-us
//
//  Created by 김수민 on 2/12/24.
//

import Foundation
import Moya
import SwiftUI

class CategoryModelData: ObservableObject {
    @Published var category: String?
    @Published var type: String?
    @Published var isLoading = false
    @Published var categoryModelDatas: [CategoryContent] = []
    
    let provider = MoyaProvider<SponusAPI>()
    
    func setAPIValue(category: String?, type: String?) {
        self.isLoading = true
        provider.request(.getCategory(category: category, type: type)) { result in
            switch result {
            case .success(let response):
                    if let jsonString = String(data: response.data, encoding: .utf8) {
                        print("서버 응답 JSON 데이터: \(jsonString)")
                    }

                    do {
                        let categoryModelData = try JSONDecoder().decode(CategoryModel.self, from: response.data)
                        DispatchQueue.main.async {
                            self.categoryModelDatas = categoryModelData.content
                            self.isLoading = false
                            print(self.categoryModelDatas)
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
