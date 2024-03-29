//
//  Portfolio.swift
//  Spon-us
//
//  Created by 박현수 on 1/6/24.
//

import SwiftUI

import PopupView
import UniformTypeIdentifiers
import MobileCoreServices
import Moya

// 버튼 탭 애니메이션 X
struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
    }
}

struct SponUsReportTextfieldStyle: TextFieldStyle {
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        
        ZStack {
            Rectangle()
                .fill(Color.clear)
                .stroke(Color.sponusGrey100, lineWidth: 1)
                .frame(maxWidth: .infinity, maxHeight: 56)
            
            // 텍스트필드
            configuration
                .font(.Body06)
                .padding(.vertical, 8)
        }
    }
}

enum ActiveAlert {
    case hide, remove
}

struct Portfolio: View {
    @StateObject var myAnnouncementsViewModel = MyAnnouncementsViewModel()
    @StateObject var portfolioOfferViewModel = PortfolioOfferViewModel()
    @Binding var rootIsActive: Bool
    @State var progressStatus: ProgressStatus = ProgressStatus()
    
    @State var alertcase: ActiveAlert = .hide
    
    @State var showingPublishingConfirmationDialog = false
    @State var showingPublishingToTopAlert = false
    @State var showingPublishingAlert = false
    @State var showingStopCoworkPopup = false
    @State var showingCoworkCompletedPopup = false
    @State var showingStopCoworkCancelPopup = false
    @State var showingCoworkCompletedCancelPopup = false
    
    @State var activeNavLinkToEdit = false
    @State var activeNavLinkToMakeReport = false
    @State var activeNavLinkToReport = false
    @State var activeToPublishingDetail = false
    @State var activeToProgressingDetail = false
    @State var activeToCompletedDetail = false
    
    @State var activeNavLinkToAnnouncement = false
    @State var activeNavLinkToPropose = false
    
    @State private var currentDialogID = 0
    @State private var currentProgressingID = 0
    @State private var currentProgressingStatus = ""
    @State private var currentMakeReportID = 0
    @State private var currentReportProposeID = 0
    @State private var currentReportID = 0
    @State private var currentProposeID = 0
    
    
    struct ProgressStatus {
        var isPublishing = true
        var isProgressing = false
        var isCompleted = false
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
    
    func createStopCoworkToastMessage() -> some View {
        HStack {
            Text("협업이 중단되었습니다").font(.Body03).foregroundStyle(.sponusRed).padding(.leading, 32)
            Spacer()
            Button {
                portfolioOfferViewModel.cancelStopOffer(proposeId: currentProgressingID, status: currentProgressingStatus) { success in
                    if success {
                        showingStopCoworkPopup = false
                        showingStopCoworkCancelPopup = true
                    }
                }
            } label: {
                Text("취소").font(.Body04).foregroundStyle(.sponusGrey700).padding(.trailing, 32)
            }
        }.frame(height: 56).frame(maxWidth: .infinity).background(Color.sponusRedSecondary)
    }
    
    func createCoworkCompletedToastMessage() -> some View {
        HStack {
            Text("협업이 완료되었습니다").font(.Body03).foregroundStyle(.sponusPrimary).padding(.leading, 32)
            Spacer()
            Button {
                portfolioOfferViewModel.cancelCompleteOffer(proposeId: currentProgressingID, status: currentProgressingStatus) { success in
                    if success {
                        showingCoworkCompletedPopup = false
                        showingCoworkCompletedCancelPopup = true
                    }
                }
            } label: {
                Text("취소").font(.Body04).foregroundStyle(.sponusGrey700).padding(.trailing, 32)
            }
        }.frame(height: 56).frame(maxWidth: .infinity).background(Color.sponusSecondary)
    }
    
    func createStopCoworkCancelToastMessage() -> some View {
        HStack {
            Text("취소되었습니다").font(.Body03).foregroundStyle(.sponusGrey900)
        }.frame(height: 56).frame(maxWidth: .infinity).background(Color.sponusRedSecondary)
    }
    
