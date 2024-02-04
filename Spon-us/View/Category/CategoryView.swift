//
//  CategoryView.swift
//  Spon-us
//
//  Created by yubin on 1/11/24.
//

import SwiftUI

import SwiftUI

struct CategoryView: View {
    
    var categoryList = ["전체", "기획/아이디어", "광고마케팅", "디자인", "사진/영상", "IT/소프트웨어/게임", "기타"]
    var categoryDetailList = ["전체", "협찬", "제휴", "연계프로젝트"]
    
    @State var selectedCategoryList = "전체"
    @State var selectedCategoryDetailList = "전체"
    
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("CATEGORY")
                        .font(
                            Font.custom("SUIT", size: 30)
                                .weight(.bold)
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
                
                ScrollView{
                    VStack{
                        Spacer().frame(height: 30)
                        
                        ForEach(0..<10) { cell in
                            CategoryCell()
                        }
                        
                        
                    }
                    .padding(.horizontal, 20)
                }
                
            }
            .navigationBarItems(trailing:
                                    Image("ic_search")
            )
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
            VStack{
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
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 0){
                Rectangle()
                    .frame(width: 95, height: 95)
                    .padding(.trailing, 16)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("무신사")
                        .font(.Caption04)
                      .foregroundColor(Color.sponusGrey700)
                      .padding(.top, 4)
                    

                    Text("무신사 글로벌 마케팅")
                        .font(.Body10)
                      .foregroundColor(Color.sponusBlack)
                    
                    Text("연계프로젝트")
                        .font(.Body10)
                      .foregroundColor(Color.sponusBlack)
                      .padding(.bottom, 4)
                    
                    Spacer()
                    
                    HStack{
                        Text("기획/아이디어")
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
                        
                        Text("디자인")
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
                    }
                      
                }
                Spacer()
                
                Image("ic_saved")
                    .padding(.top, 4)
                
            }
            .padding(.bottom, 16)
            
            SponUsDivider()
              .foregroundColor(Color.sponusGrey100)
        }
    }
}


#Preview {
    CategoryView()
}

