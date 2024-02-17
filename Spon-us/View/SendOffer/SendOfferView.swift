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
                    ForEach(sentViewModel.sortedUniqueDates, id: \.self) { date in
                        Section(header: Text(date.description)
                            .font(.English01)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Color.sponusBlack)
                            .padding(.top, 16)) {
                                Rectangle()
                                    .fill(Color.sponusBlack)
                                    .frame(maxWidth: .infinity, maxHeight: 1)
                                    .padding(.top, 8)
                                
                                ForEach(sentViewModel.groupedProposalsByDate[date] ?? [], id: \.self) { propose in
                                    SendOfferCell(rootIsActive: $rootIsActive, sentResponse: ProposalResponse(createdDate: propose.createdDate, proposes: [propose]))
                                }
                            }
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
        
        let status = sentViewModel.proposalSent[index].proposes[index].status
        
        switch status {
        case "ACCEPTED":
            return "수락"
        case "REJECTED":
            return "거절"
        case "VIEWED":
            return "열람"
        case "PENDING":
            return ""
        case "SUSPENDED":
            return "중단"
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
        return ""
    case "SUSPENDED":
        return "중단"
    default:
        return "DefaultStatus"
    }
}

struct SendOfferCell: View {
    @Binding var rootIsActive: Bool
    
    var sentResponse: ProposalResponse
    @State private var selectedProposeId: Int?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    ZStack {
                        Image("musinsa")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 158, height: 158)
                            .padding(.trailing, 20)
                        
                        ForEach(sentResponse.proposes, id: \.self) { propose in
                            StatusBadge(status: statusChangeToKorean(english: propose.status))
                                .offset(x: 50.5, y: -66.5)
                        }
                    }
                    
                    LazyVStack(alignment: .leading, spacing: 12) {
                        ForEach(sentResponse.proposes, id: \.self) { propose in
                            Text("\(changeToKorean(type: propose.announcementSummary.type) ?? "전체")")
                                .font(.Caption02)
                                .foregroundColor(Color.sponusGrey700)
                            
                            let maxLength = 20
                            let truncatedText = propose.announcementSummary.title.count > maxLength ? String(propose.announcementSummary.title.prefix(maxLength)) + "..." : propose.announcementSummary.title

                            Text("\(truncatedText)")
                                .multilineTextAlignment(.leading)
                                .font(.Body07)
                                .foregroundColor(Color.sponusBlack)
                            
                            Spacer()
                            
                            NavigationLink(
                                destination: SendOfferPostView(proposeId: propose.proposeId, rootIsActive: $rootIsActive),
                                isActive: .constant(selectedProposeId == propose.proposeId),
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
                                }
                            )
                        }
                    }
                    .padding(.vertical, 20)
                }
                .padding(.vertical, 16)
            }
        }
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
        case "중단":
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
        case "중단":
            return Color.sponusGrey700
        default:
            return Color.white
        }
    }
}

#Preview {
    SendOfferView(rootIsActive: .constant(true))
}
