//
//  CompanyPostView.swift
//  Spon-us
//
//  Created by yubin on 1/21/24.
//

import SwiftUI

struct CompanyPostView: View {
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack(spacing: 0){
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 10) {
                            ForEach(4...6, id: \.self) { index in
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
                        
                        HStack {
                            Image("ic_eye_small")
                            Text("989")
                            Image("ic_saved_small")
                            Text("34")
                        }
                        .font(.English16)
                        .foregroundColor(Color.sponusGrey700)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.top, 15)
                        
                        NavigationLink {
                            
                        } label: {
                            HStack {
                                Text("무신사")
                                    .font(.Body10)
                                    .foregroundColor(Color.sponusPrimary)
                                
                                Image("ic_go_blue")
                                    .frame(width: 16, height: 16)
                            }
                        }.padding(.top, 23)
                        
                        Text("무신사 글로벌 마케팅\n연계프로젝트")
                            .font(.Heading05)
                            .foregroundColor(Color.sponusBlack)
                            .padding(.top, 16)
                        
                        Rectangle()
                            .fill(Color.sponusGrey200)
                            .frame(maxWidth: .infinity, maxHeight: 1)
                            .padding(.top, 16)
                        
                        HStack(spacing: 0) {
                            HStack {
                                Text("유형")
                                    .font(.Body10)
                                    .foregroundColor(Color.sponusGrey700)
                                
                                Spacer()
                                
                                Text("연계프로젝트")
                                    .font(.Body10)
                                    .foregroundColor(Color.sponusBlack)
                                    .padding(.trailing, 16)
                            }
                            .frame(maxWidth: .infinity)
                            
                            Rectangle()
                                .fill(Color.sponusGrey200)
                                .frame(maxWidth: 1, minHeight: 49)
                            
                            HStack {
                                Text("분야")
                                    .font(.Body10)
                                    .foregroundColor(Color.sponusGrey700)
                                    .padding(.leading, 16)
                                
                                Spacer()
                                
                                Text("기획/아이디어")
                                    .font(.Body10)
                                    .foregroundColor(Color.sponusBlack)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        
                        Rectangle()
                            .fill(Color.sponusGrey200)
                            .frame(maxWidth: .infinity, maxHeight: 1)
                            .padding(.bottom, 16)
                        
                        HStack {
                            Text("산업")
                                .font(.Body10)
                                .foregroundColor(Color.sponusGrey700)
                            
                            Spacer()
                            
                            Text("IT 패션 유통")
                                .font(.Body10)
                                .foregroundColor(Color.sponusBlack)
                                
                            Spacer()
                                
                        }
                        .frame(maxWidth: .infinity)
                        
                        Rectangle()
                            .fill(Color.sponusGrey200)
                            .frame(maxWidth: .infinity, maxHeight: 1)
                            .padding(.top, 16)
                        
                        Text("공고 상세")
                            .font(.Body10)
                            .foregroundColor(Color.sponusGrey700)
                            .padding(.top, 24)
                        
                        Text("안녕하세요. 무신사입니다. 글로벌 마케팅 전략 수립을 위해 대학생과의 협업을 진행하려고 합니다.\n 활동기간: 2023년 12월 29일 ~ 2024년 12월 29일 활동 내용: 카드뉴스 제작, 홍보 영상 제작 등  자세한 내용은 협의 후에 결정하려고 합니다. 관심 있는 대학생 분들은 제안 부탁드립니다.")
                            .font(.Body10)
                            .foregroundColor(.black)
                            .padding(.top, 24)
                        
                        Rectangle()
                            .fill(Color.sponusGrey200)
                            .frame(maxWidth: .infinity, maxHeight: 1)
                            .padding(.top, 24)
                        
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 82)
                
            }
            
            ZStack(alignment: .leading) {
                Text("제안완료")
                    .font(.Body01)
                    .foregroundColor(Color.sponusGrey200)
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
            .background(Color.sponusGrey600)
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("기업 공고").font(.Body01)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: CustomBackButton(), trailing: Image("ic_home_black"))
    }
}

#Preview {
    CompanyPostView()
}
