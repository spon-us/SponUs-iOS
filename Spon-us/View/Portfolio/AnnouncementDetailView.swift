//
//  MyNoticeDetailView.swift
//  Spon-us
//
//  Created by 황인성 on 1/25/24.
//

import SwiftUI
import Moya
import Foundation

struct AnnouncementDetailView: View {
    @Binding var rootIsActive: Bool
    @State var announcementId: Int
    @State var popup = false
    @State var isCompleted = false
    @State var announcementTitle = ""
    @State var announcementCategory = ""
    @State var announcementType = ""
    @State var announcementContent = ""
    @State var announcementImages: [URL] = []
    @State var proposingID = 0
    
    let provider = MoyaProvider<SponusAPI>(session: Session(interceptor: AuthInterceptor.shared))
    
    var body: some View {
        ZStack {
            if !isCompleted {
                VStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
            else {
                VStack(spacing: 0) {
                    //                if popup == true{
                    //                    Text("popup = true")
                    //                }
                    ScrollView {
                        LazyVStack(spacing: 0){
                            
                            AsyncImageScrollView(imageURLs: announcementImages)
                            
                            LazyVStack(alignment: .leading, spacing: 0) {
                                /*
                                HStack(spacing: 6){
                                    Image("ic_eye_small")
                                    Text("989")
                                        .padding(.trailing, 10)
                                    
                                    Image("ic_saved_small")
                                    Text("34")
                                }
                                .font(.English16)
                                .foregroundColor(Color.sponusGrey700)
                                .frame(maxWidth: .infinity, alignment: .trailing)*/
                                
                                NavigationLink(destination: Text("더미를 만들어야해요!"), label: {
                                    HStack{
                                        Text("스포대학교 총학생회")
                                            .font(.Body10)
                                            .foregroundColor(Color.sponusPrimary)
                                        
                                        Image("ic_go_blue")
                                            .frame(width: 16, height: 16)
                                    }
                                })
                                .padding(.top, 23)
                                .disabled(true)
                                
                                
                                Text(String(announcementId))
                                    .font(.Heading05)
                                    .padding(.top, 16)
                                
                                
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
                                            
                                            Text(announcementCategory)
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
                                            Text(announcementType)
                                                .font(.Body10)
                                        }
                                        .frame(maxWidth: .infinity)
                                    }
                                    Rectangle()
                                        .fill(Color.sponusGrey200)
                                        .frame(maxWidth: .infinity, maxHeight: 1)
                                }
                                
                                
                                // Korean/Body/Body10
                                Text("공고 상세")
                                    .font(.Body10)
                                    .foregroundColor(Color.sponusGrey700)
                                    .padding(.top, 24)
                                
                                // Korean/Body/Body10
                                Text(announcementContent)
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
            }
        }.onAppear() {
            provider.request(.getAnnouncement(announcementId: self.announcementId)) { result in
                switch result {
                case let .success(response):
                    do {
                        let responseBody = try response.map(AnnouncementModel.self)
                        self.announcementTitle = responseBody.content.title
                        self.announcementType = changeToKorean(category: responseBody.content.category) ?? "nil"
                        self.announcementCategory = changeToKorean(type: responseBody.content.type) ?? "nil"
                        self.announcementContent = responseBody.content.content
                        for elem in responseBody.content.announcementImages {
                            if let url = URL(string: elem.url) {
                                self.announcementImages.append(url)
                            } else {
                                print("error")
                            }
                        }
                        self.isCompleted = true
                    } catch {
                        print("catch")
                    }
                    
                case let .failure(response):
                    print("failure")
                }
                
            }
        }//        NavigationView {
       
        
        //        }
    }
}


//#Preview {
//    MyNoticeDetailView(rootIsActive: .constant(false))
//}
