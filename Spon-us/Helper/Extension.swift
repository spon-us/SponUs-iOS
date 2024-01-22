//
//  Extension.swift
//  Spon-us
//
//  Created by 황인성 on 1/22/24.
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


extension View {
  func navigationBarBackground(_ background: Color = Color(red: 0.18, green: 0.2, blue: 0.21).opacity(0.6)) -> some View {
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
