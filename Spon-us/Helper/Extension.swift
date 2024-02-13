//
//  Extension.swift
//  Spon-us
//
//  Created by 황인성 on 1/25/24.
//

import Foundation
import UIKit
import SwiftUI

extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}


extension View {
    func navigationBarBackground(_ background: Color = Color(.sponusBlack).opacity(0.6)) -> some View {
        return self
            .modifier(ColoredNavigationBar(background: background))
    }
    func mynavigationBarBackground(_ background: Color = Color(.sponusBlack)) -> some View {
        return self
            .modifier(ColoredNavigationBar(background: background))
    }
}

struct ColoredNavigationBar: ViewModifier {
    var background: Color
    
    func body(content: Content) -> some View {
        content
            .toolbarBackground(
                background,
                for: .navigationBar
            )
            .toolbarBackground(.visible, for: .navigationBar)
    }
}

func changeToEnglish(category: String? = nil, type: String? = nil) -> String? {
    // 카테고리 처리
    if let category = category {
        switch category {
        case "전체":
            return nil
        case "기획/아이디어":
            return "IDEA"
        case "광고/마케팅":
            return "MARKETING"
        case "디자인":
            return "DESIGN"
        case "사진/영상":
            return "MEDIA"
        case "IT/소프트웨어/게임":
            return "DEVELOPMENT"
        case "기타":
            return "OTHER"
        default:
            return nil
        }
    }

    // 타입 처리
    if let type = type {
        switch type {
        case "전체":
            return nil
        case "협찬":
            return "SPONSORSHIP"
        case "제휴":
            return "PARTNERSHIP"
        case "연계프로젝트":
            return "COLLABORATION"
        default:
            return nil
        }
    }

    return nil
}

func changeToKorean(category: String? = nil, type: String? = nil) -> String? {
    if let category = category {
        switch category {
        case "IDEA":
            return "기획/아이디어"
        case "MARKETING":
            return "광고/마케팅"
        case "DESIGN":
            return "디자인"
        case "MEDIA":
            return "사진/영상"
        case "DEVELOPMENT":
            return "IT/소프트웨어/게임"
        case "OTHER":
            return "기타"
        default:
            return "전체"
        }
    }
    if let type = type {
        switch type {
        case "SPONSORSHIP":
            return "협찬"
        case "PARTNERSHIP":
            return "제휴"
        case "COLLABORATION":
            return "연계프로젝트"
        default:
            return "전체"
        }
    }
    return nil
}
