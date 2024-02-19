//
//  ProposalReceivedListView.swift
//  Spon-us
//
//  Created by 황인성 on 2024/01/09.
//

import SwiftUI

struct ProposalReceivedListView: View {
    @Binding var rootIsActive: Bool
    @State var goToNoticeDetail = false
    @State private var selectedAnnouncementID: Int
    
    @ObservedObject var receivedViewModel = ReceivedViewModel()
    @StateObject var receivedOfferViewModel = ReceivedOfferViewModel()
    
    init(rootIsActive: Binding<Bool>, selectedAnnouncementID: Int) {
        self._rootIsActive = rootIsActive
        self._selectedAnnouncementID = State(initialValue: selectedAnnouncementID)
    }
    
    var body: some View {
        ScrollView{
            VStack(spacing: 0){
                if let selectedAnnouncement = receivedOfferViewModel.myAnnouncementsContents.first(where: { $0.id == selectedAnnouncementID }) {
                    HStack(spacing: 0) {
                        AsyncImageView(url: URL(string: selectedAnnouncement.mainImage.url))
                            .frame(width: 158, height: 158)
                            .clipped()
                            .padding(.trailing, 20)
                        
                        LazyVStack(alignment: .leading, spacing: 12) {
                            Text("\(changeToKorean(type: selectedAnnouncement.type) ?? "전체")")
                                .font(.Caption02)
                                .foregroundColor(Color.sponusGrey700)
                            
                            Text(selectedAnnouncement.title)
                                .font(.Body07)
                                .foregroundColor(Color.sponusBlack)
                            
                            Button(action: {
                                goToNoticeDetail = true
                            }, label: {
                                HStack {
                                    Text("내 공고 보기")
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
                        }
                        .padding(.trailing, 20)
                        .navigationDestination(isPresented: $goToNoticeDetail, destination: {
                            MyNoticeDetailView(rootIsActive: $rootIsActive)
                        })
                        .padding(.trailing, 20)
                        .padding(.top, 16)
                    }
                } else {
                    // 선택된 ID에 해당하는 공고를 찾을 수 없는 경우 처리
                    Text("Selected announcement not found.")
                }
                
                Text("02.19 MON")
                    .font(.English01)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 32)
                
                SponUsDivider()
                    .padding(.top, 8)
                
                NavigationLink(destination: ChargerInfoViewTest(rootIsActive: $rootIsActive), label: {
                    VStack {
                        ForEach(receivedViewModel.proposalReceived.indices, id: \.self) { index in
                            HStack(spacing: 0) {
                                AsyncImageView(url: URL(string: receivedViewModel.proposalReceived[index].proposes[index].proposingOrganizationImageUrl ?? "post_list_dummy_image"))
                                    .frame(width: 79, height: 79)
                                    .clipped()
                                    .padding(.trailing, 17)
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(receivedViewModel.proposalReceived[index].proposes[index].proposingOrganizationName)
                                        .font(.Body07)
                                    
                                    Text(receivedViewModel.proposalReceived[index].proposes[index].title)
                                        .font(.Body10)
                                        .foregroundColor(Color.sponusGrey800)
                                }
                                
                                Spacer()
                                
                                Image("ic_go")
                            }
                        }
                    }
                    
                })
                .padding(.top, 16)
                
            }
            .foregroundColor(Color.sponusBlack)
            .padding(.all, 20)
        }
        .onAppear() {
            receivedOfferViewModel.fetchMyAnnouncements()
            receivedViewModel.fetchProposalReceived(announcementId: selectedAnnouncementID)
        }
        .navigationBarItems(leading: CustomBackButton(), trailing: Button(action: {self.rootIsActive = false}, label: {
            Image(.icHome)
                .renderingMode(.template)
                .foregroundStyle(.black)
        }))
        .navigationTitle("받은 제안").font(.Body01)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        
    }
}
/*
#Preview {
    ProposalReceivedListView(rootIsActive: .constant(false))
}
*/
