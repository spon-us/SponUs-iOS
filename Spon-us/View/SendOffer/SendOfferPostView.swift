//
//  SendOfferPostView.swift
//  Spon-us
//
//  Created by yubin on 1/21/24.
//

import SwiftUI
import Moya

struct SendOfferPostView: View {
    var proposeId: Int
    @Binding var rootIsActive: Bool
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isShowingActivityView = false
    @State private var activityItems: [Any] = [URL(string: "https://example.com")!]
    
    @ObservedObject var proposalDetailViewModel = ProposalDetailViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    AsyncImageView(url: URL(string: proposalDetailViewModel.proposalDetail?.proposingOrganizationImage ?? "profile_test"))
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 335)
                        .clipped()
                    
                    NavigationLink {
                        ProfileView(rootIsActive: $rootIsActive)
                    } label: {
                        HStack {
                            Text(proposalDetailViewModel.proposalDetail?.proposedOrganizationName ?? "")
                                .font(.Body10)
                                .foregroundColor(Color.sponusPrimary)
                            
                            Image("ic_go_blue")
                                .frame(width: 16, height: 16)
                        }
                    }.padding(.top, 23)
                    
                    Text(proposalDetailViewModel.proposalDetail?.title ?? "")
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
                    
                    Text(proposalDetailViewModel.proposalDetail?.content ?? "")
                        .multilineTextAlignment(.leading)
                        .font(.Body10)
                        .foregroundColor(.black)
                        .padding(.top, 14)
                    
                    Rectangle()
                        .fill(Color.sponusGrey200)
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .padding(.top, 24)
                    
                    SendOfferPostCell(rootIsActive: $rootIsActive, status: statusChangeToKorean(english: proposalDetailViewModel.proposalDetail?.announcementDetails.status ?? ""), cellData: proposalDetailViewModel.proposalDetail?.announcementDetails ?? AnnouncementDetails())
                        .padding(.vertical, 16)
                }
                .padding(.all, 20)
            }
            
            HStack() {
                HStack(spacing: 16) {
                    Button(action: {
                        isShowingActivityView = true
                    }) {
                        Image("ic_share_white")
                            .frame(width: 24, height: 24)
                            .padding(.top, 20)
                    }.sheet(isPresented: $isShowingActivityView) {
                        ActivityView(activityItems: activityItems)
                    }
                }
                .padding(.leading, 36)
                
                NavigationLink(destination: ChargerInfoView(rootIsActive: $rootIsActive)) {
                    Text("담당자 정보 확인하기")
                        .font(.Body01)
                        .foregroundColor(Color.sponusPrimaryDarkmode)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 20)
                }
            }
            .background(Color.sponusBlack)
        }
        .gesture(
            DragGesture().onEnded { value in
                if value.translation.width > 100 {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        )
        .navigationTitle("보낸 제안").font(.Body01)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton(), trailing: Button(action: { self.rootIsActive = false }, label: {
            Image(.icHome)
                .renderingMode(.template)
                .foregroundStyle(.black)
        }))
        .onAppear(){
            proposalDetailViewModel.fetchProposalDetail(proposeId: proposeId)
        }
    }
}

struct SendOfferPostCell: View {
    @Binding var rootIsActive: Bool
    var status: String
    var cellData: AnnouncementDetails
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(cellData.announcementImages, id: \.self) { image in
                AsyncImageView(url: URL(string: image.url))
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 158, height: 158)
                    .clipped()
                    .padding(.trailing, 20)
            }
                
            VStack(alignment: .leading, spacing: 12) {
                Text("\(changeToKorean(type: cellData.type) ?? "전체")")
                    .font(.Caption02)
                    .foregroundColor(Color.sponusGrey700)
                
                Text(cellData.title)
                    .multilineTextAlignment(.leading)
                    .font(.Body07)
                    .foregroundColor(Color.sponusBlack)
                
                Spacer()
                
                NavigationLink(destination: CompanyPostView(rootIsActive: $rootIsActive)) {
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
                }
                .padding(.trailing, 15)
            }
            .padding(.vertical, 20)
        }
        .padding(.top, 16)
    }
}
