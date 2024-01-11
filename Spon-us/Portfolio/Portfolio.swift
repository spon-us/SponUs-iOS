//
//  Portfolio.swift
//  Spon-us
//
//  Created by 박현수 on 1/6/24.
//

import SwiftUI

struct Portfolio: View {
    @State var progressStatus: ProgressStatus
    
    var publishingDummyData = [
        PublishingPost(thumbNail: Image(.postListDummy), postCategory: "협찬", postTitle: "2014 스포대학교 대동제 협찬", savedNumber: 28),
        PublishingPost(thumbNail: Image(.postListDummy), postCategory: "협찬", postTitle: "2015 스포대학교 대동제 협찬", savedNumber: 29),
        PublishingPost(thumbNail: Image(.postListDummy), postCategory: "협찬", postTitle: "2016 스포대학교 대동제 협찬", savedNumber: 30),
        PublishingPost(thumbNail: Image(.postListDummy), postCategory: "협찬", postTitle: "2017 스포대학교 대동제 협찬", savedNumber: 31),
        PublishingPost(thumbNail: Image(.postListDummy), postCategory: "협찬", postTitle: "2018 스포대학교 대동제 협찬", savedNumber: 32),
        PublishingPost(thumbNail: Image(.postListDummy), postCategory: "협찬", postTitle: "2019 스포대학교 대동제 협찬", savedNumber: 33),
        PublishingPost(thumbNail: Image(.postListDummy), postCategory: "협찬", postTitle: "2020 스포대학교 대동제 협찬", savedNumber: 34),
        PublishingPost(thumbNail: Image(.postListDummy), postCategory: "협찬", postTitle: "2021 스포대학교 대동제 협찬", savedNumber: 35),
        PublishingPost(thumbNail: Image(.postListDummy), postCategory: "협찬", postTitle: "2022 스포대학교 대동제 협찬", savedNumber: 36),
        PublishingPost(thumbNail: Image(.postListDummy), postCategory: "협찬", postTitle: "2023 스포대학교 대동제 협찬", savedNumber: 37)
    ]
    
    var progressingDummyData = [
        ProgressingPost(thumbNail: Image(.postListDummy), companyImage: Image(.companyDummy), companyName: "무신사", postCategory: "협찬", postTitle: "2020 스포대학교 대동제 협찬"),
        ProgressingPost(thumbNail: Image(.postListDummy), companyImage: Image(.companyDummy), companyName: "무신사", postCategory: "협찬", postTitle: "2021 스포대학교 대동제 협찬"),
        ProgressingPost(thumbNail: Image(.postListDummy), companyImage: Image(.companyDummy), companyName: "무신사", postCategory: "협찬", postTitle: "2022 스포대학교 대동제 협찬"),
        ProgressingPost(thumbNail: Image(.postListDummy), companyImage: Image(.companyDummy), companyName: "무신사", postCategory: "협찬", postTitle: "2023 스포대학교 대동제 협찬"),
    ]
    
    struct ProgressStatus {
        init() {
            isPublishing = true
            isProgressing = false
            isComplete = false
        }
        var isPublishing: Bool
        var isProgressing: Bool
        var isComplete: Bool
    }
    
    struct PublishingPost: Identifiable {
        let id = UUID()
        var thumbNail: Image?
        var postCategory: String?
        var postTitle: String?
        var savedNumber: Int?
    }
    
    struct ProgressingPost: Identifiable {
        let id = UUID()
        var thumbNail: Image?
        var companyImage: Image?
        var companyName: String?
        var postCategory: String?
        var postTitle: String?
    }
    
    var backButton: some View {
        Button {} label: { Image(.icBack) }
    }
    
    var publishingButton: some View {
        Button {
            $progressStatus.isPublishing.wrappedValue = true
            $progressStatus.isProgressing.wrappedValue = false
            $progressStatus.isComplete.wrappedValue = false
        } label: {
            if ($progressStatus.isPublishing.wrappedValue == true) {
                Text("게시 중").font(.Body01).foregroundStyle(.sponusPrimary)
            }
            else {
                Text("게시 중").font(.Body01).foregroundStyle(.sponusGrey700)
            }
        }
    }
    
