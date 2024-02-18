//
//  CategoryView.swift
//  Spon-us
//
//  Created by yubin on 1/11/24.
//

import SwiftUI

import SwiftUI

struct CategoryView: View {
    
    var categoryList = ["전체", "기획/아이디어", "광고/마케팅", "디자인", "사진/영상", "IT/소프트웨어/게임", "기타"]
    var categoryDetailList = ["전체", "협찬", "제휴", "연계프로젝트"]
    
    @State var selectedCategoryList = "전체"
    @State var selectedCategoryDetailList = "전체"
    @StateObject private var categoryModelData = CategoryModelData()
    
    private func updateCategoryModelData() {
        let category = changeToEnglish(category: selectedCategoryList)
        let type = changeToEnglish(type: selectedCategoryDetailList)
        categoryModelData.setAPIValue(category: category, type: type)
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("CATEGORY")
                        .font(
                            Font.custom("SUIT", size: 30).weight(.bold)
                        )
                        .foregroundColor(Color.sponusBlack)
                        .padding(.bottom, 20)
                    
                    ZStack(alignment: .top) {
                        SponUsDivider()
                            .foregroundColor(.sponusGrey100)
                            .padding(.bottom, 12)
                            .padding(.top, 1)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 32) {
                                ForEach(categoryList, id: \.self) { category in
                                    CategoryListCell(categoryList: category, selectedCategoryList: $selectedCategoryList, selectedCategoryDetailList: $selectedCategoryDetailList)
                                }
                            }
                        }
                    }
                    .padding(.bottom, 20)
                    
                    ZStack(alignment: .top) {
                        SponUsDivider()
                            .foregroundColor(.sponusGrey100)
                            .padding(.bottom, 12)
                            .padding(.top, 1)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 32) {
                                ForEach(categoryDetailList, id: \.self) { category in
                                    CategoryListDetailCell(categoryDetailList: category, selectedCategoryList: $selectedCategoryList, selectedCategoryDetailList: $selectedCategoryDetailList)
                                }
                            }
                        }
                    }
                    .padding(.bottom, 10)
                }
                .padding(.leading, 20)
                
                if categoryModelData.isLoading {
                    VStack(){
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                } else {
                    ScrollView{
                        VStack {
                            Spacer().frame(height: 30)
                            
                            ForEach(categoryModelData.categoryModelDatas, id: \.id) { categoryContent in
                                CategoryCell(categoryContent: categoryContent)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }
            .navigationBarItems(trailing: Image("ic_search"))
            .onAppear {
                let category = changeToEnglish(category: selectedCategoryList)
                let type = changeToEnglish(type: selectedCategoryDetailList)
                categoryModelData.setAPIValue(category: category, type: type)
            }.onChange(of: selectedCategoryList) { newValue in
                updateCategoryModelData()
            }
            .onChange(of: selectedCategoryDetailList) { newValue in
                updateCategoryModelData()
            }
        }
    }
}

struct CategoryListCell: View {
    var categoryList: String
    @Binding var selectedCategoryList: String
    @Binding var selectedCategoryDetailList: String
    
    var body: some View {
        
        Button(action: {
            selectedCategoryList = categoryList
            print(selectedCategoryList)
        }, label: {
            VStack {
                Rectangle()
                    .fill(categoryList == selectedCategoryList ? Color.sponusPrimary : Color.clear)
                    .frame(height: 3)
                
                Button(action: {
                    selectedCategoryList = categoryList
                }, label: {
                    Text(categoryList)
                        .font(.Body10)
                        .foregroundColor(categoryList == selectedCategoryList ? Color.sponusBlack : Color.sponusGrey600)
                })
            }
        })
        .onChange(of: selectedCategoryList) { newValue in
            selectedCategoryDetailList = "전체"
        }
    }
}

struct CategoryListDetailCell: View {
    var categoryDetailList: String
    
    @Binding var selectedCategoryList: String
    @Binding var selectedCategoryDetailList: String
    
    var body: some View {
        Button(action: {
            selectedCategoryDetailList = categoryDetailList
            print(selectedCategoryDetailList)
        }, label: {
            VStack{
                Rectangle()
                    .fill(categoryDetailList == selectedCategoryDetailList ? Color.sponusPrimary : Color.clear)
                    .frame(height: 3)
                
                Button(action: {
                    selectedCategoryDetailList = categoryDetailList
                }, label: {
                    Text(categoryDetailList)
                        .font(.Body10)
                        .foregroundColor(categoryDetailList == selectedCategoryDetailList ? Color.sponusBlack : Color.sponusGrey600)
                })
            }
        })
    }
}

struct CategoryCell: View {
    
    var categoryContent: CategoryContent
    @State private var isBookmarked = false
    
    var body: some View {
        NavigationLink{SearchPostView(announcementId: categoryContent.id, selectedSaveButton: $isBookmarked)} label: {
            VStack(spacing: 0){
                HStack(alignment: .top, spacing: 0){
                    
                    AsyncImageView(url: URL(string: categoryContent.mainImage.url))
                        .frame(width: 95, height: 95)
                        .clipped()
                        .padding(.trailing, 16)
                    
                    VStack(alignment: .leading, spacing: 0){
                        Text(categoryContent.writerName).font(.Caption04).foregroundColor(.sponusGrey700).padding(.bottom, 4)
                        
                        Text(categoryContent.title).font(.Body10).multilineTextAlignment(.leading).padding(.bottom, 8).foregroundColor(.sponusBlack)
                        
                        Spacer()
                        
                        HStack{
                            Text(changeToKorean(category: categoryContent.category) ?? "전체")
                                    .font(
                                        Font.custom("Pretendard", size: 10)
                                            .weight(.medium)
                                    )
                                    .foregroundColor(Color.sponusPrimary)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(
                                        Rectangle()
                                            .fill(Color.sponusSecondary)
                                    )
                            
                            Text(changeToKorean(type: categoryContent.type) ?? "전체")
                                    .font(
                                        Font.custom("Pretendard", size: 10)
                                            .weight(.medium)
                                    )
                                    .foregroundColor(Color.sponusPrimary)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(
                                        Rectangle()
                                            .fill(Color.sponusSecondary)
                                    )
                            
                            Spacer()
                        }
                    }.frame(width: 160, height: 95).padding(.trailing, 36)
                    
                    Button(action: {toggleBookmark()
                        print(categoryContent.id)}){
                        Image(isBookmarked ? "ic_saved_check" : "ic_saved")
                                .frame(width: 28, height: 28)
                    }
                }
                .padding(.bottom, 16)
                .padding(.top, 7)
                
                SponUsDivider().foregroundColor(.sponusGrey100)
            }
        }
    }
    
    func toggleBookmark(){
        isBookmarked.toggle()
        if isBookmarked {
            print("추가") //api
        } else {
            print("해제") //api
        }
    }
}

#Preview {
    CategoryView()
}
