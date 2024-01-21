//
//  SendOfferPostView.swift
//  Spon-us
//
//  Created by yubin on 1/21/24.
//

import SwiftUI

struct SendOfferPostView: View {
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 10) {
                            ForEach(1...3, id: \.self) { index in
                                Image("post\(index)")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 335, height: 335)
                                    .containerRelativeFrame(.horizontal)
                                    .scrollTransition(.animated, axis: .horizontal) { content, phase in
                                        content
                                            .opacity(phase.isIdentity ? 1.0 : 0.8)
                                            .scaleEffect(phase.isIdentity ? 1.0 : 0.8)
                                    }
                                
                            }
                        }
                        .scrollTargetLayout()
                        
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .safeAreaPadding(.horizontal, 40.0)
                    
                    LazyVStack(alignment: .leading, spacing: 0) {
                        NavigationLink {
                            
                        } label: {
                            HStack {
                                Text("스포대학교 총학생회")
                                    .font(.Body10)
                                    .foregroundColor(Color.sponusPrimary)
                                
                                Image("ic_go_blue")
                                    .frame(width: 16, height: 16)
                            }
                        }.padding(.top, 23)
                        
                        Text("스포대학교에서\n무신사와의 협업을 제안합니다")
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
                        
                        Text("안녕하세요 스포대학교 제 21대 학생회 스포너스입니다. 저희 스포대학교는 학생수 2000명의 종합대학으로, 대학생에게 알리고 싶은 제품이나 기업을 홍보하기에 적합할 것이라 생각합니다. 이에 협력을 제안합니다.  활동 내용: 카드뉴스 제작, 배너 제작, 기업 인스타그램 태그 이벤트  그 외의 내용은 상세 협의 후 정하고 싶습니다.")
                            .font(.Body10)
                            .foregroundColor(.black)
                            .padding(.top, 14)
                        
                        Rectangle()
                            .fill(Color.sponusGrey200)
                            .frame(maxWidth: .infinity, maxHeight: 1)
                            .padding(.top, 24)
                        
                        SendOfferPostCell(status: "수락")
                            .padding(.vertical, 16)
                        
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 20)
                
            }
            
            NavigationLink(destination: EmptyView(), label: {
                ZStack(alignment: .leading) {
                    Text("담당자 정보 확인하기")
                        .font(.Body01)
                        .foregroundColor(Color.sponusPrimaryDarkmode)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 20)
                    
                    Button(action: {
                        
                    }) {
                        Image("ic_share_white")
                            .frame(width: 24, height: 24)
                            .padding(.top, 20)
                            .padding(.leading, 40)
                    }
                }
                .background(Color.sponusBlack)
            })
        }
        .navigationTitle("보낸 제안").font(.Body01)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton(), trailing: Image("ic_home_black"))
    }
}

struct SendOfferPostCell: View {
    var status: String
    
    var body: some View {
        HStack(spacing: 0) {
            ZStack {
                Image("musinsa")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 158, height: 158)
                    .padding(.trailing, 20)
                
                StatusBadge(status: "수락")
                    .offset(x: 50.5, y: -66.5)
            }
            
            LazyVStack(alignment: .leading, spacing: 12) {
                Text("연계 프로젝트")
                    .font(.Caption02)
                    .foregroundColor(Color.sponusGrey700)
                
                
                Text("무신사 글로벌 마케팅\n연계 프로젝트")
                    .font(.Body07)
                    .foregroundColor(Color.sponusBlack)
                
                NavigationLink(destination: CompanyPostView(), label: {
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
                })
            }
            .padding(.trailing, 15)
        }
        .padding(.top, 16)
    }
}

#Preview {
    SendOfferPostView()
}
