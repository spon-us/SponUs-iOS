//
//  HomeView.swift
//  Spon-us
//
//  Created by yubin on 1/11/24.
//

import SwiftUI

struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
        }
        label: {
            Image(.icBack)
        }
    }
}

func getAdText(forIndex index: Int) -> String {
    switch index {
    case 1:
        return "지그재그 신규 모델 발굴 프로젝트\n대학생 협업 모집 중"
    case 2:
        return "네이버 플러스 멤버십\n홍보방안 협업 모집 중"
    case 3:
        return "무신사 신학기 마케팅 방안\n대학생 협업 모집 중"
    default:
        return "연계 프로젝트"
    }
}

func getAdPeriod(forIndex index: Int) -> String {
    switch index {
    case 1:
        return "2.17-2.26"
    case 2:
        return "2.24-2.28"
    case 3:
        return "01.08-01.21"
    default:
        return "미정"
    }
}

struct HomeView: View {
    
    @State var isPresented = false
    @State private var progressStatus  = Portfolio.ProgressStatus()
    
    let searchItem: some View = {
        NavigationLink {
            SearchView()
        } label: {
            Image("ic_search")
        }
    }()
    
    let notificationItem: some View = {
        Button(action: {
            
        }) {
            Image("ic_notification")
        }
    }()
    
