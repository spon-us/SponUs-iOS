//
//  MyNoticeDetailView.swift
//  Spon-us
//
//  Created by 황인성 on 1/25/24.
//

import SwiftUI

struct MyNoticeDetailView: View {
    @Binding var rootIsActive: Bool
    @State var popup = false
    
    var body: some View {
        //        NavigationView {
        VStack(spacing: 0) {
            //                if popup == true{
            //                    Text("popup = true")
            //                }
            ScrollView {
                LazyVStack(spacing: 0){
                    
                    ImageScrollView()
                    
                    LazyVStack(alignment: .leading, spacing: 0) {
                        
                        HStack(spacing: 6){
                            Image("ic_eye_small")
                            Text("989")
                                .padding(.trailing, 10)
                            
                            Image("ic_saved_small")
                            Text("34")
                        }
                        .font(.English16)
                        .foregroundColor(Color.sponusGrey700)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        
                        NavigationLink(destination: ProfileView(rootIsActive: $rootIsActive), label: {
                            HStack{
                                Text("스포대학교 총학생회")
                                    .font(.Body10)
                                    .foregroundColor(Color.sponusPrimary)
                                
                                Image("ic_go_blue")
                                    .frame(width: 16, height: 16)
                            }
                        })
                        .padding(.top, 23)
                        
                        
                        Text("2024 스포대학교\n대동제 협찬")
                            .font(.Heading05)
                            .padding(.top, 16)
                        
                        
                        DivisionCell()
                        
                        
                        // Korean/Body/Body10
                        Text("공고 상세")
                            .font(.Body10)
                            .foregroundColor(Color.sponusGrey700)
                            .padding(.top, 24)
                        
                        // Korean/Body/Body10
                        Text("안녕하세요 스포대학교 제 21대 학생회 스포너스입니다. 2023년도 스포대학교 대동제에 물품 협찬해 주실 기업은 연락 부탁 드립니다. \n저희 스포대학교는 학생수 2000명의 종합대학으로, 대학생에게 알리 고 싶은 제품이나 기업을 홍보하기에 적합할 것이라 생각합니다. \n대동제 기간: 2023년 9월 20일~ 9월 22일 활동 내용: 카드뉴스 제작, 배너 제작, 기업 인스타그램 태그 이벤트  그 외의 내용은 상세 협의 후 정하고 싶습니다. ")
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
                .foregroundColor(Color.sponusBlack)
                .padding(.bottom, 20)
                
            }
            
            NavigationLink(destination: EditPostView(popup: $popup), label: {
                Text("수정하기")
                    .font(.Body01)
                    .foregroundColor(Color.sponusPrimaryDarkmode)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 20)
                    .background(Color.sponusBlack)
            })
        }
        .navigationTitle("내 공고").font(.Body01)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton(), trailing: Button(action: {self.rootIsActive = false}, label: {
            Image(.icHome)
                .renderingMode(.template)
                .foregroundStyle(.black)
        }))
        //        }
    }
}

struct ImageScrollView: View {
    var body: some View {

        ScrollView(.horizontal) {
            LazyHStack(spacing: 10) {
                ForEach(0 ..< 5) { trip in
                    
                    Rectangle()
                        .frame(width: UIScreen.screenWidth * 0.8, height: UIScreen.screenWidth * 0.8)
                    

                        .containerRelativeFrame(.horizontal, count: 1, span: 1, spacing: 10)
                        .scrollTransition(.animated, axis: .horizontal) { content, phase in
                            content
                                .opacity(phase.isIdentity ? 1.0 : 0.8)
                                .scaleEffect(phase.isIdentity ? 1.0 : 0.8)
                        }
                    
                }
            }
            .scrollTargetLayout()
            .padding(.bottom, 20)
            
        }
        .scrollTargetBehavior(.viewAligned)
        .safeAreaPadding(.horizontal, (CGFloat(UIScreen.screenWidth) / 8))

    }
}

struct DivisionCell: View {
    var body: some View {
        
        VStack(spacing: 0){
            
            Rectangle()
                .fill(Color.sponusGrey200)
                .frame(maxWidth: .infinity, maxHeight: 1)
                .padding(.top, 16)
            
            HStack(spacing: 0){
                HStack{
                    Text("유형")
                        .font(.Body10)
                        .foregroundColor(Color.sponusGrey700)
                    
                    Spacer()
                    
                    Text("협찬")
                        .font(.Body10)
                        .padding(.trailing, 16)
                }
                .frame(maxWidth: .infinity)
                
                Rectangle()
                    .fill(Color.sponusGrey200)
                    .frame(maxWidth: 1, minHeight: 49)
                
                HStack{
                    Text("분야")
                        .font(.Body10)
                        .foregroundColor(Color.sponusGrey700)
                        .padding(.leading, 16)
                    Spacer()
                    Text("기획/아이디어")
                        .font(.Body10)
                }
                .frame(maxWidth: .infinity)
            }
            Rectangle()
                .fill(Color.sponusGrey200)
                .frame(maxWidth: .infinity, maxHeight: 1)
        }
    }
}



#Preview {
    MyNoticeDetailView(rootIsActive: .constant(false))
}