    var progressingButton: some View {
        Button {
            $progressStatus.isPublishing.wrappedValue = false
            $progressStatus.isProgressing.wrappedValue = true
            $progressStatus.isComplete.wrappedValue = false
        } label: {
            if ($progressStatus.isProgressing.wrappedValue == true) {
                Text("진행 중").font(.Body01).foregroundStyle(.sponusPrimary)
            }
            else {
                Text("진행 중").font(.Body01).foregroundStyle(.sponusGrey700)
            }
        }
    }
    
    var completeButton: some View {
        Button {
            $progressStatus.isPublishing.wrappedValue = false
            $progressStatus.isProgressing.wrappedValue = false
            $progressStatus.isComplete.wrappedValue = true
        } label: {
            if ($progressStatus.isComplete.wrappedValue == true) {
                Text("완료").font(.Body01).foregroundStyle(.sponusPrimary)
            }
            else {
                Text("완료").font(.Body01).foregroundStyle(.sponusGrey700)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    VStack(spacing: 0) {
                        Text("진행 중").font(.Body01).opacity(0).padding(.bottom, 18)
                        Rectangle().frame(height: 1).foregroundStyle(.sponusGrey500)
                    }
                    HStack {
                        VStack(spacing: 0) {
                            publishingButton.padding(.bottom, 18)
                            if ($progressStatus.isPublishing.wrappedValue == true) {
                                Rectangle().frame(height: 2).foregroundStyle(.sponusPrimary)
                            }
                        }.fixedSize()
                        VStack(spacing: 0) {
                            progressingButton.padding(.bottom, 18)
                            if ($progressStatus.isProgressing.wrappedValue == true) {
                                Rectangle().frame(height: 2).foregroundStyle(.sponusPrimary)
                            }
                        }.fixedSize()
                        VStack(spacing: 0) {
                            completeButton.padding(.bottom, 18)
                            if ($progressStatus.isComplete.wrappedValue == true) {
                                Rectangle().frame(height: 2).foregroundStyle(.sponusPrimary)
                            }
                        }.fixedSize()
                        Spacer()
                    }
                }
                
                if ($progressStatus.isPublishing.wrappedValue == true) {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 0) {
                            ForEach(progressingDummyData.indices) { index in
                                NavigationLink(
                                    destination: DetailView(publishingPost: publishingDummyData[index], progressingPost: nil, completePost: nil),
                                    label: {
                                        VStack(spacing: 0) {
                                            HStack(spacing: 0) {
                                                (publishingDummyData[index].thumbNail ?? Image(.icCancel))
                                                    .resizable().frame(width: 158, height: 158)
                                                    .overlay(Rectangle().stroke(.sponusGrey100, lineWidth: 1))
                                                
                                                VStack(alignment: .leading, spacing: 5) {
                                                    
                                                    HStack(spacing: 2) {
                                                        Spacer()
                                                        Image(.icSaved).resizable().frame(width: 20, height: 20)
                                                        Text(String(publishingDummyData[index].savedNumber ?? 0))
                                                            .font(.English12).foregroundStyle(.sponusGrey700)
                                                    }
                                                    Text(publishingDummyData[index].postCategory ?? "nil")
                                                        .font(.Caption02).foregroundStyle(.sponusGrey700)
                                                    Text(publishingDummyData[index].postTitle ?? "nil").font(.Body07).foregroundStyle(.sponusBlack).multilineTextAlignment(.leading)
                                                    Spacer()
                                                    
                                                    HStack(spacing: 4) {
                                                        Button {} label: {
                                                            Text("끌어올리기").font(.Caption01).foregroundStyle(.sponusBlack)
                                                        }
                                                        .frame(height: 40).frame(maxWidth: .infinity)
                                                        .overlay(Rectangle().stroke(.sponusGrey100, lineWidth: 1))
                                                        
                                                        Button {} label: {
                                                            Image(.icMore).resizable().frame(width: 40, height: 40)
                                                        }
                                                        .overlay(Rectangle().stroke(Color.sponusGrey100, lineWidth: 1))
                                                    }
                                                }.padding(.leading, 20)
                                            }.padding(.top, 32).padding(.bottom, 16)
                                            Divider().backgroundStyle(.sponusGrey200)
                                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                                    }
                                )
                            }
                        }
                    }.scrollIndicators(.hidden)

                }
                if ($progressStatus.isProgressing.wrappedValue == true) {
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(progressingDummyData.indices) { index in
                                NavigationLink(
                                    destination: DetailView(publishingPost: nil, progressingPost: progressingDummyData[index],
                                                            completePost: nil),
                                    label: {
                                        VStack(alignment:.leading, spacing: 0) {
                                            HStack(spacing: 0) {
                                                (progressingDummyData[index].thumbNail ?? Image(.icCancel))
                                                    .resizable().frame(width: 158, height: 158)
                                                    .overlay(Rectangle().stroke(.sponusGrey100, lineWidth: 1))
                                                
                                                VStack(alignment: .leading, spacing: 5) {
                                                    Text(progressingDummyData[index].postCategory ?? "nil")
                                                        .font(.Caption02).foregroundStyle(.sponusGrey700)
                                                    Text(progressingDummyData[index].postTitle ?? "nil").font(.Body07).foregroundStyle(.sponusBlack).multilineTextAlignment(.leading).padding(.bottom, 16)
                                                    
                                                    HStack(spacing: 6) {
                                                        (progressingDummyData[index].companyImage ?? Image(.icCancel)).resizable().aspectRatio(contentMode: .fill).frame(width:24, height:24).clipShape(Circle())
                                                        Text("with \(progressingDummyData[index].companyName ?? "nil")").font(.English16).foregroundStyle(.sponusGrey700)
                                                    }.padding(.bottom)
                                                    
                                                }.padding(.leading, 20)
                                            }.padding(.top, 32).padding(.bottom, 24)
                                            
                                            Divider().backgroundStyle(.sponusGrey200).padding(.bottom, 16)
                                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                                    }
                                )
                            }
                        }
                    }.scrollIndicators(.hidden)
                }
                if ($progressStatus.isComplete.wrappedValue == true) {
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(publishingDummyData.indices) { index in
                                NavigationLink(
                                    destination: DetailView(publishingPost: publishingDummyData[index], progressingPost: nil, completePost: nil),
                                    label: {
                                        VStack {
                                            HStack(spacing: 0) {
                                                (publishingDummyData[index].thumbNail ?? Image(.icCancel))
                                                    .resizable().frame(width: 158, height: 158)
                                                    .overlay(Rectangle().stroke(.sponusGrey100, lineWidth: 1))
                                                
                                                VStack(alignment: .leading, spacing: 5) {
                                                    
                                                    HStack(spacing: 2) {
                                                        Spacer()
                                                        Image(.icSaved).resizable().frame(width: 20, height: 20)
                                                        Text(String(publishingDummyData[index].savedNumber ?? 0))
                                                            .font(.English12).foregroundStyle(.sponusGrey700)
                                                    }
                                                    Text(publishingDummyData[index].postCategory ?? "nil")
                                                        .font(.Caption02).foregroundStyle(.sponusGrey700)
                                                    Text(publishingDummyData[index].postTitle ?? "nil").font(.Body07).foregroundStyle(.sponusBlack).multilineTextAlignment(.leading)
                                                    Spacer()
                                                    
                                                    HStack(spacing: 4) {
                                                        Button {} label: {
                                                            Text("끌어올리기").font(.Caption01).foregroundStyle(.sponusBlack)
                                                        }
                                                        .frame(height: 40).frame(maxWidth: .infinity)
                                                        .overlay(Rectangle().stroke(.sponusGrey100, lineWidth: 1))
                                                        
                                                        Button {} label: {
                                                            Image(.icMore).resizable().frame(width: 40, height: 40)
                                                        }
                                                        .overlay(Rectangle().stroke(Color.sponusGrey100, lineWidth: 1))
                                                    }
                                                }.padding(.leading, 20)
                                            }
                                            Divider().backgroundStyle(.sponusGrey200)
                                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                                    }
                                )
                            }
                        }
                    }.scrollIndicators(.hidden)
                }
            }.padding()
                .navigationTitle("포트폴리오").font(.Body01)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: backButton)
        }
    }
}

struct DetailView: View {
    var publishingPost: Portfolio.PublishingPost?
    var progressingPost: Portfolio.ProgressingPost?
    var completePost: Portfolio.PublishingPost?
    
    var body: some View {
        VStack {
            if (publishingPost != nil) {
                Text("Post Title: \(publishingPost?.postTitle ?? "")")
            }
            if (progressingPost != nil) {
                Text("Post Title: \(progressingPost?.postTitle ?? "")")
            }
            if (completePost != nil) {
                Text("Post Title: \(publishingPost?.postTitle ?? "")")
            }
        }
        .navigationTitle("Detail")
    }
}


//#Preview {
//    Portfolio(progressStatus: Portfolio.ProgressStatus())
//}