    func createCoworkCompletedCancelToastMessage() -> some View {
        HStack {
            Text("취소되었습니다").font(.Body03).foregroundStyle(.sponusGrey900)
        }.frame(height: 56).frame(maxWidth: .infinity).background(Color.sponusSecondary)
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
            if ($progressStatus.isPublishing.wrappedValue == true) {
                if myAnnouncementsViewModel.isLoading == true {
                    VStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                }
                else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 0) {
                            ForEach(myAnnouncementsViewModel.myAnnouncementsContents, id: \.id) { cell in
                                if cell.status == "OPENED" {
                                    Button {
                                        currentDialogID = cell.id
                                        activeNavLinkToAnnouncement = true
                                    } label: {
                                            VStack(spacing: 0) {
                                                HStack(spacing: 0) {
                                                    AsyncImageView(url: URL(string: cell.mainImage.url))
                                                        .frame(width: 158, height: 158)
                                                        .border(.sponusGrey100)
                                                    
                                                    VStack(alignment: .leading, spacing: 5) {
                                                        
                                                        HStack(spacing: 2) {
                                                            Spacer()
                                                            Image(.icSaved).resizable().frame(width: 20, height: 20)
                                                            Text(String(10))
                                                                .font(.English12).foregroundStyle(.sponusGrey700)
                                                        }
                                                        switch cell.type {
                                                        case "SPONSORSHIP":
                                                            Text("협찬").font(.Caption02).foregroundStyle(.sponusGrey700)
                                                        case "PARTNERSHIP":
                                                            Text("제휴").font(.Caption02).foregroundStyle(.sponusGrey700)
                                                        case "COLLABORATION":
                                                            Text("연계프로젝트").font(.Caption02).foregroundStyle(.sponusGrey700)
                                                        default:
                                                            Text("nil").font(.Caption02).foregroundStyle(.sponusGrey700)
                                                        }
                                                        Text(cell.title ).font(.Body07).foregroundStyle(.sponusBlack).multilineTextAlignment(.leading)
                                                        Spacer()
                                                        
                                                        HStack(spacing: 4) {
                                                            withAnimation {
                                                                Button() {
                                                                    currentDialogID = cell.id
                                                                    showingPublishingToTopAlert = true
                                                                } label: {
                                                                    Text("끌어올리기").font(.Caption01).foregroundStyle(.sponusBlack)
                                                                        .frame(height: 40).frame(maxWidth: .infinity).border(.sponusGrey100)
                                                                }.alert(isPresented: $showingPublishingToTopAlert) {
                                                                    return Alert(
                                                                        title: Text("끌어올리시겠습니까?"),
                                                                        message: Text("공고가 상단으로 끌어올려집니다."),
                                                                        primaryButton: .destructive(
                                                                            Text("아니오").foregroundStyle(Color.red)
                                                                        ),
                                                                        secondaryButton: .default(
                                                                            Text("끌어올리기"),
                                                                            action: {
                                                                                myAnnouncementsViewModel.pullUp(announcementID: currentDialogID) { success in
                                                                                    if success {
                                                                                        myAnnouncementsViewModel.myAnnouncementsContents.removeAll()
                                                                                        myAnnouncementsViewModel.getMyAnnouncements()
                                                                                    }
                                                                                }
                                                                            }
                                                                        )
                                                                    )
                                                                    
                                                                }
                                                            }
                                                            
                                                            Button() {
                                                                showingPublishingConfirmationDialog = true
                                                                currentDialogID = cell.id
                                                                //                                                            currentConfirmationDialogID = dummy.id
                                                            } label: {
                                                                Image(.icMore).resizable().frame(width: 40, height: 40).border(.sponusGrey100)
                                                            }
                                                            .confirmationDialog("ic_more", isPresented: $showingPublishingConfirmationDialog, titleVisibility: .hidden, actions: {
                                                                Button("수정하기") {
                                                                    
                                                                    activeNavLinkToEdit = true
                                                                    showingPublishingConfirmationDialog = false
                                                                    
                                                                }
                                                                Button("제안 그만 받기") {
                                                                    alertcase = .hide
                                                                    showingPublishingAlert = true
                                                                    showingPublishingConfirmationDialog = false
                                                                }
                                                                Button("삭제", role: .destructive) {
                                                                    alertcase = .remove
                                                                    showingPublishingAlert = true
                                                                    showingPublishingConfirmationDialog = false
                                                                }
                                                                Button("닫기", role: .cancel) {}
                                                            })
                                                            .alert(isPresented: $showingPublishingAlert) {
                                                                switch alertcase {
                                                                case .hide:
                                                                    return Alert(
                                                                        title: Text("해당 공고를 내립니다"),
                                                                        message: Text("내린 공고는 되돌리기 어렵습니다."),
                                                                        primaryButton: .destructive(
                                                                            Text("내리기"),
                                                                            action: {
                                                                                myAnnouncementsViewModel.ChangeAnnouncementStatus(announcementID: currentDialogID) { success in
                                                                                    if success {
                                                                                        myAnnouncementsViewModel.getMyAnnouncements()
                                                                                    }
                                                                                }
                                                                            }
                                                                        ),
                                                                        secondaryButton: .cancel(
                                                                            Text("취소")
                                                                        )
                                                                    )
                                                                case .remove:
                                                                    if let toRemoveAnnouncement = myAnnouncementsViewModel.myAnnouncementsContents.first(where: { $0.id == currentDialogID }) {
                                                                        return Alert(
                                                                            title: Text("삭제하시겠습니까?"),
                                                                            message: Text("\(toRemoveAnnouncement.title)\n공고가 삭제됩니다."),
                                                                            primaryButton: .destructive(
                                                                                Text("삭제"),
                                                                                action: {
                                                                                    myAnnouncementsViewModel.deleteAnnouncement(announcementID: currentDialogID) { success in
                                                                                        if success {
                                                                                            myAnnouncementsViewModel.getMyAnnouncements()
                                                                                        }
                                                                                    }
                                                                                }
                                                                            ),
                                                                            secondaryButton: .cancel(
                                                                                Text("아니오")
                                                                            )
                                                                        )
                                                                    } else {
                                                                        return Alert(title: Text("공고를 찾을 수 없습니다."))
                                                                    }
                                                                    
                                                                }
                                                            }
                                                        }
                                                        
                                                    }.padding(.leading, 20)
                                                }.padding(.top, 32)
                                                Divider().backgroundStyle(.sponusGrey200).padding(.top, 16)
                                            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                                        }
                                    
                                }
                            }
                        }
                    }.scrollIndicators(.hidden)
                }
            }
            
