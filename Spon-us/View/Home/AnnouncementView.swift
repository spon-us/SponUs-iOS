//
//  AnnouncementView.swift
//  Spon-us
//
//  Created by yubin on 1/30/24.
//

import SwiftUI

struct AnnouncementView: View {
    @State var sectionTitle: String
    @State var listStatus: ListStatus
    
    var width = UIScreen.screenWidth - 10
    
    struct ListStatus {
        var recommend = true
        var best = false
        var recent = false
    }
    
    var recommendButton: some View {
        Button {
            updateSectionTitle("RECOMMEND")
            $listStatus.recommend.wrappedValue = true
            $listStatus.best.wrappedValue = false
            $listStatus.recent.wrappedValue = false
        } label: {
            if ($listStatus.recommend.wrappedValue) {
                Text("스포너스 추천")
                    .font(.Body09)
                    .foregroundStyle(.sponusBlack)
            } else {
                Text("스포너스 추천")
                    .font(.Body09)
                    .foregroundStyle(.sponusGrey600)
            }
        }
    }
    
    var bestButton: some View {
        Button {
            updateSectionTitle("BEST")
            $listStatus.recommend.wrappedValue = false
            $listStatus.best.wrappedValue = true
            $listStatus.recent.wrappedValue = false
        } label: {
            if ($listStatus.best.wrappedValue) {
                Text("실시간 인기")
                    .font(.Body09)
                    .foregroundStyle(.sponusBlack)
            } else {
                Text("실시간 인기")
                    .font(.Body09)
                    .foregroundStyle(.sponusGrey600)
            }
        }
    }
    
    var recentButton: some View {
        Button {
            updateSectionTitle("RECENT")
            $listStatus.recommend.wrappedValue = false
            $listStatus.best.wrappedValue = false
            $listStatus.recent.wrappedValue = true
        } label: {
            if ($listStatus.recent.wrappedValue) {
                Text("최근 본")
                    .font(.Body09)
                    .foregroundStyle(.sponusBlack)
            } else {
                Text("최근 본")
                    .font(.Body09)
                    .foregroundStyle(.sponusGrey600)
            }
        }
    }
    
    let searchItem: some View = {
        NavigationLink {
            SearchView()
        } label: {
            Image("ic_search")
        }
    }()
    
    var body: some View {
        VStack(spacing: 26) {
            Text(sectionTitle)
                .font(
                    Font.custom("SUIT", size: 30)
                        .weight(.bold)
                )
                .foregroundColor(Color.sponusBlack)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ZStack {
                Rectangle().frame(width: UIScreen.screenWidth - 50, height: 1).foregroundStyle(.sponusGrey500)
                    .padding(.top, 35)
                
                HStack(spacing: 0) {
                    VStack(spacing: 0) {
                        recommendButton
                            .padding(.bottom, 18)
                            .frame(width: width * 0.3)
                        if ($listStatus.recommend.wrappedValue) {
                            Rectangle()
                                .frame(width: width * 0.3, height: 2)
                                .foregroundStyle(.sponusPrimary)
                        }
                    }
                    
                    VStack(spacing: 0) {
                        bestButton
                            .padding(.bottom, 18)
                            .frame(width: width * 0.3)
                        if ($listStatus.best.wrappedValue) {
                            Rectangle()
                                .frame(width: width * 0.3, height: 2)
                                .foregroundStyle(.sponusPrimary)
                        }
                    }
                    
                    VStack(spacing: 0) {
                        recentButton
                            .padding(.bottom, 18)
                            .frame(width: width * 0.3)
                        if ($listStatus.recent.wrappedValue) {
                            Rectangle()
                                .frame(width: width * 0.3, height: 2)
                                .foregroundStyle(.sponusPrimary)
                        }
                    }
                }
            }
            
            ScrollView {
                VStack {
                    
                }
            }
        }
        .padding(.horizontal, 20)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton(), trailing: HStack {
            searchItem
        })
        .toolbar(.hidden, for: .tabBar)
    }
    
    private func updateSectionTitle(_ title: String) {
        sectionTitle = title
    }
}

#Preview {
    AnnouncementView(sectionTitle: "RECOMMEND", listStatus: AnnouncementView.ListStatus(recommend: true, best: false, recent: false))
}
