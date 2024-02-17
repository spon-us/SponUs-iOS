//
//  SearchView.swift
//  Spon-us
//
//  Created by 김수민 on 1/13/24.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel = SearchOrganizationViewModel()
    @ObservedObject var viewModelAnnouncement = SearchAnnouncementViewModel()
    @State private var searchData: String = ""
    var dummyData1: Array<String> = ["무신사 글로벌 마케팅 연계 프로젝트", "무신사 오프라인 스토어 홍보 방안", "무신사 앰버서더 선정 프로젝트"]
    var dummyData2: Array<String> = ["무신사", "패션/IT"]
    var dummyData3: Array<String> = ["무신사협업", "코카콜라", "해커스", "바른안과", "대학생제휴", "연계", "무신사", "노티드"]
    
    var body: some View {
        VStack(spacing: 0){
            SearchBarView(searchData: $searchData).onChange(of: searchData) { newValue in
                // keyword 값이 바뀔 때마다 검색 실행
                viewModel.getSearchOrganization(keyword: newValue)
                viewModelAnnouncement.getSearchAnnouncement(keyword: newValue)
            }
            SponUsDivider().frame(width: 335)
                .foregroundColor(searchData=="" ? .sponusBlack : .sponusPrimary)
                .padding(.bottom, 48)
                .padding(.top, 0)
            NavigationView {
                if (searchData == ""){
                    VStack(alignment: .leading, spacing: 36){
                        VStack(alignment: .leading, spacing: 16){
                            HStack(){
                                Text("최근 검색어").font(.Body01)
                                Spacer()
                            }
                            VStack(spacing: 8){
                                HStack(spacing: 8){
                                    ForEach(0..<3, id: \.self){index in
                                        SearchCategoryButton(content: dummyData3[index], isDelete: true)
                                    }
                                    Spacer()
                                }
                                HStack(spacing: 8){
                                    ForEach(0..<3, id: \.self){index in
                                        SearchCategoryButton(content: dummyData3[3+index], isDelete: true)
                                    }
                                    Spacer()
                                }
                                HStack(spacing: 8){
                                    ForEach(0..<2, id: \.self){index in
                                        SearchCategoryButton(content: dummyData3[6+index], isDelete: true)
                                    }
                                    Spacer()
                                }
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 16){
                            Text("스포너스 추천 검색어").font(.Body01)
                            HStack(spacing: 8){
                                SearchCategoryButton(content: "마케팅", isDelete: false)
                                SearchCategoryButton(content: "디자인", isDelete: false)
                                SearchCategoryButton(content: "연계 프로젝트", isDelete: false)
                            }
                        }
                        Spacer()
                    }.padding(.horizontal, 20)
                } else {
                    VStack(alignment: .leading, spacing: 16){
                        HStack(){
                            Text("공고 정보").font(.Body06)
                            Spacer()
                        }
                        ForEach(viewModelAnnouncement.searchAnnouncementContents, id: \.self){ index in
                            NavigationLink(destination: /*SearchPostView()*/Text("")){
                                HStack(spacing: 0) {
                                    ForEach(splitText(index.title, with: searchData), id: \.self) { text in
                                            Text(text)
                                            .foregroundColor(text == searchData ? .sponusPrimary : .sponusGrey800).font(.Body05)
                                    }
                                }
                            }
                            SponUsDivider().foregroundColor(.sponusGrey100)
                        }
    
                        Text("기업 정보").font(.Body06)
                        VStack(){
                            ForEach(viewModel.searchOrganizationContents, id: \.self) {index in
                                HStack(spacing: 12){
                                    AsyncImageView(url: URL(string: index.image ?? ""))
                                        .frame(width: 46, height: 46)
//                                    Image("company_dummy").frame(width: 46, height: 46)
                                    VStack(spacing: 1){
                                        HStack(spacing: 0) {
                                            ForEach(splitText(index.name, with: searchData), id: \.self) { text in
                                                Text(text)
                                                    .foregroundColor(text == searchData ? .sponusPrimary : .sponusGrey800).font(.Body05)
                                            }
                                            Spacer()
                                        }
                                        if (index.tags.count != 0){
                                            HStack() {
                                                Text("\(index.tags[0].name), \(index.tags[1].name)").foregroundColor(.sponusGrey700).font(.Body10)
                                                Spacer()
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        Spacer()
                    }.padding(.horizontal, 20)
                }
                Spacer()
            }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        }
        .navigationBarHidden(true)
    }
    func splitText(_ text: String, with keyword: String) -> [String] {
        var parts: [String] = []
        let components = text.components(separatedBy: keyword)
        for (index, component) in components.enumerated() {
            if !component.isEmpty {
                parts.append(component)
            }
            if index < components.count - 1 {
                parts.append(keyword)
            }
        }
        return parts
    }
}

struct SearchBarView: View {
    @Binding var searchData: String
    var body: some View {
        HStack(spacing: 24){
            CustomBackButton()
            TextField("검색어를 입력하세요", text: $searchData)
                .textFieldStyle(SearchTextfieldStyle())
                .frame(height: 26)
                .onChange(of: searchData) { newData in
                    searchData = newData
                }
            Spacer()
            Image("ic_search")
        }
        .padding(.leading, 16)
        .padding(.trailing, 20)
        .padding(.vertical, 19)
    }
}

struct SponUsDivider: View {
    var body: some View {
        Rectangle()
            .frame(maxWidth: .infinity, maxHeight: 1)
    }
}


struct SearchTextfieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
            configuration
                .font(.Body04)
                .padding(16)
    }
}

struct SearchCategoryButton: View {
    let content: String
    let isDelete: Bool
    var body: some View {
        HStack(){
            Text(content).font(.Body08).foregroundColor(.sponusBlack)
            if isDelete {
                Button(action: {}){
                    Image("ic_cancel").frame(width: 16, height: 16)
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .frame(height: 40)
        .overlay(
            RoundedRectangle(cornerRadius: 99)
                .stroke(.sponusGrey500)
        )
    }
}

#Preview {
    SearchView()
}
