//
//  Portfolio.swift
//  Spon-us
//
//  Created by 박현수 on 1/6/24.
//

import SwiftUI

struct Portfolio: View {
    @State var progressStatus: ProgressStatus
    
    @State var showingPublishingConfirmationDialog = false
    @State var showingPublishingToTopAlert = false
    @State var showingPublishingStopOfferAlert = false
    @State var showingPublishingRemoveAlert = false
    
    @State private var currentConfirmationDialogID: UUID?
    @State private var currentToTopID: UUID?
    
    @State var dummyData = [
        Post(thumbNail: Image(.postListDummy), postCategory: .sponsorship, postTitle: "2024 스포대학교 대동제 협찬", savedNumber: 28, companyImage: Image(.companyDummy), companyName: "무신사", completedReportStatus: .reportNotSubmitted, expireDate: "12월 24일", postProgressStatus: .publishing, displayInPublishing: true),
        
        Post(thumbNail: Image(.postListDummy), postCategory: .linkedproject, postTitle: "2023 스포대학교 대동제 협찬", savedNumber: 29, companyImage: Image(.companyDummy), companyName: "무신사", completedReportStatus: .reportNotSubmitted, expireDate: "12월 24일", postProgressStatus: .publishing, displayInPublishing: true),
        
        Post(thumbNail: Image(.postListDummy), postCategory: .sponsorship, postTitle: "2022 스포대학교 대동제 협찬", savedNumber: 30, companyImage: Image(.companyDummy), companyName: "무신사", completedReportStatus: .reportNotSubmitted, expireDate: "12월 24일", postProgressStatus: .publishing, displayInPublishing: true),
        
        Post(thumbNail: Image(.postListDummy), postCategory: .linkedproject, postTitle: "2021 스포대학교 대동제 협찬", savedNumber: 31, companyImage: Image(.companyDummy), companyName: "무신사", completedReportStatus: .reportNotSubmitted, expireDate: "12월 24일", postProgressStatus: .publishing, displayInPublishing: true),
        
        Post(thumbNail: Image(.postListDummy), postCategory: .sponsorship, postTitle: "2020 스포대학교 대동제 협찬", savedNumber: 28, companyImage: Image(.companyDummy), companyName: "무신사", completedReportStatus: .reportNotSubmitted, expireDate: "12월 24일", postProgressStatus: .progressing, displayInPublishing: true),
        
        Post(thumbNail: Image(.postListDummy), postCategory: .linkedproject, postTitle: "2019 스포대학교 대동제 협찬", savedNumber: 28, companyImage: Image(.companyDummy), companyName: "무신사", completedReportStatus: .reportNotSubmitted, expireDate: "12월 24일", postProgressStatus: .progressing, displayInPublishing: true),
        
        Post(thumbNail: Image(.postListDummy), postCategory: .sponsorship, postTitle: "2018 스포대학교 대동제 협찬", savedNumber: 28, companyImage: Image(.companyDummy), companyName: "무신사", completedReportStatus: .reportNotSubmitted, expireDate: "12월 24일", postProgressStatus: .progressing, displayInPublishing: true),
        
        Post(thumbNail: Image(.postListDummy), postCategory: .sponsorship, postTitle: "2014 스포대학교 대동제 협찬", savedNumber: 28, companyImage: Image(.companyDummy), companyName: "무신사", completedReportStatus: .reportNotSubmitted, expireDate: "12월 24일", postProgressStatus: .completed, displayInPublishing: true),
        
        Post(thumbNail: Image(.postListDummy), postCategory: .linkedproject, postTitle: "스포대학교 창업지원센터 연계프로그램", savedNumber: 28, companyImage: Image(.companyDummy), companyName: "무신사", completedReportStatus: .reportSubmitted, expireDate: "12월 24일", postProgressStatus: .completed, displayInPublishing: true),
        
        Post(thumbNail: Image(.postListDummy), postCategory: .linkedproject, postTitle: "무신사 글로벌 마케팅 연계프로젝트", savedNumber: 28, companyImage: Image(.companyDummy), companyName: "무신사", completedReportStatus: .unsuccessfulTermination, expireDate: "12월 24일", postProgressStatus: .completed, displayInPublishing: true)
    ]
    
    enum PostProgressStatus {
        case publishing
        case progressing
        case completed
    }
    
    enum PostCategory {
        case sponsorship
        case linkedproject
    }
    
    enum CompletedReportStatus {
        case reportNotSubmitted
        case reportSubmitted
        case unsuccessfulTermination
    }
    
    struct ProgressStatus {
        var isPublishing = true
        var isProgressing = false
        var isCompleted = false
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
    
    struct Post: Identifiable {
        let id = UUID()
        var thumbNail: Image?
        var postCategory: PostCategory?
        var postTitle: String?
        var savedNumber: Int?
        var companyImage: Image?
        var companyName: String?
        var completedReportStatus: CompletedReportStatus?
        var expireDate: String?
        var postProgressStatus: PostProgressStatus?
        var displayInPublishing: Bool?
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
    
