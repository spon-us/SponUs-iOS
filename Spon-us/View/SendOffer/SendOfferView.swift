//
//  SendOfferView.swift
//  Spon-us
//
//  Created by yubin on 1/18/24.
//

import SwiftUI

struct SendOfferView: View {
    var body: some View {
        if hasData() {
            ScrollView {
                VStack(spacing: 0) {
                    
                    Text("12.20 WED")
                        .font(.English01)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color.sponusBlack)
                        .padding(.top, 32)
                    
                    Rectangle()
                        .fill(Color.sponusBlack)
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .padding(.top, 8)
                    
                    ForEach(1 ..< 4) { item in
                        SendOfferCell(status: getStatus(for: item))
                    }
                    
                }
                .padding(.horizontal, 20)
            }
            .navigationTitle("보낸 제안").font(.Body01)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButton())
            .toolbar(.hidden, for: .tabBar)
        } else {
            Text("현재 보낸 제안이 없습니다")
                .font(.Body06)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.sponusGrey900)
                .navigationTitle("보낸 제안").font(.Body01)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: CustomBackButton())
                .toolbar(.hidden, for: .tabBar)
        }
    }
    
    func getStatus(for index: Int) -> String {
        switch index {
        case 1:
            return "수락"
        case 2:
            return "거절"
        case 3:
            return "열람"
        default:
            return "DefaultStatus"
        }
    }
    
    func hasData() -> Bool {
        return true
    }
}

struct SendOfferCell: View {
    var status: String
    
    var body: some View {
        HStack(spacing: 0) {
            ZStack {
                Image("musinsa")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 158, height: 158)
                    .padding(.trailing, 20)
                
                StatusBadge(status: status)
                    .offset(x: 50.5, y: -66.5)
            }
            
            LazyVStack(alignment: .leading, spacing: 12) {
                Text("연계 프로젝트")
                    .font(.Caption02)
                    .foregroundColor(Color.sponusGrey700)
                
                
                Text("무신사 글로벌 마케팅\n연계 프로젝트")
                    .font(.Body07)
                    .foregroundColor(Color.sponusBlack)
                
                NavigationLink(destination:
                                SendOfferPostView(),
                               label: {
                    HStack {
                        Text("보낸 제안서")
                            .font(.Body10)
                            .padding(.leading, 5)
                        
                        Image("ic_go_blue")
                            .frame(width: 16, height: 16)
                            .padding(.leading, -3)
                    }
                    .foregroundStyle(Color.sponusPrimary)
                    .padding(.vertical, 11)
                    .padding(.horizontal, 10)
                    .overlay(
                        Rectangle()
                            .stroke(Color.sponusPrimary, lineWidth: 1)
                    )
                })
            }
            .padding(.trailing, 15)
        }
        .padding(.top, 16)
    }
}

struct StatusBadge: View {
    var status: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Text(status)
                .font(.Caption01)
                .foregroundColor(textColor(for: status))
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 4)
        .background(backgroundColor(for: status))
    }
    
    private func backgroundColor(for status: String) -> Color {
        switch status {
        case "수락":
            return Color.sponusSecondary
        case "거절":
            return Color.sponusRedSecondary
        case "열람":
            return Color.sponusGrey100
        default:
            return Color.clear
        }
    }
    
    private func textColor(for status: String) -> Color {
        switch status {
        case "수락":
            return Color.sponusPrimary
        case "거절":
            return Color.sponusRed
        case "열람":
            return Color.sponusGrey700
        default:
            return Color.white
        }
    }
    
    private func borderColor(for status: String) -> Color {
        switch status {
        case "수락":
            return Color.sponusPrimary
        case "거절":
            return Color.red
        case "열람":
            return Color.yellow
        default:
            return Color.clear
        }
    }
}

#Preview {
    SendOfferView()
}
