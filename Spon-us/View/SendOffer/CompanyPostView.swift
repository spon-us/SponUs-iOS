//
//  CompanyPostView.swift
//  Spon-us
//
//  Created by yubin on 1/21/24.
//

import SwiftUI
import Moya

struct CompanyPostView: View {
    @Binding var rootIsActive: Bool
    @Environment(\.presentationMode) var presentationMode
    var announcementId: Int
    let provider = MoyaProvider<SponusAPI>()
    @State var iscomplete = false
    @State var imageURLs: [URL] = []
    @State var title: String = ""
    @State var type: String = ""
    @State var category: String = ""
    @State var content: String = ""
    var body: some View {
        ZStack(){
            if !iscomplete {
                VStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
            else {
                VStack(spacing: 0) {
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            AsyncImageScrollView(imageURLs: imageURLs)
                            LazyVStack(alignment: .leading, spacing: 0) {
                                
                                //                            HStack {
                                //                                Image("ic_eye_small")
                                //                                Text("989")
                                //                                Image("ic_saved_small")
                                //                                Text("34")
                                //                            }
                                //                            .font(.English16)
                                //                            .foregroundColor(Color.sponusGrey700)
                                //                            .frame(maxWidth: .infinity, alignment: .trailing)
                                //                            .padding(.top, 15)
                                
                                //                            NavigationLink {
                                //    //                            ProfileView(rootIsActive: $rootIsActive, organizationId: <#Int#>)
                                //                                Text("더미데이터!")
                                //                            } label: {
                                //                                HStack {
                                //                                    Text("무신사")
                                //                                        .font(.Body10)
                                //                                        .foregroundColor(Color.sponusPrimary)
                                //
                                //                                    Image("ic_go_blue")
                                //                                        .frame(width: 16, height: 16)
                                //                                }
                                //                            }.padding(.top, 23)
                                
                                Text(title)
                                    .multilineTextAlignment(.leading)
                                    .font(.Heading05)
                                    .foregroundColor(Color.sponusBlack)
                                    .padding(.top, 50)
                                
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
                                        
                                        Text(changeToKorean(type: type) ?? "")
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
                                        
                                        Text(changeToKorean(category: category) ?? "")
                                            .font(.Body10)
                                            .foregroundColor(Color.sponusBlack)
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                                
                                Rectangle()
                                    .fill(Color.sponusGrey200)
                                    .frame(maxWidth: .infinity, maxHeight: 1)
                                    .padding(.bottom, 16)
                                
                                //                            HStack {
                                //                                Text("산업")
                                //                                    .font(.Body10)
                                //                                    .foregroundColor(Color.sponusGrey700)
                                //
                                //                                Spacer()
                                //
                                //                                Text("IT 패션 유통")
                                //                                    .font(.Body10)
                                //                                    .foregroundColor(Color.sponusBlack)
                                //
                                //                                Spacer()
                                //
                                //                            }
                                //                            .frame(maxWidth: .infinity)
                                
                                //                            Rectangle()
                                //                                .fill(Color.sponusGrey200)
                                //                                .frame(maxWidth: .infinity, maxHeight: 1)
                                //                                .padding(.top, 16)
                                
                                Text("공고 상세")
                                    .font(.Body10)
                                    .foregroundColor(Color.sponusGrey700)
                                    .padding(.top, 24)
                                
                                Text(content)
                                    .multilineTextAlignment(.leading)
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
                    .background(Color.sponusGrey600.ignoresSafeArea(edges: .bottom))
                }
            }
        }
        .onAppear(){
            provider.request(.getAnnouncement(announcementId: announcementId)) { result in
                switch result {
                case .success(let response):
                    do {
                        let fetchedAnnouncement = try JSONDecoder().decode(AnnouncementModel.self, from: response.data)
                        for elem in fetchedAnnouncement.content.announcementImages {
                            imageURLs.append(URL(string: elem.url)!)
                        }
                        title = fetchedAnnouncement.content.title
                        type = fetchedAnnouncement.content.type
                        category = fetchedAnnouncement.content.category
                        content = fetchedAnnouncement.content.content
                        iscomplete = true
                        
                    } catch let error {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        .gesture(
            DragGesture().onEnded { value in
                if value.translation.width > 100 {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        )
        .toolbar(.hidden, for: .tabBar)
        .navigationBarBackButtonHidden(true)
        .navigationTitle("기업 공고").font(.Body01)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: CustomBackButton(), trailing: Image("ic_home_black"))
    }
}

//#Preview {
//    CompanyPostView(rootIsActive: .constant(false))
//}
