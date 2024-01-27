//
//  MyNoticeListView.swift
//  Spon-us
//
//  Created by 황인성 on 1/25/24.
//

import SwiftUI

struct MyNoticeListView: View {
    @Binding var rootIsActive: Bool
    
    var body: some View {
        
//        NavigationView {
            
            ScrollView{
                
                VStack(spacing: 0){
                    
                    Rectangle()
                        .fill(Color.sponusSecondary)
                        .frame(width: 335, height: 56)
                        .overlay(
                            Text("확인하지 않은 제안이 ")
                            +
                            Text("2건 ")
                                .foregroundColor(Color.sponusPrimary)
                            +
                            Text("있습니다")
                        )
                        .font(.Body06)
                    
//                    NavigationLink(destination: StoreKitTestView(), label: {
//                        Text("결제페이지 테스트")
//                    })

                    Text("12.24 SUN")
                        .font(.English01)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 32)
                    
                    SponUsDivider()
                        .padding(.top, 8)
                    
                    ForEach(1 ..< 5) { item in
                        MyNoticeListCell(rootIsActive: $rootIsActive)
                    }
                }
                .foregroundColor(Color.sponusBlack)
                .padding(.horizontal, 20)
            }
            .navigationTitle("받은 제안").font(.Body01)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButton())
//        }
        .toolbar(.hidden, for: .tabBar)
    }
}

struct MyNoticeListCell: View {
    @Binding var rootIsActive: Bool
    
    var body: some View {
        HStack(spacing: 0){
            Image("post_list_dummy_image")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 158, height: 158)
                .padding(.trailing, 20)
            
            LazyVStack(alignment: .leading, spacing: 12){
                Text("협찬")
                    .font(.Caption02)
                    .foregroundColor(Color.sponusGrey700)
                
                Text("2024 스포대학교\n대동제 협찬")
                    .font(.Body07)
                    .foregroundColor(Color.sponusBlack)
                
                NavigationLink(destination: {
                    ProposalReceivedListView(rootIsActive: $rootIsActive)
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
        .padding(.trailing, 20)
        .padding(.top, 16)
    }
}

#Preview {
    MyNoticeListView(rootIsActive: .constant(false))
    
}
