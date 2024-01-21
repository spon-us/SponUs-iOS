//
//  DocumentPicker.swift
//  Spon-us
//
//  Created by 박현수 on 1/19/24.
//

import SwiftUI

struct DocumentPicker: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPicker>) -> some DocumentPicker.UIViewControllerType {
        let picker = UIDocumentPickerViewController(documentTypes: [], in: .open)
        picker.allowsMultipleSelection = false
        return picker
    }
    func updateUIViewController(_ uiViewController: DocumentPicker.UIViewControllerType, context: UIViewControllerRepresentableContext<DocumentPicker>) {
        <#code#>
    }
}
