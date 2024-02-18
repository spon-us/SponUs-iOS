//
//  NotificationView.swift
//  Spon-us
//
//  Created by 김수민 on 2/2/24.
//

import SwiftUI

struct NotificationView: View {
    @ObservedObject var viewModel = NotificationViewModel()
    var body: some View {
        ScrollView(){
            VStack(spacing: 16){
                //            NotificationCell(isRead: false)
                //            NotificationCell(isRead: true)
                //            NotificationCell(isRead: true)
                ForEach(viewModel.notificationContents) { notificationContent in
                    NotificationCell(notificationContent: notificationContent).frame(height: 95)
                }
                Spacer()
            }
        }
        .onAppear(){
            viewModel.getNotifications()
        }
        .padding(.horizontal, 20).padding(.vertical, 16)
        .navigationTitle("알림").font(.Body01)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton())
    }
}

struct NotificationCell: View {
    var notificationContent: NotificationContent
    var body: some View {
        VStack(spacing: 20){
            NavigationLink(destination: Text("df"), label : {
                HStack(alignment: .top){
                    Image("company_dummy").frame(width: 46, height: 46)
                        .padding(.trailing, 12)
                    VStack(alignment: .leading, spacing: 4){
                        Text("\(notificationContent.title)").font(.Body06).foregroundColor(notificationContent.isRead == true ? .sponusGrey700 : .sponusPrimary)
                        Text("\(notificationContent.body)").multilineTextAlignment(.leading).font(.Body06).foregroundColor(notificationContent.isRead == true ? .sponusGrey700 : .sponusBlack)
                        Spacer()
                    }
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

