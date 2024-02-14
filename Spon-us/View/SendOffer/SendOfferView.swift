//
//  SendOfferView.swift
//  Spon-us
//
//  Created by yubin on 1/18/24.
//

import SwiftUI

struct SendOfferView: View {
    @Binding var rootIsActive: Bool
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var sentViewModel = SentViewModel()
    
    var body: some View {
        ScrollView {
            if hasData() {
                VStack(spacing: 0) {
                    Text("02.14 WED")
                        .font(.English01)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color.sponusBlack)
                        .padding(.top, 16)
                    
                    Rectangle()
                        .fill(Color.sponusBlack)
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .padding(.top, 8)
                    
                    ForEach(sentViewModel.proposalSent, id: \.self) {sentResponse in
                        SendOfferCell(rootIsActive: $rootIsActive, sentResponse: sentResponse)
                    }
                }
                .padding(.horizontal, 20)
            } else {
                Text("현재 보낸 제안이 없습니다")
                    .font(.Body06)
                    .foregroundColor(Color.sponusGrey900)
                    .padding(.top, 300)
            }
        }
        .onAppear {
            sentViewModel.fetchProposalSent()
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
        .navigationBarItems(leading: CustomBackButton())
        .toolbar(.hidden, for: .tabBar)
    }
    
    func getStatus(for index: Int) -> String {
        guard index < sentViewModel.proposalSent.count else {
            return "DefaultStatus"
        }
        
        let status = sentViewModel.proposalSent[index].status
        
        switch status {
        case "ACCEPTED":
            return "수락"
        case "REJECTED":
            return "거절"
        case "VIEWED":
            return "열람"
        case "PENDING":
            return "제안중"
        case "SUSPENDED":
            return "협업중지"
        default:
            return "DefaultStatus"
        }
    }
    
    func hasData() -> Bool {
        if sentViewModel.proposalSent.count != 0 {
            return true
        } else {
            return false
        }
    }
}
func statusChangeToKorean(english: String) -> String{
    switch english {
    case "ACCEPTED":
        return "수락"
    case "OPENED":
        return "수락"
    case "REJECTED":
        return "거절"
    case "VIEWED":
        return "열람"
    case "PENDING":
        return "제안중"
    case "SUSPENDED":
        return "협업중지"
    case "CLOSED":
        return "모집마감"
    default:
        return "DefaultStatus"
    }
}
struct SendOfferCell: View {
    @Binding var rootIsActive: Bool
    
    var sentResponse: ProposalResponse
    
    var body: some View {
        HStack(spacing: 0) {
            ZStack {
                Image("musinsa")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 158, height: 158)
                    .padding(.trailing, 20)
                
                StatusBadge(status: statusChangeToKorean(english: sentResponse.status))
                    .offset(x: 50.5, y: -66.5)
            }
            
            LazyVStack(alignment: .leading, spacing: 12) {
                Text("\(changeToKorean(type: sentResponse.announcementSummary.type) ?? "전체")")
                    .font(.Caption02)
                    .foregroundColor(Color.sponusGrey700)
                
                Text("\(sentResponse.title)")
                    .multilineTextAlignment(.leading)
                    .font(.Body07)
                    .foregroundColor(Color.sponusBlack)
                
                NavigationLink(destination:
                                SendOfferPostView(proposeId: sentResponse.proposeId,rootIsActive: $rootIsActive),
                               label: {
                    HStack {
                        Text("보낸 제안서")
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
    SendOfferView(rootIsActive: .constant(true))
}
