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
