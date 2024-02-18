//
//  SavedView.swift
//  Spon-us
//
//  Created by 김수민 on 1/11/24.
//

import SwiftUI

struct SavedView: View {
    @State private var selectedColumn: Int = 0

    @StateObject var savedListViewModel = SavedListViewModel()
    var sortValue: String = "RECENT"
    
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
//                        ForEach(0..<6) { index in
//                            SavedListCell()
//                        }
                        
                        
//                        if selectedColumn == 0 {
//                            let sortValue = "RECENT"
//                            savedListViewModel.fetchSaved(sort: sortValue)
//                        }
                        
                        ForEach(savedListViewModel.savedResponse, id: \.id) { item in
                            SavedListCell(data: item)
                        }  
                    }.onChange(of: selectedColumn){
                        if selectedColumn == 0 {
                            let sortValue = "RECENT"
                            savedListViewModel.fetchSaved(sort: sortValue)
                        } else if selectedColumn == 1 {
                            let sortValue = "VIEWED"
                            savedListViewModel.fetchSaved(sort: sortValue)
                        } else {
                            let sortValue = "SAVED"
                            savedListViewModel.fetchSaved(sort: sortValue)
                        }
                    }
                }
            }.padding(.horizontal, 20)
        }
        .onAppear() {
            savedListViewModel.fetchSaved(sort: sortValue)
        }
    }
}

struct ColumnPicker: View {
    @Binding var selectedColumn: Int
    @ObservedObject var savedListViewModel = SavedListViewModel()
    @ObservedObject var savedViewModel = SavedViewModel()
    
    var body: some View {
        VStack(){
            SponUsDivider().foregroundColor(.sponusGrey100)
            HStack(spacing: 0){
                Button(action: {selectedColumn = 0}){
                    VStack(spacing: 6){
                        Text("최근저장순")
                            .font(.Body09)
                            .foregroundColor(selectedColumn == 0 ? .sponusBlack : .sponusGrey600)
                        //Text(String(savedListViewModel.savedResponse.count)).font(.Body09).foregroundColor(selectedColumn == 0 ? .sponusBlack : .sponusGrey600)
                    }.padding(.horizontal, 24).padding(.vertical, 20)
                }
                Button(action: {selectedColumn = 1}){
                    VStack(spacing: 6){
                        Text("조회많은순")
                            .font(.Body09)
                            .foregroundColor(selectedColumn == 1 ? .sponusBlack : .sponusGrey600)
                        //Text(String(savedListViewModel.savedResponse.count)).font(.Body09).foregroundColor(selectedColumn == 1 ? .sponusBlack : .sponusGrey600)
                    }.padding(.horizontal, 24).padding(.vertical, 20)
                }
                Button(action: {selectedColumn = 2}){
                    VStack(spacing: 6){
                        Text("저장많은순")
                            .font(.Body09)
                            .foregroundColor(selectedColumn == 2 ? .sponusBlack : .sponusGrey600)
                        //Text(String(savedListViewModel.savedResponse.count)).font(.Body09).foregroundColor(selectedColumn == 2 ? .sponusBlack : .sponusGrey600)
                    }.padding(.horizontal, 24).padding(.vertical, 20)
                }
            }
            .frame(height: 88)
            SponUsDivider().foregroundColor(.sponusGrey100)
        }
    }
}

struct SavedListCell: View {
    var data: SavedListResponse
    @ObservedObject var savedViewModel = SavedViewModel()

    var body: some View {
        Button(action: {}){
            VStack(spacing: 0){
                HStack(alignment: .top, spacing: 0){
                    AsyncImageView(url: URL(string: data.mainImage.url))
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 95, height: 95)
                        .clipped()
                        .padding(.trailing, 16)
                    
                    VStack(alignment: .leading, spacing: 0){
                        Text(data.writerName)
                            .font(.Caption04)
                            .foregroundColor(.sponusGrey700)
                        
                        Text(data.title)
                            .font(.Body10)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 8)
                            .foregroundColor(.sponusBlack)
                            .padding(.top, 4)
                        
                        HStack{
                            Text(("\(changeToKorean(type: data.type) ?? "전체")"))
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
                            
                            Text(("\(changeToKorean(category: data.category) ?? "전체")"))
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
                        .padding(.top, 8)
                    }.frame(width: 160, height: 95).padding(.trailing, 36)
                    
                    Button(action: {
                        savedViewModel.fetchSaved(organizationId: data.id)
                        print("북마크 체크 아이디\(data.id)")
                    }) {
                        Image(savedViewModel.savedResponse?.bookmarked == true ? "ic_saved_check" : "ic_saved")
                                .frame(width: 28, height: 28)
                    }
                    
                }.padding(.bottom, 16)
                
                SponUsDivider().foregroundColor(.sponusGrey100)
            }
        }
    }
}
