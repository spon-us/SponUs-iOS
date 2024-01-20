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
                VStack(spacing: 0){
                    
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
            
            LazyVStack(alignment: .leading, spacing: 12){
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
            }.padding(.trailing, 15)
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

struct SendOfferPostView: View {
    @State var popup = false
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack(spacing: 0){
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 10) {
                            ForEach(1...3, id: \.self) { index in
                                Image("post\(index)")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 380)
                                
                                    .containerRelativeFrame(.horizontal)
                                    .scrollTransition(.animated, axis: .horizontal) { content, phase in
                                        content
                                            .opacity(phase.isIdentity ? 1.0 : 0.8)
                                            .scaleEffect(phase.isIdentity ? 1.0 : 0.8)
                                    }
                                
                            }
                        }
                        .scrollTargetLayout()
                        
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .safeAreaPadding(.horizontal, 40.0)
                    
                    LazyVStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Text("스포대학교 총학생회")
                                .font(.Body10)
                                .foregroundColor(Color.sponusPrimary)
                            
                            Image("ic_go_blue")
                                .frame(width: 16, height: 16)
                        }
                        .padding(.top, 23)
                        
                        Text("스포대학교에서\n무신사와의 협업을 제안합니다")
                            .font(.Heading05)
                            .foregroundColor(Color.sponusBlack)
                            .padding(.top, 16)
                        
                        Rectangle()
                            .fill(Color.sponusGrey200)
                            .frame(maxWidth: .infinity, maxHeight: 1)
                            .padding(.top, 16)
                        
                        Text("제안 상세")
                            .font(.Body10)
                            .foregroundColor(Color.sponusGrey700)
                            .padding(.top, 24)
                        
                        Text("안녕하세요 스포대학교 제 21대 학생회 스포너스입니다. 저희 스포대학교는 학생수 2000명의 종합대학으로, 대학생에게 알리고 싶은 제품이나 기업을 홍보하기에 적합할 것이라 생각합니다. 이에 협력을 제안합니다.  활동 내용: 카드뉴스 제작, 배너 제작, 기업 인스타그램 태그 이벤트  그 외의 내용은 상세 협의 후 정하고 싶습니다.")
                            .font(.Body10)
                            .foregroundColor(.black)
                            .padding(.top, 24)
                        
                        Rectangle()
                            .fill(Color.sponusGrey200)
                            .frame(maxWidth: .infinity, maxHeight: 1)
                            .padding(.top, 24)
                        
                        SendOfferPostCell(status: "수락")
                            .padding(.vertical, 16)
                        
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 20)
                
            }
            
            NavigationLink(destination: EmptyView(), label: {
                ZStack(alignment: .leading) {
                    Text("담당자 정보 확인하기")
                        .font(.Body01)
                        .foregroundColor(Color.sponusPrimaryDarkmode)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 20)
                    
                    Button(action: {
                        
                    }) {
                        Image("ic_share_white")
                            .frame(width: 24, height: 24)
                            .padding(.top, 20)
                            .padding(.leading, 40)
                    }
                }
                .background(Color.sponusBlack)
            })
        }
        .navigationTitle("보낸 제안").font(.Body01)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton(), trailing: Image("ic_home_black"))
    }
}

struct SendOfferPostCell: View {
    var status: String
    
    var body: some View {
        HStack(spacing: 0) {
            ZStack {
                Image("musinsa")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 158, height: 158)
                    .padding(.trailing, 20)
                
                StatusBadge(status: "수락")
                    .offset(x: 50.5, y: -66.5)
            }
            
            LazyVStack(alignment: .leading, spacing: 12){
                Text("연계 프로젝트")
                    .font(.Caption02)
                    .foregroundColor(Color.sponusGrey700)
                
                
                Text("무신사 글로벌 마케팅\n연계 프로젝트")
                    .font(.Body07)
                    .foregroundColor(Color.sponusBlack)
                
                NavigationLink(destination: EmptyView(), label: {
                    HStack {
                        Text("공고 보기")
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
            }.padding(.trailing, 15)
        }
        .padding(.top, 16)
    }
}

#Preview {
    SendOfferView()
}

#Preview {
    SendOfferPostView()
}