            // 진행 중
            if ($progressStatus.isProgressing.wrappedValue == true) {
                
                ZStack {
                    ScrollView {
                        //                            Button {
                        //                                print(portfolioOfferViewModel.myProposes)
                        //                            } label: {
                        //                                Text("gg")
                        //                            }
                        
                        VStack {
                            ForEach(portfolioOfferViewModel.myProposes, id: \.proposeId) { cell in
                                if cell.status != "SUSPENDED" && cell.status != "COMPLETED" {
                                    Button {
                                        currentProposeID = cell.proposeId
                                        activeNavLinkToPropose = true
                                    } label: {
                                        VStack(alignment:.leading, spacing: 0) {
                                            HStack(spacing: 0) {
                                                AsyncImageView(url: URL(string: cell.announcementSummary.mainImage.url))
                                                    .frame(width: 158, height: 158)
                                                    .border(.sponusGrey100)
                                                
                                                VStack(alignment: .leading, spacing: 5) {
                                                    switch cell.announcementSummary.type {
                                                    case "SPONSORSHIP":
                                                        Text("협찬").font(.Caption02).foregroundStyle(.sponusGrey700)
                                                    case "COLLABORATION":
                                                        Text("연계프로젝트").font(.Caption02).foregroundStyle(.sponusGrey700)
                                                    case "PARTNERSHIP":
                                                        Text("제휴").font(.Caption02).foregroundStyle(.sponusGrey700)
                                                    default:
                                                        Text("nil").font(.Caption02).foregroundStyle(.sponusGrey700)
                                                    }
                                                    Text(cell.title).font(.Body07).foregroundStyle(.sponusBlack).multilineTextAlignment(.leading).padding(.bottom, 16)
                                                    HStack(spacing: 6) {
                                                        if cell.proposingOrganizationImageUrl != nil{
                                                            AsyncImageView(url: URL(string: cell.proposingOrganizationImageUrl!)).aspectRatio(contentMode: .fill).frame(width:24, height:24).clipShape(Circle())
                                                        }
                                                        else {
                                                            Image(.profileTest).resizable().aspectRatio(contentMode: .fill).frame(width:24, height:24).clipShape(Circle())
                                                        }
                                                        Text("with \(cell.proposingOrganizationName)").font(.English16).foregroundStyle(.sponusGrey700)
                                                    }.padding(.bottom)
                                                    
                                                }.padding(.leading, 20)
                                            }.padding(.top, 32).padding(.bottom, 24)
                                            HStack {
                                                Button {
                                                    currentProgressingID = cell.proposeId
                                                    currentProgressingStatus = cell.status
                                                    portfolioOfferViewModel.stopOffer(proposeId: currentProgressingID) { success in
                                                        if success {
                                                            showingStopCoworkPopup = true
                                                        }
                                                    }
                                                } label: {
                                                    Text("협업 중단")
                                                        .font(.Caption01)
                                                        .frame(width: 157, height: 40)
                                                        .foregroundStyle(.sponusRed)
                                                        .border(.sponusRed)
                                                    
                                                }
                                                Spacer()
                                                Button {
                                                    currentProgressingID = cell.proposeId
                                                    currentProgressingStatus = cell.status
                                                    portfolioOfferViewModel.completeOffer(proposeId: currentProgressingID) { success in
                                                        if success {
                                                            showingCoworkCompletedPopup = true
                                                        }
                                                    }
                                                } label: {
                                                    Text("협업 완료")
                                                        .font(.Caption01)
                                                        .frame(width: 157, height: 40)
                                                        .foregroundStyle(.sponusPrimary)
                                                        .border(.sponusPrimary)
                                                }
                                            }
                                            Divider().backgroundStyle(.sponusGrey200).padding(.top, 16)
                                        }
                                    }
                                }
                            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }.scrollIndicators(.hidden)
                }
                .popup(isPresented: $showingStopCoworkPopup) {
                    createStopCoworkToastMessage().onDisappear() {
                        portfolioOfferViewModel.offerContents.removeAll()
                        portfolioOfferViewModel.getOffers() { success in
                            if success {
                                portfolioOfferViewModel.getProposes()
                            }
                        }
                    }
                } customize: {
                    $0.type(.floater(verticalPadding: 16))
                        .position(.bottom)
                        .animation(.spring)
                        .closeOnTap(false)
                        .closeOnTapOutside(true)
                        .autohideIn(3)
                }
                .popup(isPresented: $showingCoworkCompletedPopup) {
                    createCoworkCompletedToastMessage().onDisappear() {
                        portfolioOfferViewModel.offerContents.removeAll()
                        portfolioOfferViewModel.getOffers() { success in
                            if success {
                                portfolioOfferViewModel.getProposes()
                            }
                        }
                    }
                } customize: {
                    $0.type(.floater(verticalPadding: 16))
                        .position(.bottom)
                        .animation(.spring)
                        .closeOnTap(false)
                        .closeOnTapOutside(true)
                        .autohideIn(3)
                }
                .popup(isPresented: $showingStopCoworkCancelPopup) {
                    createStopCoworkCancelToastMessage().onDisappear() {
                        portfolioOfferViewModel.offerContents.removeAll()
                        portfolioOfferViewModel.getOffers() { success in
                            if success {
                                portfolioOfferViewModel.getProposes()
                            }
                        }
                    }
                } customize: {
                    $0.type(.floater(verticalPadding: 16))
                        .position(.bottom)
                        .animation(.spring)
                        .closeOnTap(true)
                        .closeOnTapOutside(true)
                        .autohideIn(2)
                }
                .popup(isPresented: $showingCoworkCompletedCancelPopup) {
                    createCoworkCompletedCancelToastMessage().onDisappear() {
                        portfolioOfferViewModel.offerContents.removeAll()
                        portfolioOfferViewModel.getOffers() { success in
                            if success {
                                portfolioOfferViewModel.getProposes()
                            }
                        }
                    }
                } customize: {
                    $0.type(.floater(verticalPadding: 16))
                        .position(.bottom)
                        .animation(.spring)
                        .closeOnTap(true)
                        .closeOnTapOutside(true)
                        .autohideIn(2)
                }
            }
            
            
            // 완료
            if ($progressStatus.isCompleted.wrappedValue == true) {
                if (portfolioOfferViewModel.isLoading == true) {
                    VStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                }
                else {
                    ScrollView {
                        VStack {
                            ForEach(portfolioOfferViewModel.myProposes, id: \.proposeId) { cell in
                                if (cell.status == "SUSPENDED" || cell.status == "COMPLETED" || cell.announcementSummary.status == "CLOSED") {
                                    Button {
                                        currentProposeID = cell.proposeId
                                        activeNavLinkToPropose = true
                                    } label: {
                                        VStack(alignment:.leading, spacing: 0) {
                                            HStack(spacing: 0) {
                                                AsyncImageView(url: URL(string: cell.announcementSummary.mainImage.url))
                                                    .frame(width: 158, height: 158)
                                                    .border(.sponusGrey100)
                                                
                                                VStack(alignment: .leading, spacing: 5) {
                                                    switch cell.announcementSummary.type {
                                                    case "SPONSORSHIP":
                                                        Text("협찬").font(.Caption02).foregroundStyle(.sponusGrey700)
                                                    case "COLLABORATION":
                                                        Text("연계프로젝트").font(.Caption02).foregroundStyle(.sponusGrey700)
                                                    case "PARTNERSHIP":
                                                        Text("제휴").font(.Caption02).foregroundStyle(.sponusGrey700)
                                                    default:
                                                        Text("nil").font(.Caption02).foregroundStyle(.sponusGrey700)
                                                    }
                                                    Text(cell.title).font(.Body07).foregroundStyle(.sponusBlack).multilineTextAlignment(.leading).padding(.bottom, 16)
                                                    
                                                    HStack(spacing: 6) {
                                                        if cell.proposingOrganizationImageUrl != nil{
                                                            AsyncImageView(url: URL(string: cell.proposingOrganizationImageUrl!)).aspectRatio(contentMode: .fill).frame(width:24, height:24).clipShape(Circle())
                                                        }
                                                        else {
                                                            Image(.profileTest).resizable().aspectRatio(contentMode: .fill).frame(width:24, height:24).clipShape(Circle())
                                                        }
                                                        Text("with \(cell.proposingOrganizationName)").font(.English16).foregroundStyle(.sponusGrey700)
                                                    }.padding(.bottom)
                                                    
                                                }.padding(.leading, 20)
                                            }.padding(.top, 32).padding(.bottom, 24)
                                            VStack(spacing: 0) {
                                                if cell.status == "SUSPENDED" {
                                                    Text("협업이 중단된 공고입니다")
                                                        .font(.Caption01)
                                                        .frame(height: 40)
                                                        .frame(maxWidth: .infinity)
                                                        .foregroundStyle(.sponusGrey700)
                                                        .border(.sponusGrey100)
                                                }
                                                else {
                                                    if cell.isReported == true {
                                                        Button {
                                                            currentReportProposeID = cell.proposeId
                                                            currentReportID = cell.reportId!
                                                            activeNavLinkToReport = true
                                                        } label: {
                                                            Text("보고서 보러가기")
                                                                .font(.Caption01)
                                                                .frame(height: 40)
                                                                .frame(maxWidth: .infinity)
                                                                .foregroundStyle(.sponusPrimary)
                                                                .border(.sponusPrimary)
                                                        }
                                                    }
                                                    else {
                                                        Button {
                                                            currentReportProposeID = cell.proposeId
                                                            
                                                            activeNavLinkToMakeReport = true
                                                        } label: {
                                                            Text("보고서 작성하기")
                                                                .font(.Caption01)
                                                                .frame(height: 40)
                                                                .frame(maxWidth: .infinity)
                                                                .foregroundStyle(.sponusRed)
                                                                .border(.sponusRed)
                                                        }
                                                    }
                                                }
                                                
                                            }
                                            Divider().backgroundStyle(.sponusGrey200).padding(.top, 16)
                                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                                    }
                                }
                            }
                        }
                    }.scrollIndicators(.hidden)
                }
                
            }
        }.padding()
            .navigationTitle("포트폴리오").font(.Body01)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButton())
            .navigationDestination(isPresented: $activeNavLinkToEdit) {
                EditAnnouncementView(announcementID: currentDialogID, popup: .constant(false))
            }
            .navigationDestination(isPresented: $activeNavLinkToMakeReport) {
                MakeReportView(rootIsActive: self.$rootIsActive, proposeID: currentMakeReportID)
            }
            .navigationDestination(isPresented: $activeNavLinkToReport) {
                ReportView(currentReportId: currentReportID, popToRootView: self.$rootIsActive)
            }
            .navigationDestination(isPresented: $activeNavLinkToAnnouncement) {
                AnnouncementDetailView(rootIsActive: self.$rootIsActive, announcementId: self.currentDialogID)
            }
            .navigationDestination(isPresented: $activeNavLinkToPropose) {
                MyProposeView(proposeId: self.currentProposeID, rootIsActive: self.$rootIsActive)
            }
            .toolbar(.hidden, for: .tabBar)
            .onAppear() {
                myAnnouncementsViewModel.getMyAnnouncements()
                portfolioOfferViewModel.getOffers() { success in
                    if success {
                        portfolioOfferViewModel.getProposes()
                    }
                }
            }
    }
}