    func movePostToTop(index: Int) {
        dummyData.insert(dummyData.remove(at: index), at: 0)
    }
    
    func removePublishingPost() {
        withAnimation {
            if let index = dummyData.firstIndex(where: { $0.id == currentConfirmationDialogID }) {
                dummyData.remove(at: index)
            }
        }
    }
    
    func hidePublishingPost() {
        withAnimation {
            if let index = dummyData.firstIndex(where: { $0.id == currentConfirmationDialogID }) {
                dummyData[index].displayInPublishing = false
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
                        ForEach(dummyData, id: \.id) { dummy in
                            if (dummy.postProgressStatus == .publishing && dummy.displayInPublishing == true) {
                                NavigationLink(
                                    destination: DetailView(post: dummy),
                                    label: {
                                        VStack(spacing: 0) {
                                            HStack(spacing: 0) {
                                                (dummy.thumbNail ?? Image(.icCancel))
                                                    .resizable().frame(width: 158, height: 158)
                                                    .border(.sponusGrey100)
                                                
                                                VStack(alignment: .leading, spacing: 5) {
                                                    
                                                    HStack(spacing: 2) {
                                                        Spacer()
                                                        Image(.icSaved).resizable().frame(width: 20, height: 20)
                                                        Text(String(dummy.savedNumber ?? 0))
                                                            .font(.English12).foregroundStyle(.sponusGrey700)
                                                    }
                                                    switch dummy.postCategory {
                                                    case .sponsorship:
                                                        Text("협찬").font(.Caption02).foregroundStyle(.sponusGrey700)
                                                    case .linkedproject:
                                                        Text("연계프로젝트").font(.Caption02).foregroundStyle(.sponusGrey700)
                                                    case nil:
                                                        Text("nil").font(.Caption02).foregroundStyle(.sponusGrey700)
                                                    }
                                                    Text(dummy.postTitle ?? "nil").font(.Body07).foregroundStyle(.sponusBlack).multilineTextAlignment(.leading)
                                                    Spacer()
                                                    
                                                    HStack(spacing: 4) {
                                                        withAnimation {
                                                            Button() {
                                                                showingPublishingToTopAlert = true
                                                                currentToTopID = dummy.id
                                                            } label: {
                                                                Text("끌어올리기").font(.Caption01).foregroundStyle(.sponusBlack)
                                                                    .frame(height: 40).frame(maxWidth: .infinity).border(.sponusGrey100)
                                                            }.alert(isPresented: $showingPublishingToTopAlert) {
                                                                if let index = dummyData.firstIndex(where: { $0.id == currentToTopID }) {
                                                                    return Alert(
                                                                        title: Text("끌어올리시겠습니까?"),
                                                                        message: Text("공고가 상단으로 끌어올려집니다."),
                                                                        primaryButton: .destructive(
                                                                            Text("아니오").foregroundStyle(Color.red)
                                                                        ),
                                                                        secondaryButton: .default(
                                                                            Text("끌어올리기"),
                                                                            action: withAnimation{{ movePostToTop(index: index) }}
                                                                        )
                                                                    )
                                                                }
                                                                return Alert(title: Text("Default Title"), message: Text("Default Message"))
                                                            }
                                                        }
                                                       
                                                        Button() {
                                                            showingPublishingConfirmationDialog = true
                                                            currentConfirmationDialogID = dummy.id
                                                        } label: {
                                                            Image(.icMore).resizable().frame(width: 40, height: 40).border(.sponusGrey100)
                                                        }.confirmationDialog("ic_more", isPresented: $showingPublishingConfirmationDialog, titleVisibility: .hidden, actions: {
                                                            Button("수정하기") {
                                                                showingPublishingConfirmationDialog = false
                                                            }
                                                            Button("제안 그만 받기") {
                                                                showingPublishingStopOfferAlert = true
                                                                showingPublishingConfirmationDialog = false
                                                            }
                                                            Button("삭제", role: .destructive) {
                                                                showingPublishingRemoveAlert = true
                                                                showingPublishingConfirmationDialog = false
                                                            }
                                                            Button("닫기", role: .cancel) {}
                                                        }).alert(isPresented: $showingPublishingRemoveAlert) {
                                                            if let index = dummyData.firstIndex(where: { $0.id == currentConfirmationDialogID }) {
                                                                return Alert(
                                                                        title: Text("삭제하시겠습니까?"),
                                                                        message: Text("\(dummyData[index].postTitle ?? "nil")\n공고가 삭제됩니다."),
                                                                        primaryButton: .destructive(
                                                                            Text("삭제"),
                                                                            action: {removePublishingPost()}
                                                                        ),
                                                                        secondaryButton: .cancel(
                                                                            Text("아니오")
                                                                        )
                                                                    )
                                                            }
                                                            return Alert(title: Text("nil"))
                                                        }
                                                        .alert(isPresented: $showingPublishingStopOfferAlert) {
                                                            if let index = dummyData.firstIndex(where: { $0.id == currentConfirmationDialogID }) {
                                                                return Alert(
                                                                        title: Text("해당 공고를 내립니다"),
                                                                        message: Text("내린 공고는 되돌리기 어렵습니다."),
                                                                        primaryButton: .destructive(
                                                                            Text("내리기"),
                                                                            action: {hidePublishingPost()}
                                                                        ),
                                                                        secondaryButton: .cancel(
                                                                            Text("취소")
                                                                        )
                                                                    )
                                                            }
                                                            return Alert(title: Text("nil"))
                                                        }
                                                        
                                                    }
                                                }.padding(.leading, 20)
                                            }.padding(.top, 32)
                                            Divider().backgroundStyle(.sponusGrey200).padding(.top, 16)
                                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                                    }
                                )
                            }
                            
                        }
                    }
                }.scrollIndicators(.hidden)

            }


            // 진행 중
            if ($progressStatus.isProgressing.wrappedValue == true) {
                ScrollView {
                    VStack {
                        ForEach(dummyData) { dummy in
                            if (dummy.postProgressStatus == .progressing) {
                                NavigationLink(
                                    destination: DetailView(post: dummy),
                                    label: {
                                        VStack(alignment:.leading, spacing: 0) {
                                            HStack(spacing: 0) {
                                                (dummy.thumbNail ?? Image(.icCancel))
                                                    .resizable().frame(width: 158, height: 158)
                                                    .border(.sponusGrey100)
                                                
                                                VStack(alignment: .leading, spacing: 5) {
                                                    switch dummy.postCategory {
                                                    case .sponsorship:
                                                        Text("협찬").font(.Caption02).foregroundStyle(.sponusGrey700)
                                                    case .linkedproject:
                                                        Text("연계프로젝트").font(.Caption02).foregroundStyle(.sponusGrey700)
                                                    case nil:
                                                        Text("nil").font(.Caption02).foregroundStyle(.sponusGrey700)
                                                    }
                                                    Text(dummy.postTitle ?? "nil").font(.Body07).foregroundStyle(.sponusBlack).multilineTextAlignment(.leading).padding(.bottom, 16)
                                                    
                                                    HStack(spacing: 6) {
                                                        (dummy.companyImage ?? Image(.icCancel)).resizable().aspectRatio(contentMode: .fill).frame(width:24, height:24).clipShape(Circle())
                                                        Text("with \(dummy.companyName ?? "nil")").font(.English16).foregroundStyle(.sponusGrey700)
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
                    }
                }.scrollIndicators(.hidden)
            }
            
            
            // 완료
            if ($progressStatus.isCompleted.wrappedValue == true) {
                ScrollView {
                    VStack {
                        ForEach(dummyData) { dummy in
                            if (dummy.postProgressStatus == .completed) {
                                NavigationLink(
                                    destination: DetailView(post: dummy),
                                    label: {
                                        VStack(alignment:.leading, spacing: 0) {
                                            HStack(spacing: 0) {
                                                (dummy.thumbNail ?? Image(.icCancel))
                                                    .resizable().frame(width: 158, height: 158)
                                                    .border(.sponusGrey100)
                                                
                                                VStack(alignment: .leading, spacing: 5) {
                                                    switch dummy.postCategory {
                                                    case .sponsorship:
                                                        Text("협찬").font(.Caption02).foregroundStyle(.sponusGrey700)
                                                    case .linkedproject:
                                                        Text("연계프로젝트").font(.Caption02).foregroundStyle(.sponusGrey700)
                                                    case nil:
                                                        Text("nil").font(.Caption02).foregroundStyle(.sponusGrey700)
                                                    }
                                                    Text(dummy.postTitle ?? "nil").font(.Body07).foregroundStyle(.sponusBlack).multilineTextAlignment(.leading).padding(.bottom, 16)
                                                    
                                                    HStack(spacing: 6) {
                                                        (dummy.companyImage ?? Image(.icCancel)).resizable().aspectRatio(contentMode: .fill).frame(width:24, height:24).clipShape(Circle())
                                                        Text("with \(dummy.companyName ?? "nil")").font(.English16).foregroundStyle(.sponusGrey700)
                                                    }.padding(.bottom)
                                                    
                                                }.padding(.leading, 20)
                                            }.padding(.top, 32).padding(.bottom, 24)
                                            VStack(spacing: 0) {
                                                switch dummy.completedReportStatus {
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
    var post: Portfolio.Post?
    var body: some View {
        Text("Post Title: \(post?.postTitle ?? "nil")")
        .navigationTitle("Detail")
    }
}

struct ModifyView: View {
    var post: Portfolio.Post?

    var body: some View {
        Text("Post Title: \(post?.postTitle ?? "nil")")
        .navigationTitle("Modify")
    }
}


//#Preview {
//    Portfolio(progressStatus: Portfolio.ProgressStatus())
//}
