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

struct HomeView: View {
    
    @State var isPresented = false
    @State private var progressStatus  = Portfolio.ProgressStatus()
    
    let searchItem: some View = {
        Button(action: {
            
        }) {
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
                TabView {
                    ForEach(1...3, id: \.self) { index in
                        Image("main_ad\(index)")
                            .resizable()
                    }
                }
                .cornerRadius(4)
                .frame(width: 335, height: 402)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
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
                    HStack(spacing: 20) {
                        VStack {
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
                            
                            Text("스포너스\n추천 공고")
                                .font(.Heading09)
                                .foregroundColor(Color("sponus_black"))
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
                        
                        VStack {
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
                            
                            Text("실시간\n인기 공고")
                                .font(.Heading09)
                                .foregroundColor(Color("sponus_black"))
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
                        
                        VStack {
                            HStack {
                                Image("ic_eye")
                                    .padding(.leading, 20)
                                Spacer()
                                Image("btn_move")
                                    .padding(.trailing, 20)
                            }
                            
                            Text("RECENT")
                                .font(.English11)
                                .foregroundColor(Color("sponus_primary"))
                            
                            Text("최근 본\n공고")
                                .font(.Heading09)
                                .foregroundColor(Color("sponus_black"))
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
            }
            .padding([.leading, .trailing], 20)
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