struct MakeReportView: View {
    @StateObject var makeReportViewModel = MakeReportViewModel()
    @Binding var rootIsActive: Bool
    @State var proposeID: Int
    @State private var postTitle = ""
    @State private var selectedImages: [UIImage] = []
    @State private var postSelectedCategory = ""
    @State private var postSelectedField = ""
    @State private var postDetail = ""
    
    @State private var selectedURLsFile1: [URL] = []
    @State private var selectedURLsFile2: [URL] = []
    @State private var selectedURLsFile3: [URL] = []
    @State private var isDocumentPicker1Presented = false
    @State private var isDocumentPicker2Presented = false
    @State private var isDocumentPicker3Presented = false
    @State private var fileButton1Text = "파일 선택"
    @State private var fileButton2Text = "파일 선택"
    @State private var fileButton3Text = "파일 선택"
    
    @State var showingPopup = false
    @State var showingPreviewAlert = false
    @State var goToPreview = false
    
    @FocusState var focusTitleTextEditor: Bool
    @FocusState var focusContentsTextEditor: Bool
    
    
    @Environment(\.presentationMode) var presentationMode
    
    let provider = MoyaProvider<SponusAPI>(plugins: [NetworkLoggerPlugin()])
    
    func createPopup() -> some View {
        HStack {
            Text("작성이 완료되었습니다").font(.Body03).foregroundStyle(.sponusPrimary)
        }.frame(height: 56).frame(maxWidth: .infinity).background(Color.sponusSecondary)
    }
    
