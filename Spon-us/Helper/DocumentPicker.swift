//
//  DocumentPicker.swift
//  Spon-us
//
//  Created by 박현수 on 1/19/24.
//

import UniformTypeIdentifiers

//import SwiftUI

//import MobileCoreServices
//
//struct DocumentPicker: UIViewControllerRepresentable {
//
//    @Binding var selectedURL: URL?
//
//    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
//        let viewController = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.pdf, UTType.plainText], asCopy: true)
//        viewController.delegate = context.coordinator
//        return viewController
//    }
//
//    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {
//    }
//
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(parent: self)
//    }
//
//    class Coordinator: NSObject, UIDocumentPickerDelegate {
//        var parent: DocumentPicker
//
//        init(parent: DocumentPicker) {
//            self.parent = parent
//        }
//
//        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
//            if let selectedURL = urls.first {
//                parent.selectedURL = selectedURL
//            }
//        }
//    }
//}

extension UTType {
    static let doc: Self = .init(filenameExtension: "doc")!
    static let docx: Self = .init(filenameExtension: "docx")!

    static let ppt: Self = .init(filenameExtension: "ppt")!
    static let pptx: Self = .init(filenameExtension: "pptx")!
    
    static let hwp: Self = .init(filenameExtension: "hwp")!
    static let hwpx: Self = .init(filenameExtension: "hwpx")!
}
