//
//  NotificationView.swift
//  Spon-us
//
//  Created by 김수민 on 2/2/24.
//

import SwiftUI

struct NotificationView: View {
    var body: some View {
        VStack(spacing: 16){
            NotificationCell(isRead: false)
            NotificationCell(isRead: true)
            NotificationCell(isRead: true)
            Spacer()
        }
        .padding(.horizontal, 20).padding(.vertical, 16)
        .navigationTitle("알림").font(.Body01)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton())
    }
}

struct NotificationCell: View {
    let isRead: Bool
    var body: some View {
        VStack(spacing: 20){
            NavigationLink(destination: Text("df"), label : {
                HStack(alignment: .top){
                    Image("company_dummy").frame(width: 46, height: 46)
                        .padding(.trailing, 12)
                    VStack(alignment: .leading, spacing: 4){
                        Text("제안서 도착").font(.Body06).foregroundColor(isRead == true ? .sponusGrey700 : .sponusPrimary)
                        Text("무신사 담당자님이\n제안서를 보냈습니다.").multilineTextAlignment(.leading).font(.Body06).foregroundColor(isRead == true ? .sponusGrey700 : .sponusBlack)
                        HStack(spacing: 0){
                            Image("ic_alert").frame(width: 8, height: 8)
                                .padding(.trailing, 6)
                            Text("27분 전").font(.English16).foregroundColor(.sponusGrey700)
                            Spacer()
                        }
                        Spacer()
                    }.frame(width: 237, height: 95)
                    Spacer()
                    Image("ic_move").rotationEffect(Angle(degrees: 180))
                }
            })
            SponUsDivider()
                .foregroundColor(.sponusGrey200)
        }
    }
}

#Preview {
    NotificationView()
}

