//
//  ProposalReceivedListView.swift
//  Spon-us
//
//  Created by 황인성 on 1/23/24.
//

import SwiftUI

struct ProposalReceivedListView: View {
    var body: some View {
        ScrollView{
            
            VStack(spacing: 0){
                
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
                        
                        
                        NavigationLink(destination: {
                            MyNoticeDetailView()
                        }, label: {
                            HStack{
                                Text("내 공고 보기")
                                
                                
                                Image("ic_go")
                                    .frame(width: 16, height: 16)
                            }
                            .font(.Body10)
                            .foregroundStyle(Color.sponusPrimary)
                            .padding(.vertical, 8)
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
                
                
                Text("12.24 SUN")
                    .font(.English01)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 32)
                
                SponUsDivider()
                    .padding(.top, 8)
                
                
                HStack(spacing: 0) {
                    Image("Rectangle 1232")
                        .frame(width: 79, height: 79)
                        .padding(.trailing, 17)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        
                        Text("무신사 담당자")
                            .font(.Body07)
                        
                        
                        Text("안녕하세요 무신사입니다")
                            .font(.Body10)
                          .foregroundColor(Color.sponusGrey800)

                    }
                    
                    Spacer()
                    
                    Image("ic_go")
                }
                .padding(.top, 16)
                
            }
            .foregroundColor(Color.sponusBlack)
            .padding(.horizontal, 20)
        }
        .navigationBarItems(leading: CustomBackButton())
        .navigationTitle("받은 제안").font(.Body01)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        
    }
}




#Preview {
    ProposalReceivedListView()
}
