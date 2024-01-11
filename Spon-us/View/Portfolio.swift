//
//  Portfolio.swift
//  Spon-us
//
//  Created by 박현수 on 1/6/24.
//

import SwiftUI

struct Portfolio: View {
    @State var progressStatus: ProgressStatus
    
    enum PostCategory {
        case sponsorship
        case linkedproject
    }
    
    enum CompletedReportStatus {
        case reportNotSubmitted
        case reportSubmitted
        case unsuccessfulTermination
    }
    
    var publishingDummyData = [
        PublishingPost(thumbNail: Image(.postListDummy), postCategory: .sponsorship, postTitle: "2014 스포대학교 대동제 협찬", savedNumber: 28),
        PublishingPost(thumbNail: Image(.postListDummy), postCategory: .sponsorship, postTitle: "2015 스포대학교 대동제 협찬", savedNumber: 29),
        PublishingPost(thumbNail: Image(.postListDummy), postCategory: .sponsorship, postTitle: "2016 스포대학교 대동제 협찬", savedNumber: 30),
        PublishingPost(thumbNail: Image(.postListDummy), postCategory: .sponsorship, postTitle: "2017 스포대학교 대동제 협찬", savedNumber: 31),
        PublishingPost(thumbNail: Image(.postListDummy), postCategory: .sponsorship, postTitle: "2018 스포대학교 대동제 협찬", savedNumber: 32),
        PublishingPost(thumbNail: Image(.postListDummy), postCategory: .linkedproject, postTitle: "2019 스포대학교 대동제 협찬", savedNumber: 33),
        PublishingPost(thumbNail: Image(.postListDummy), postCategory: .linkedproject, postTitle: "2020 스포대학교 대동제 협찬", savedNumber: 34),
        PublishingPost(thumbNail: Image(.postListDummy), postCategory: .linkedproject, postTitle: "2021 스포대학교 대동제 협찬", savedNumber: 35),
        PublishingPost(thumbNail: Image(.postListDummy), postCategory: .linkedproject, postTitle: "2022 스포대학교 대동제 협찬", savedNumber: 36),
        PublishingPost(thumbNail: Image(.postListDummy), postCategory: .linkedproject, postTitle: "2023 스포대학교 대동제 협찬", savedNumber: 37)
    ]
    
    var progressingDummyData = [
        ProgressingPost(thumbNail: Image(.postListDummy), companyImage: Image(.companyDummy), companyName: "무신사", postCategory: .sponsorship, postTitle: "2020 스포대학교 대동제 협찬"),
        ProgressingPost(thumbNail: Image(.postListDummy), companyImage: Image(.companyDummy), companyName: "무신사", postCategory: .linkedproject, postTitle: "2021 스포대학교 대동제 협찬"),
        ProgressingPost(thumbNail: Image(.postListDummy), companyImage: Image(.companyDummy), companyName: "무신사", postCategory: .sponsorship, postTitle: "2022 스포대학교 대동제 협찬"),
        ProgressingPost(thumbNail: Image(.postListDummy), companyImage: Image(.companyDummy), companyName: "무신사", postCategory: .linkedproject, postTitle: "2023 스포대학교 대동제 협찬"),
    ]
    
    var completedDummyData = [
        CompletedPost(thumbNail: Image(.postListDummy), companyImage: Image(.companyDummy), companyName: "무신사", postCategory: .sponsorship, postTitle: "2023 스포대학교 대동제 협찬", completedReportStatus: .reportNotSubmitted, expireDate: "12월 24일"),
        CompletedPost(thumbNail: Image(.postListDummy), companyImage: Image(.companyDummy), companyName: "무신사", postCategory: .linkedproject, postTitle: "무신사 글로벌 마케팅 연계프로젝트", completedReportStatus: .reportSubmitted, expireDate: "12월 24일"),
        CompletedPost(thumbNail: Image(.postListDummy), companyImage: Image(.companyDummy), companyName: "무신사", postCategory: .linkedproject, postTitle: "스포대학교 창업지원센터 연계프로그램", completedReportStatus: .unsuccessfulTermination, expireDate: "12월 24일")
    ]
    