    var body: some View {
        let postTitleTextEditor = TextEditor(text: $postTitle)
            .font(.Body06)
            .frame(height: 24)
        
        
        let postContentsTextEditor = TextEditor(text: $postDetail)
            .frame(minHeight: 130)
            .font(.Caption02)
        
        let compleBtnInActive = postTitle.isEmpty || selectedImages.isEmpty || postDetail.isEmpty || (selectedURLsFile1.isEmpty && selectedURLsFile2.isEmpty && selectedURLsFile3.isEmpty)
        
        ZStack {
            VStack(spacing: 0) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16){
                        
                        SponUsPostCell(text: "보고서 제목", isComplete: $postTitle).padding(.top, 16)
                        
                        ZStack (alignment: .leading) {
                            HStack{
                                Text("").frame(maxWidth: .infinity).frame(height: 56)
                            }
                            VStack {
                                Spacer()
                                postTitleTextEditor.focused($focusTitleTextEditor, equals: true).padding(.horizontal, 12)
                                Spacer()
                            }
                            VStack {
                                Spacer()
                                if postTitle.isEmpty {
                                    Button(action: {
                                        focusTitleTextEditor = true
                                        print("focusTitle")
                                    }) {
                                        VStack {
                                            Text("ex. 대동제 협찬 보고서")
                                                .font(.Body06)
                                                .foregroundStyle(.sponusGrey600)
                                        }
                                    }.buttonStyle(CustomButtonStyle())
                                        .padding(.horizontal)
                                }
                                Spacer()
                            }
                            
                        }.border(.sponusGrey100)
                        
                        SponUsPostCell(text: "보고서 내용", isComplete: $postDetail)
                        
                        ZStack (alignment: .leading) {
                            
                            HStack{
                                Text("").frame(maxWidth: .infinity).frame(minHeight: 162)
                            }
                            VStack {
                                Spacer()
                                postContentsTextEditor.focused($focusContentsTextEditor, equals: true).padding(.horizontal, 12).lineSpacing(5)
                                Spacer()
                            }
                            VStack {
                                if postDetail.isEmpty {
                                    Button(action: {
                                        focusContentsTextEditor = true
                                        print("focusContents")
                                    }) {
                                        VStack {
                                            Text("보고서에 대한 자세한 내용을 적어주세요.\nex. 진행 배경, 진행 내용, 기대 효과, 희망 사항")
                                                .font(.Caption02)
                                                .foregroundStyle(.sponusGrey600)
                                                .lineSpacing(5)
                                        }
                                    }.buttonStyle(CustomButtonStyle())
                                        .padding(.top, 12)
                                        .padding(.horizontal)
                                }
                                Spacer()
                            }
                            
                            
                            //                            postContentsTextEditor.focused($focusContentsTextEditor, equals: true)
                            //                            if postDetail.isEmpty {
                            //                                Button(action: {
                            //                                    focusContentsTextEditor = true
                            //                                    print("focus")
                            //                                }) {
                            //                                    VStack {
                            //                                        Text("보고서에 대한 자세한 내용을 적어주세요.\nex. 진행 배경, 진행 내용, 기대 효과, 희망 사항")
                            //                                            .font(.Caption02)
                            //                                            .foregroundStyle(.sponusGrey600)
                            //                                            .padding(.leading)
                            //                                            .padding(.top)
                            //                                        Spacer()
                            //                                    }
                            //                                }.buttonStyle(CustomButtonStyle())
                            //
                            //                            }
                        }.border(.sponusGrey100)
                        
                        SponUsPostImageCell(text: "이미지 첨부", selectedImages: $selectedImages)
                        
                        MultipleImagePicker(selectedImages: $selectedImages)
                        
                        Text("보고서를 대표할 수 있는 이미지를 첨부해 주세요.")
                            .font(.Caption02)
                            .foregroundStyle(.sponusGrey600)
                            .padding(.bottom, 16)
                        
                        SponUsPostFileCell(text: "파일 첨부", selectedURLsFile1: $selectedURLsFile1, selectedURLsFile2: $selectedURLsFile2, selectedURLsFile3: $selectedURLsFile3)
                        
                        HStack {
                            Text(fileButton1Text).font(.Body10).foregroundStyle(fileButton1Text == "파일 선택" ? .sponusGrey700 : .sponusBlack).padding(.leading, 20)
                            Spacer()
                            Button {
                                if (fileButton1Text != "파일 선택") {
                                    fileButton1Text = "파일 선택"
                                }
                                else {
                                    isDocumentPicker1Presented.toggle()
                                }
                                selectedURLsFile1 = []
                            }
                        label: {
                            Image(fileButton1Text == "파일 선택" ? .icUpload : .icCancel).resizable().frame(width: 24, height: 24)
                        }.fileImporter(
                            isPresented: $isDocumentPicker1Presented,
                            allowedContentTypes: [UTType.pdf],
                            allowsMultipleSelection: false,
                            onCompletion: { result in
                                do {
                                    selectedURLsFile1 = try result.get()
                                    fileButton1Text = selectedURLsFile1[0].lastPathComponent
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }
                        )
                        .padding(.trailing, 20)
                        }.padding(.vertical, 16).border(.sponusGrey100)
                        
                        Text("상세 내용이 적힌 PDF 파일을 첨부해 주세요")
                            .font(.Caption02)
                            .foregroundStyle(.sponusGrey600)
                            .padding(.bottom, 55)
                        //                        HStack {
                        //                            Spacer()
                        //                            Button {
                        //                                if (compleBtnInActive == true) {
                        //                                    showingPreviewAlert = true
                        //                                }
                        //                                else {
                        //                                    goToPreview = true
                        //                                }
                        //                            }
                        //                        label: {
                        //                            Text("미리보기").font(.Body10).foregroundStyle(.sponusGrey700).frame(width: 73, height: 37)
                        //                        }.border(.sponusGrey700)
                        //                            Spacer()
                        //                        }.padding(.bottom, 55)
                    }
                    .font(.Heading09)
                    .foregroundColor(Color.sponusBlack)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
                
                
                
                //                NavigationLink(destination: EmptyView(), label: {
                //                    Text("수정완료")
                //                        .font(.Body01)
                //                        .foregroundColor(compleBtnInActive ? Color.sponusGrey200 : Color.sponusPrimaryDarkmode)
                //                      .frame(maxWidth: .infinity)
                //                      .padding(.top, 20)
                //                      .background(compleBtnInActive ? Color.sponusGrey600 : Color.sponusBlack)
                //                })
                //                .disabled(compleBtnInActive)
                
                Button(action: {
                    showingPopup = true
                }, label: {
                    Text("작성완료")
                        .font(.Body01)
                        .foregroundColor(compleBtnInActive ? Color.sponusGrey200 : Color.sponusPrimaryDarkmode)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 20)
                        .background(compleBtnInActive ? Color.sponusGrey600 : Color.sponusBlack)
                }).disabled(compleBtnInActive)
                
            }
            .navigationTitle("보고서 작성").font(.Body01)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButton())
            .navigationDestination(isPresented: $goToPreview) {
                ReportPreviewView(popToRootView: self.$rootIsActive)
            }
            
        }.popup(isPresented: $showingPopup) {
            createPopup().onDisappear(){
                provider.request(.postReport(title: postTitle, content: postDetail, proposeID: proposeID, images: selectedImages, attatchments: selectedURLsFile1)) { result in
                    let innerProposeID = proposeID
                    switch result {
                    case let .success(response):
                        do {
                            let responseBody = try response.map(PostReportResponse.self)
                            print("report success")
                            print(responseBody)
                            presentationMode.wrappedValue.dismiss()
                        } catch {
                            print("postreport parse error")
                        }
                        
                    case let .failure(response):
                        if let responsee = response.response {
                            // 실패한 요청의 응답 본문이 있는 경우
                            if let responseBody = String(data: responsee.data, encoding: .utf8) {
                                print("Response body: \(responseBody)")
                            } else {
                                print("Failed to decode response body.")
                            }
                        } else {
                            print("No response body.")
                        }
                        print(response.localizedDescription)
                        print(response.errorDescription)
                        print("postreport error")
                    }
                }
                
            }
        } customize: {
            $0.type(.floater(verticalPadding: 16))
                .position(.bottom)
                .animation(.spring)
                .closeOnTap(true)
                .closeOnTapOutside(true)
                .autohideIn(2)
        }
        .alert(isPresented: $showingPreviewAlert) {
            Alert(
                title: Text("필수기입란 미입력"),
                message: Text("필수기입란을 모두 입력하세요.")
            )
        }
        //        }
    }
}

