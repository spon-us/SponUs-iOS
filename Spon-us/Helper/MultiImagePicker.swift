//
//  MultiImagePicker.swift
//  Spon-us
//
//  Created by 황인성 on 2024/01/15.
//

import SwiftUI
import PhotosUI

struct MultipleImagePicker: View {
    @State private var selectedImages: [UIImage] = []
    @State private var isImagePickerPresented = false
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(selectedImages, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 79, height: 79)
                    //                        .aspectRatio(contentMode: .fill)
                    //                        .frame(maxWidth: 79, maxHeight: 79)
                }
                
                Button(action: {
                    isImagePickerPresented.toggle()
                }, label: {
                    Rectangle()
                        .fill(.clear)
                        .stroke(Color.sponusGrey100, lineWidth: 1)
                    //                            .frame(maxWidth: 79, maxHeight: 79)
                        .frame(width: 79, height: 79)
                        .overlay(
                            Image("post_image")
                        )
                    
                }).sheet(isPresented: $isImagePickerPresented) {
                    ImagePickerView(selectedImages: $selectedImages)
                }
                
            }
        }
    }
}

struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var selectedImages: [UIImage]
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 0 // Set to 0 for multiple selections
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        private let parent: ImagePickerView
        
        init(_ parent: ImagePickerView) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.selectedImages.removeAll()
            
            for result in results {
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                        if let error = error {
                            print("Error loading image: \(error.localizedDescription)")
                        } else if let image = image as? UIImage {
                            DispatchQueue.main.async {
                                self.parent.selectedImages.append(image)
                            }
                        }
                    }
                }
            }
            picker.dismiss(animated: true)
        }
    }
}