    var body: some View {
        NavigationView {
            ScrollView {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 15) {
                        ForEach(1...3, id: \.self) { index in
                            ZStack {
                                Image("main_ad\(index)")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 335, height: 402)
                                    .cornerRadius(4)
                                    .containerRelativeFrame(.horizontal)
                                    .scrollTransition(.animated, axis: .horizontal) { content, phase in
                                        content
                                            .opacity(phase.isIdentity ? 1.0 : 0.8)
                                            .scaleEffect(phase.isIdentity ? 1.0 : 0.8)
                                    }
                                
                                VStack {
                                    VStack(alignment: .leading) {
                                        Text("연계 프로젝트")
                                            .font(.English17)
                                            .foregroundColor(Color.sponusPrimary)
                                            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                                            .background(Color.sponusSecondary)
                                            .cornerRadius(99)
                                        
                                        Text(getAdText(forIndex: index))
                                            .font(.Body07)
                                            .foregroundColor(Color.sponusWhite)
                                            .frame(width: 211, alignment: .bottomLeading)
                                            .padding(.top, 8)
                
                                        HStack {
                                            Text(getAdPeriod(forIndex: index))
                                                .font(.English14)
                                                .foregroundColor(Color.sponusGrey600)
                                                .padding(.top, 1)
                                        
                                            Spacer()
                                            
                                            Image("btn_move")
                                        }
                                    }
                                    .padding(.top, 180)
                                    .scrollTransition(.animated, axis: .horizontal) { content, phase in
                                        content
                                            .scaleEffect(phase.isIdentity ? 1.0 : 0.8)
                                    }
                                    
                                    HStack(spacing: 5) {
                                        ForEach(1...3, id: \.self) { dotIndex in
                                            Circle()
                                                .frame(width: 6, height: 6)
                                                .foregroundColor(dotIndex == index ? Color.sponusWhite : Color.gray.opacity(0.0))
                                                .overlay(
                                                    Circle()
                                                        .stroke((dotIndex == index ? Color.sponusGrey800.opacity(0.0) : Color.sponusGrey800) , lineWidth: 1)
                                                )
                                        }
                                    }
                                    .scrollTransition(.animated, axis: .horizontal) { content, phase in
                                        content
                                            .scaleEffect(phase.isIdentity ? 1.0 : 0.8)
                                    }
                                }
                                .padding(.leading, 3)
                            }
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
                .safeAreaPadding(.horizontal, 40.0)
                .padding(.top, 20)
                
                HStack {
                    NavigationLink(destination: ProposalReceivedListView(), label: {
                        VStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 16)
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(Color("sponus_grey50"))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color("sponus_grey200"), lineWidth: 1)
                                    )
                                
                                Image("Paper")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                            }
                            
                            Text("받은 제안")
                                .font(.Body10)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("sponus_grey800")).fixedSize(horizontal: true, vertical: false)
                                .padding(.top, 8)
                        }
                    })
                    
                    Button(action: {
                        
                    }) {
                        VStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 16)
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(Color("sponus_grey50"))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color("sponus_grey200"), lineWidth: 1)
                                    )
                                
                                Image("Send")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                            }
                            
                            Text("보낸 제안")
                                .font(.Body10)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("sponus_grey800"))
                                .fixedSize(horizontal: true, vertical: false)
                                .padding(.top, 8)
                        }
                    }
                    .padding(.leading, 14)
                    
                    NavigationLink {
                        Portfolio(progressStatus: progressStatus)
                    } label: {
                        VStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 16)
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(Color("sponus_grey50"))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color("sponus_grey200"), lineWidth: 1)
                                    )
                                
                                Image("Wallet")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                            }
                            
                            Text("포트폴리오")
                                .font(.Body10)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("sponus_grey800"))
                                .fixedSize(horizontal: true, vertical: false)
                                .padding(.top, 8)
                        }
                        .padding(.leading, 14)
                    }
                    
                    Button(action: {
                        
                    }) {
                        VStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 16)
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(Color("sponus_grey50"))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color("sponus_grey200"), lineWidth: 1)
                                    )
                                
                                Image("Edit")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                            }
                            
                            Text("새 공고 작성")
                                .font(.Body10)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("sponus_grey800"))
                                .fixedSize(horizontal: true, vertical: false)
                                .padding(.top, 8)
                        }
                    }
                    .padding(.leading, 12)
                }
                
                ScrollView(.horizontal) {
                    HStack(spacing: 8) {
                        VStack(alignment:.leading) {
                            HStack {
                                Image("ic_sponus_blue")
                                    .padding(.leading, 20)
                                Spacer()
                                Image("btn_move")
                                    .padding(.trailing, 20)
                            }
                            
                            Text("RECOMMEND")
                                .font(.English11)
                                .foregroundColor(Color("sponus_primary"))
                                .padding(.top, 50)
                                .padding(.leading, 20)
                            
                            Text("스포너스\n추천 공고")
                                .font(.Heading09)
                                .foregroundColor(Color("sponus_black"))
                                .padding(.top, 1)
                                .padding(.leading, 20)
                        }
                        .frame(width: 158, height: 210)
                        .background(
                            Rectangle()
                                .foregroundColor(Color.white)
                                .overlay(
                                    Rectangle()
                                        .inset(by: 0.5)
                                        .stroke(Color("sponus_grey200"), lineWidth: 1)
                                )
                        )
                        
                        VStack(alignment:.leading) {
                            HStack {
                                Image("ic_graph_blue")
                                    .padding(.leading, 20)
                                Spacer()
                                Image("btn_move")
                                    .padding(.trailing, 20)
                            }
                            
                            Text("BEST")
                                .font(.English11)
                                .foregroundColor(Color("sponus_primary"))
                                .padding(.top, 50)
                                .padding(.leading, 20)
                            
                            Text("실시간\n인기 공고")
                                .font(.Heading09)
                                .foregroundColor(Color("sponus_black"))
                                .padding(.top, 1)
                                .padding(.leading, 20)
                        }
                        .frame(width: 158, height: 210)
                        .background(
                            Rectangle()
                                .foregroundColor(Color.white)
                                .overlay(
                                    Rectangle()
                                        .inset(by: 0.5)
                                        .stroke(Color("sponus_grey200"), lineWidth: 1)
                                )
                        )
                        
                        VStack(alignment:.leading) {
                            HStack {
                                Image("ic_eye_blue")
                                    .padding(.leading, 20)
                                Spacer()
                                Image("btn_move")
                                    .padding(.trailing, 20)
                            }
                            
                            Text("RECENT")
                                .font(.English11)
                                .foregroundColor(Color("sponus_primary"))
                                .padding(.top, 50)
                                .padding(.leading, 20)
                            
                            Text("최근에\n본 공고")
                                .font(.Heading09)
                                .foregroundColor(Color("sponus_black"))
                                .padding(.top, 1)
                                .padding(.leading, 20)
                        }
                        .frame(width: 158, height: 210)
                        .background(
                            Rectangle()
                                .foregroundColor(Color.white)
                                .overlay(
                                    Rectangle()
                                        .inset(by: 0.5)
                                        .stroke(Color("sponus_grey200"), lineWidth: 1)
                                )
                        )
                    }
                    .padding(.top, 40)
                }
                .padding(.leading, 10)
                .padding(.bottom, 40)
            }
            .padding([.leading, .trailing], 10)
            .navigationBarItems(leading: Image("logo_main"), trailing: HStack {
                searchItem
                notificationItem
            })
            .font(.English03)
        }
    }
}

#Preview {
    HomeView()
}