struct ReportPreviewView: View {
    @Binding var popToRootView: Bool
    @State var popup = false
    
    var body: some View {
        VStack(spacing: 0) {
            //                if popup == true{
            //                    Text("popup = true")
            //                }
            ScrollView {
                LazyVStack(spacing: 0){
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 10) {
                            ForEach(0 ..< 5) { trip in
                                
                                Image("TestPhoto")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 380)
                                //                                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                //                                .padding(.horizontal, 20)
                                    .containerRelativeFrame(.horizontal)
                                //                                .containerRelativeFrame(.horizontal, count: 1, span: 1, spacing: 10)
                                    .scrollTransition(.animated, axis: .horizontal) { content, phase in
                                        content
                                            .opacity(phase.isIdentity ? 1.0 : 0.8)
                                            .scaleEffect(phase.isIdentity ? 1.0 : 0.8)
                                    }
                                
                            }
                        }
                        .scrollTargetLayout()
                        
                    }
                    //                .scrollIndicators(.)
                    .scrollTargetBehavior(.viewAligned)
                    .safeAreaPadding(.horizontal, 45.0) //se일때는 40
                    
                    LazyVStack(alignment: .leading, spacing: 0) {
                        
                        HStack{
                            Image("ic_eye_small")
                            Text("989")
                            Image("ic_saved_small")
                            Text("34")
                        }
                        .font(.English16)
                        .foregroundColor(Color.sponusGrey700)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        
                        NavigationLink {
                            //                            ProfileView(rootIsActive: $popToRootView)
                            Text("더미 채우기")
                        } label: {
                            HStack{
                                Text("스포대학교 총학생회")
                                    .font(.Body10)
                                    .foregroundColor(Color.sponusPrimary)
                                
                                Image("ic_go_blue")
                                    .frame(width: 16, height: 16)
                                    .foregroundStyle(.sponusPrimary)
                            }
                        }.padding(.top, 23)
                        // Korean/Heading/Heading05
                        Text("스포대학교 축제 협찬 보고서")
                            .font(.Heading05)
                            .foregroundColor(Color.sponusBlack)
                            .padding(.top, 16)
                        
                        Rectangle()
                            .fill(Color.sponusGrey200)
                            .frame(maxWidth: .infinity, maxHeight: 1)
                            .padding(.top, 16)
                        
                        
                        // Korean/Body/Body10
                        Text("보고서 상세")
                            .font(.Body10)
                            .foregroundColor(Color.sponusGrey700)
                            .padding(.top, 24)
                        
                        // Korean/Body/Body10
                        Text("안녕하세요 스포대학교 제 21대 학생회 스포너스입니다.\n귀사의 도움을 받아 이번에 진행한 행사에 대해 보고 드립니다.  활동 내용: 카드뉴스 제작, 배너 제작,\n기업 인스타그램 태그 이벤트 \n그 외의 내용은 첨부한 pdf 파일에 상세 기재해 두었습니다.\n 다시 한번 저희와 협업해 주셔서 감사합니다.")
                            .font(.Body10)
                            .foregroundColor(.black)
                            .padding(.top, 24)
                        
                        Rectangle()
                            .fill(Color.sponusGrey200)
                            .frame(maxWidth: .infinity, maxHeight: 1)
                            .padding(.top, 24)
                            .padding(.bottom, 32)
                        
                        Text("첨부파일 다운로드")
                            .padding(.bottom, 16)
                        
                        SponUsDivider().padding(.bottom, 16)
                        
                        HStack {
                            Text("스포대학교_보고서.pdf").font(.Body10).padding(.leading, 20)
                            Spacer()
                            Button {
                                
                            }
                        label: {
                            Image(.icDownload).resizable().frame(width: 24, height: 24)
                        }.padding(.trailing, 20)
                        }.padding(.vertical, 16).border(.sponusGrey100)
                        
                        
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 20)
            }
        }.navigationTitle("미리보기").font(.Body01)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButton(), trailing: Button(action: {self.popToRootView = false}, label: {
                Image(.icHome)
                    .renderingMode(.template)
                    .foregroundStyle(.black)
            }))
            .toolbarBackground(Color.white, for: .navigationBar)
    }
}

