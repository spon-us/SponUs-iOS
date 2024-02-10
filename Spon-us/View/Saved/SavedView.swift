//
//  SavedView.swift
//  Spon-us
//
//  Created by 김수민 on 1/11/24.
//

import SwiftUI

struct SavedView: View {
    var categoryDetailList = ["최근 저장순", "조회 많은순", "저장 많은순"]
    @State private var selectedColumn: Int = 0
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack(){
                    Spacer()
                    Image("ic_search").frame(width: 28, height: 28)
                }.padding(.vertical, 20)
                HStack(){
                    Text("SAVED")
                        .font(Font.custom("SUIT", size: 30).weight(.bold))
                    Spacer()
                }.padding(.bottom, 21)
                ColumnPicker(selectedColumn: $selectedColumn).padding(.bottom, 40)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 16) {
                        ForEach(0..<6) { index in
                            SavedListCell()
                        }
                    }
                }
            }.padding(.horizontal, 20)
        }
    }
}

struct ColumnPicker: View {
    @Binding var selectedColumn: Int
    
    var body: some View {
        VStack(){
            SponUsDivider().foregroundColor(.sponusGrey100)
            HStack(spacing: 0){
                Button(action: {selectedColumn = 0}){
                    VStack(spacing: 6){
                        Text("최근 저장순").font(.Body09).foregroundColor(selectedColumn == 0 ? .sponusBlack : .sponusGrey600)
                        Text("(6)").font(.Body09).foregroundColor(selectedColumn == 0 ? .sponusBlack : .sponusGrey600)
                    }.padding(.horizontal, 24).padding(.vertical, 20)
                }
                Button(action: {selectedColumn = 1}){
                    VStack(spacing: 6){
                        Text("조회 많은순").font(.Body09).foregroundColor(selectedColumn == 1 ? .sponusBlack : .sponusGrey600)
                        Text("(6)").font(.Body09).foregroundColor(selectedColumn == 1 ? .sponusBlack : .sponusGrey600)
                    }.padding(.horizontal, 24).padding(.vertical, 20)
                }
                Button(action: {selectedColumn = 2}){
                    VStack(spacing: 6){
                        Text("저장 많은순").font(.Body09).foregroundColor(selectedColumn == 2 ? .sponusBlack : .sponusGrey600)
                        Text("(6)").font(.Body09).foregroundColor(selectedColumn == 2 ? .sponusBlack : .sponusGrey600)
                    }.padding(.horizontal, 24).padding(.vertical, 20)
                }
            }.frame(height: 88)
            SponUsDivider().foregroundColor(.sponusGrey100)
        }
    }
}

struct SavedListCell: View {
    let title: String = "무신사"
    let detail: String = "무신사 글로벌 마케팅 연계프로젝트"
    let category: [String] = ["디자인", "제휴"]
    @State private var isBookmarked = false
    
    var body: some View {
        Button(action: {}){
            VStack(spacing: 0){
                HStack(alignment: .top, spacing: 0){
                    Image("musinsa").resizable().frame(width: 95, height: 95).padding(.trailing, 16)
                    VStack(alignment: .leading, spacing: 0){
                        Text(title).font(.Caption04).foregroundColor(.sponusGrey700)
                        Text(detail).font(.Body10).multilineTextAlignment(.leading).padding(.bottom, 8).foregroundColor(.sponusBlack)
                        HStack{
                            ForEach(0..<category.count, id: \.self) { index in  Text(category[index])
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
                            Spacer()
                        }
                    }.frame(width: 160, height: 95).padding(.trailing, 36)
                    Button(action: {toggleBookmark()}){
                        Image("ic_saved_check").frame(width: 28, height: 28)
                    }
                }.padding(.bottom, 16)
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