    struct ProgressStatus {
        init() {
            isPublishing = true
            isProgressing = false
            isCompleted = false
        }
        var isPublishing: Bool
        var isProgressing: Bool
        var isCompleted: Bool
    }
    
    struct PublishingPost: Identifiable {
        let id = UUID()
        var thumbNail: Image?
        var postCategory: PostCategory?
        var postTitle: String?
        var savedNumber: Int?
    }
    
    struct ProgressingPost: Identifiable {
        let id = UUID()
        var thumbNail: Image?
        var companyImage: Image?
        var companyName: String?
        var postCategory: PostCategory?
        var postTitle: String?
    }
    
    struct CompletedPost: Identifiable {
        let id = UUID()
        var thumbNail: Image?
        var companyImage: Image?
        var companyName: String?
        var postCategory: PostCategory?
        var postTitle: String?
        var completedReportStatus: CompletedReportStatus?
        var expireDate: String?
    }
    
    var backButton: some View {
        Button {
            
        } label: { Image(.icBack) }
    }
    
    var publishingButton: some View {
        Button {
            $progressStatus.isPublishing.wrappedValue = true
            $progressStatus.isProgressing.wrappedValue = false
            $progressStatus.isCompleted.wrappedValue = false
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
            $progressStatus.isCompleted.wrappedValue = false
        } label: {
            if ($progressStatus.isProgressing.wrappedValue == true) {
                Text("진행 중").font(.Body01).foregroundStyle(.sponusPrimary)
            }
            else {
                Text("진행 중").font(.Body01).foregroundStyle(.sponusGrey700)
            }
        }
    }
    
    var completedButton: some View {
        Button {
            $progressStatus.isPublishing.wrappedValue = false
            $progressStatus.isProgressing.wrappedValue = false
            $progressStatus.isCompleted.wrappedValue = true
        } label: {
            if ($progressStatus.isCompleted.wrappedValue == true) {
                Text("완료").font(.Body01).foregroundStyle(.sponusPrimary)
            }
            else {
                Text("완료").font(.Body01).foregroundStyle(.sponusGrey700)
            }
        }
    }
    