struct ReportView: View {
    @State var isActivated = false
    @State var currentReportId: Int
    @State var reportTitle = ""
    @State var reportContent = ""
    @State var reportImageURLs: [URL] = []
    @State var reportAttachmentURLs: [URL] = []
    @State var reportAttachmentTitles: [String?] = []
    
    @State private var isShowingActivityView = false
    @State private var activityItems: [Any] = [URL(string: "https://example.com")!]
    @Environment(\.presentationMode) var presentationMode
    @Binding var popToRootView: Bool
    @State var popup = false
    
    let provider = MoyaProvider<SponusAPI>(session: Session(interceptor: AuthInterceptor.shared))
    
    var body: some View {
        if !isActivated {
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
                        AsyncImageScrollView(imageURLs: reportImageURLs)
                        //                        ScrollView(.horizontal) {
                        //                            LazyHStack(spacing: 10) {
                        //                                ForEach(reportImageURLs.indices) { index in
                        //
                        //                                    AsyncImageView(url: reportImageURLs[index])
                        //                                        .scaledToFill()
                        //                                        .frame(height: 380)
                        //                                    //                                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                        //                                    //                                .padding(.horizontal, 20)
                        //                                        .containerRelativeFrame(.horizontal)
                        //                                    //                                .containerRelativeFrame(.horizontal, count: 1, span: 1, spacing: 10)
                        //                                        .scrollTransition(.animated, axis: .horizontal) { content, phase in
                        //                                            content
                        //                                                .opacity(phase.isIdentity ? 1.0 : 0.8)
                        //                                                .scaleEffect(phase.isIdentity ? 1.0 : 0.8)
                        //                                        }
                        //
                        //                                }
                        //                            }
                        //                            .scrollTargetLayout()
                        //
                        //                        }
                        //                        //                .scrollIndicators(.)
                        //                        .scrollTargetBehavior(.viewAligned)
                        //                        .safeAreaPadding(.horizontal, 45.0) //se일때는 40
                        
                        LazyVStack(alignment: .leading, spacing: 0) {
                            
                            //                        HStack{
                            //                            Image("ic_eye_small")
                            //                            Text("989")
                            //                            Image("ic_saved_small")
                            //                            Text("34")
                            //                        }
                            //                        .font(.English16)
                            //                        .foregroundColor(Color.sponusGrey700)
                            //                        .frame(maxWidth: .infinity, alignment: .trailing)
                            
                            NavigationLink {
                                //                            ProfileView(rootIsActive: $popToRootView)
                                Text("더미 채우기")
                            }
                        label: {
                            HStack{
                                Text("스포대학교 총학생회")
                                    .font(.Body10)
                                    .foregroundColor(Color.sponusPrimary)
                                
                                Image("ic_go_blue")
                                    .frame(width: 16, height: 16)
                                    .foregroundStyle(.sponusPrimary)
                            }
                        }.padding(.top, 23).disabled(true)
                            // Korean/Heading/Heading05
                            Text(reportTitle)
                                .font(.Heading05)
                                .foregroundColor(Color.sponusBlack)
                                .padding(.top, 16)
                            
                            Rectangle()
                                .fill(Color.sponusGrey200)
                                .frame(maxWidth: .infinity, maxHeight: 1)
                                .padding(.top, 16)
                            
                            
                            // Korean/Body/Body10
                            Text("보고서 상세")
                                .font(.Body10)
                                .foregroundColor(Color.sponusGrey700)
                                .padding(.top, 24)
                            
                            // Korean/Body/Body10
                            Text(reportContent)
                                .font(.Body10)
                                .foregroundColor(.black)
                                .padding(.top, 24)
                            
                            Rectangle()
                                .fill(Color.sponusGrey200)
                                .frame(maxWidth: .infinity, maxHeight: 1)
                                .padding(.top, 24)
                                .padding(.bottom, 32)
                            
                            Text("첨부파일 다운로드")
                                .padding(.bottom, 16)
                            
                            SponUsDivider().padding(.bottom, 16)
                            
                            HStack {
                                Text(((reportAttachmentTitles.first ?? "0") ?? "0")).font(.Body10).padding(.leading, 20)
                                Spacer()
                                Button {
                                    
                                } label: {
                                    Image(.icDownload).resizable().frame(width: 24, height: 24)
                                }.padding(.trailing, 20)
                            }.padding(.vertical, 16).border(.sponusGrey100)
                            
                            
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 20)
                    
                }
                
                
            }.navigationTitle("보고서").font(.Body01)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: CustomBackButton(), trailing: Button(action: {self.popToRootView = false}, label: {
                    Image(.icHome)
                        .renderingMode(.template)
                        .foregroundStyle(.black)
                }))
                .toolbarBackground(Color.white, for: .navigationBar)
        }
        
        
        
        ZStack {
            Button(action: {presentationMode.wrappedValue.dismiss()}, label: {
                Text("확인").font(.Body01).foregroundColor(Color.sponusPrimaryDarkmode)})
            HStack {
                Button(action: {isShowingActivityView = true}, label: {Image(.icShareWhite).resizable().frame(width: 24, height: 24).padding(.leading, 28)})
                    .sheet(isPresented: $isShowingActivityView) {
                        ActivityView(activityItems: activityItems)
                    }
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 20)
        .background(Color.sponusBlack)
        .onAppear() {
            provider.request(.getReport(reportId: currentReportId)) { result in
                switch result {
                case let .success(response):
                    do {
                        let responseBody = try response.map(ReportResponseModel.self)
                        self.reportTitle = responseBody.content.title
                        self.reportContent = responseBody.content.content
                        for elem in responseBody.content.reportImages {
                            reportImageURLs.append(URL(string: elem.url)!)
                        }
                        for elem in responseBody.content.reportAttachments {
                            reportAttachmentURLs.append(URL(string: elem.url)!)
                        }
                        for elem in responseBody.content.reportAttachments {
                            reportAttachmentTitles.append(elem.name)
                        }
                        isActivated = true
                    } catch {
                        print("getReport parse error")
                    }
                case let .failure(response):
                    print("getReport failure")
                }
            }
        }
    }
}


#Preview {
    Portfolio(rootIsActive: .constant(false))
}
//#Preview {
//    ReportView()
//}
