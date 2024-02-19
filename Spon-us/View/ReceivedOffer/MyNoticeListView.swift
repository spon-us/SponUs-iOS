//
//  MyNoticeListView.swift
//  Spon-us
//
//  Created by 황인성 on 1/25/24.
//

import SwiftUI

struct MyNoticeListView: View {
    @Binding var rootIsActive: Bool
    @StateObject var receivedOfferMyAnnouncementsViewModel = ReceivedOfferMyAnnouncementsViewModel()
    @StateObject var receivedOfferViewModel = ReceivedOfferViewModel()
    @State var announcementIdTest = false
    @State var selectedId = 0
    
    var body: some View {
        
//        NavigationView {
            
            ScrollView{
                
                VStack(spacing: 0){
                    
                    Rectangle()
                        .fill(Color.sponusSecondary)
                        .frame(width: 335, height: 56)
                        .overlay(
                            Text("확인하지 않은 제안이 ")
                            /*
                             +
                            Text("2건 ")
                                .foregroundColor(Color.sponusPrimary)*/
                            +
                            Text("있습니다")
                        )
                        .font(.Body06)
                    
//                    NavigationLink(destination: StoreKitTestView(), label: {
//                        Text("결제페이지 테스트")
//                    })
                        .padding(.top, 5)

                    Text("02.19 MON")
                        .font(.English01)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 32)
                    
                    SponUsDivider()
                        .padding(.top, 8)
                    
                    ForEach(receivedOfferViewModel.myAnnouncementsContents, id: \.id) { announcement in
                        HStack(spacing: 0){
                            AsyncImageView(url: URL(string: announcement.mainImage.url))
                                .frame(width: 158, height: 158)
                                .clipped()
                                .padding(.trailing, 20)
                            
                            LazyVStack(alignment: .leading, spacing: 12){
                                Text("\(changeToKorean(type: announcement.type) ?? "전체")")
                                    .font(.Caption02)
                                    .foregroundColor(Color.sponusGrey700)
                                
                                Text(announcement.title)
                                    .font(.Body07)
                                    .foregroundColor(Color.sponusBlack)
                                
                                Button {
                                    selectedId = announcement.id
                                    announcementIdTest = true
                                } label: {
                                    HStack {
                                        Text("받은 제안서")
                                            .padding(.leading, 5)
                                        
                                        Image("ic_go_blue")
                                            .frame(width: 16, height: 16)
                                            .padding(.leading, -3)
                                    }
                                    .font(.Body10)
                                    .foregroundStyle(Color.sponusPrimary)
                                    .padding(.vertical, 11)
                                    .padding(.horizontal, 10)
                                    .overlay(
                                        Rectangle()
                                            .stroke(Color.sponusPrimary, lineWidth: 1)
                                    )
                                }
                            }.padding(.trailing, 20)
                        }
                    }
                    .padding(.trailing, 20)
                    .padding(.top, 16)
                    
                    
                    /*
                    ForEach(receivedOfferMyAnnouncementsViewModel.myAnnouncementsContents, id: \.self.id) { content in
                        MyNoticeListCell(rootIsActive: $rootIsActive, title: content.title)
                    }*/
                    
                    
                }
                .foregroundColor(Color.sponusBlack)
                .padding(.horizontal, 20)
            }
            .navigationDestination(isPresented: $announcementIdTest) { ProposalReceivedListView(rootIsActive: $rootIsActive, selectedAnnouncementID: selectedId) }
            .navigationTitle("받은 제안").font(.Body01)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButton())
            .onAppear {
                receivedOfferViewModel.fetchMyAnnouncements()
                receivedOfferMyAnnouncementsViewModel.fetchReceivedOfferMyAnnouncements()
            }
//        }
        .toolbar(.hidden, for: .tabBar)
    }
}

/*
struct MyNoticeListCell: View {
    @Binding var rootIsActive: Bool
    var receivedOfferViewModel: ReceivedOfferViewModel
    
    @ObservedObject var receivedOfferMyAnnouncementsViewModel = ReceivedOfferMyAnnouncementsViewModel()
    
    var body: some View {
        ForEach(receivedOfferViewModel.myAnnouncementsContents, id: \.id) { announcement in
            HStack(spacing: 0){
                AsyncImageView(url: URL(string: announcement.mainImage.url))
                    .frame(width: 158, height: 158)
                    .clipped()
                    .padding(.trailing, 20)
                
                LazyVStack(alignment: .leading, spacing: 12){
                    Text("\(changeToKorean(type: announcement.type) ?? "전체")")
                        .font(.Caption02)
                        .foregroundColor(Color.sponusGrey700)
                    
                    Text(announcement.title)
                        .font(.Body07)
                        .foregroundColor(Color.sponusBlack)
                    
                    NavigationLink(destination: {
                        ProposalReceivedListView(rootIsActive: $rootIsActive, selectedAnnouncementID: <#Int#>)
                    }, label: {
                        HStack {
                            Text("받은 제안서")
                                .padding(.leading, 5)
                            
                            Image("ic_go_blue")
                                .frame(width: 16, height: 16)
                                .padding(.leading, -3)
                        }
                        .font(.Body10)
                        .foregroundStyle(Color.sponusPrimary)
                        .padding(.vertical, 11)
                        .padding(.horizontal, 10)
                        .overlay(
                            Rectangle()
                                .stroke(Color.sponusPrimary, lineWidth: 1)
                        )
                    })
                }.padding(.trailing, 20)
            }
        }
        /*
        .onAppear() {
            receivedOfferViewModel.fetchMyAnnouncements()
            print(receivedOfferViewModel.myAnnouncementsContents)
        }*/
        .padding(.trailing, 20)
        .padding(.top, 16)
    }
}

#Preview {
    MyNoticeListView(rootIsActive: .constant(false))
}
*/