    var body: some View {
        VStack {
            ZStack {
                VStack(spacing: 0) {
                    Text("진행 중").font(.Body01).opacity(0).padding(.bottom, 18)
                    Rectangle().frame(height: 1).foregroundStyle(.sponusGrey500)
                }
                HStack(spacing: 20) {
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
                        completedButton.padding(.bottom, 18)
                        if ($progressStatus.isCompleted.wrappedValue == true) {
                            Rectangle().frame(height: 2).foregroundStyle(.sponusPrimary)
                        }
                    }.fixedSize()
                    Spacer()
                }
            }
            
            // 게시 중
            if ($progressStatus.isPublishing.wrappedValue == true) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(publishingDummyData.indices) { index in
                            NavigationLink(
                                destination: DetailView(publishingPost: publishingDummyData[index], progressingPost: nil, completedPost: nil),
                                label: {
                                    VStack(spacing: 0) {
                                        HStack(spacing: 0) {
                                            (publishingDummyData[index].thumbNail ?? Image(.icCancel))
                                                .resizable().frame(width: 158, height: 158)
                                                .border(.sponusGrey100)
                                            
                                            VStack(alignment: .leading, spacing: 5) {
                                                
                                                HStack(spacing: 2) {
                                                    Spacer()
                                                    Image(.icSaved).resizable().frame(width: 20, height: 20)
                                                    Text(String(publishingDummyData[index].savedNumber ?? 0))
                                                        .font(.English12).foregroundStyle(.sponusGrey700)
                                                }
                                                switch publishingDummyData[index].postCategory {
                                                case .sponsorship:
                                                    Text("협찬").font(.Caption02).foregroundStyle(.sponusGrey700)
                                                case .linkedproject:
                                                    Text("연계프로젝트").font(.Caption02).foregroundStyle(.sponusGrey700)
                                                case nil:
                                                    Text("nil").font(.Caption02).foregroundStyle(.sponusGrey700)
                                                }
                                                Text(publishingDummyData[index].postTitle ?? "nil").font(.Body07).foregroundStyle(.sponusBlack).multilineTextAlignment(.leading)
                                                Spacer()
                                                
                                                HStack(spacing: 4) {
                                                    Button {} label: {
                                                        Text("끌어올리기").font(.Caption01).foregroundStyle(.sponusBlack)
                                                            .frame(height: 40).frame(maxWidth: .infinity)
                                                    }.border(.sponusGrey100)
                                                    
                                                    Button {} label: {
                                                        Image(.icMore).resizable().frame(width: 40, height: 40)
                                                    }.border(.sponusGrey100)
                                                }
                                            }.padding(.leading, 20)
                                        }.padding(.top, 32)
                                        Divider().backgroundStyle(.sponusGrey200).padding(.top, 16)
                                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                                }
                            )
                        }
                    }
                }.scrollIndicators(.hidden)

            }


            // 진행 중
            if ($progressStatus.isProgressing.wrappedValue == true) {
                ScrollView {
                    VStack {
                        ForEach(progressingDummyData.indices) { index in
                            NavigationLink(
                                destination: DetailView(publishingPost: nil, progressingPost: progressingDummyData[index],
                                                        completedPost: nil),
                                label: {
                                    VStack(alignment:.leading, spacing: 0) {
                                        HStack(spacing: 0) {
                                            (progressingDummyData[index].thumbNail ?? Image(.icCancel))
                                                .resizable().frame(width: 158, height: 158)
                                                .border(.sponusGrey100)
                                            
                                            VStack(alignment: .leading, spacing: 5) {
                                                switch progressingDummyData[index].postCategory {
                                                case .sponsorship:
                                                    Text("협찬").font(.Caption02).foregroundStyle(.sponusGrey700)
                                                case .linkedproject:
                                                    Text("연계프로젝트").font(.Caption02).foregroundStyle(.sponusGrey700)
                                                case nil:
                                                    Text("nil").font(.Caption02).foregroundStyle(.sponusGrey700)
                                                }
                                                Text(progressingDummyData[index].postTitle ?? "nil").font(.Body07).foregroundStyle(.sponusBlack).multilineTextAlignment(.leading).padding(.bottom, 16)
                                                
                                                HStack(spacing: 6) {
                                                    (progressingDummyData[index].companyImage ?? Image(.icCancel)).resizable().aspectRatio(contentMode: .fill).frame(width:24, height:24).clipShape(Circle())
                                                    Text("with \(progressingDummyData[index].companyName ?? "nil")").font(.English16).foregroundStyle(.sponusGrey700)
                                                }.padding(.bottom)
                                                
                                            }.padding(.leading, 20)
                                        }.padding(.top, 32).padding(.bottom, 24)
                                        HStack {
                                            Button {} label: {
                                                Text("협업 중단")
                                                    .font(.Caption01)
                                                    .frame(width: 157, height: 40)
                                                    .foregroundStyle(.sponusRed)
                                                    .border(.sponusRed)
                                            }
                                            Spacer()
                                            Button {} label: {
                                                Text("협업 완료")
                                                    .font(.Caption01)
                                                    .frame(width: 157, height: 40)
                                                    .foregroundStyle(.sponusPrimary)
                                                    .border(.sponusPrimary)
                                            }
                                        }
                                        Divider().backgroundStyle(.sponusGrey200).padding(.top, 16)
                                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                                }
                            )
                        }
                    }
                }.scrollIndicators(.hidden)
            }
            
            
            // 완료
            if ($progressStatus.isCompleted.wrappedValue == true) {
                ScrollView {
                    VStack {
                        ForEach(completedDummyData.indices) { index in
                            NavigationLink(
                                destination: DetailView(publishingPost: nil, progressingPost: progressingDummyData[index],
                                                        completedPost: nil),
                                label: {
                                    VStack(alignment:.leading, spacing: 0) {
                                        HStack(spacing: 0) {
                                            (completedDummyData[index].thumbNail ?? Image(.icCancel))
                                                .resizable().frame(width: 158, height: 158)
                                                .border(.sponusGrey100)
                                            
                                            VStack(alignment: .leading, spacing: 5) {
                                                switch completedDummyData[index].postCategory {
                                                case .sponsorship:
                                                    Text("협찬").font(.Caption02).foregroundStyle(.sponusGrey700)
                                                case .linkedproject:
                                                    Text("연계프로젝트").font(.Caption02).foregroundStyle(.sponusGrey700)
                                                case nil:
                                                    Text("nil").font(.Caption02).foregroundStyle(.sponusGrey700)
                                                }
                                                Text(completedDummyData[index].postTitle ?? "nil").font(.Body07).foregroundStyle(.sponusBlack).multilineTextAlignment(.leading).padding(.bottom, 16)
                                                
                                                HStack(spacing: 6) {
                                                    (completedDummyData[index].companyImage ?? Image(.icCancel)).resizable().aspectRatio(contentMode: .fill).frame(width:24, height:24).clipShape(Circle())
                                                    Text("with \(completedDummyData[index].companyName ?? "nil")").font(.English16).foregroundStyle(.sponusGrey700)
                                                }.padding(.bottom)
                                                
                                            }.padding(.leading, 20)
                                        }.padding(.top, 32).padding(.bottom, 24)
                                        VStack(spacing: 0) {
                                            switch completedDummyData[index].completedReportStatus {
                                            case .reportNotSubmitted:
                                                Button {} label: {
                                                    Text("보고서 작성하기")
                                                        .font(.Caption01)
                                                        .frame(height: 40)
                                                        .frame(maxWidth: .infinity)
                                                        .foregroundStyle(.sponusRed)
                                                        .border(.sponusRed)
                                                }
                                            case .reportSubmitted:
                                                Text("협업이 중단된 공고입니다")
                                                    .font(.Caption01)
                                                    .frame(height: 40)
                                                    .frame(maxWidth: .infinity)
                                                    .foregroundStyle(.sponusGrey700)
                                                    .border(.sponusGrey100)
                                            case .unsuccessfulTermination:
                                                Button {} label: {
                                                    Text("보고서 보러가기")
                                                        .font(.Caption01)
                                                        .frame(height: 40)
                                                        .frame(maxWidth: .infinity)
                                                        .foregroundStyle(.sponusPrimary)
                                                        .border(.sponusPrimary)
                                                }
                                            case nil:
                                                Text("nil")
                                                    .font(.Caption01)
                                                    .frame(height: 40)
                                                    .foregroundStyle(.sponusRed)
                                                    .border(.sponusRed)
                                            }
                                        }
                                        Divider().backgroundStyle(.sponusGrey200).padding(.top, 16)
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
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButton())
    }
}

struct DetailView: View {
    var publishingPost: Portfolio.PublishingPost?
    var progressingPost: Portfolio.ProgressingPost?
    var completedPost: Portfolio.CompletedPost?
    
    var body: some View {
        VStack {
            if (publishingPost != nil) {
                Text("Post Title: \(publishingPost?.postTitle ?? "nil")")
            }
            if (progressingPost != nil) {
                Text("Post Title: \(progressingPost?.postTitle ?? "nil")")
            }
            if (completedPost != nil) {
                Text("Post Title: \(completedPost?.postTitle ?? "nil")")
            }
        }
        .navigationTitle("Detail")
    }
}


//#Preview {
//    Portfolio(progressStatus: Portfolio.ProgressStatus())
//}
