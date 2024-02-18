//
//  AsyncImageView.swift
//  Spon-us
//
//  Created by 김수민 on 2/17/24.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var cancellable: AnyCancellable?

    func load(fromURL url: URL) {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }

    deinit {
        cancellable?.cancel()
    }
}

struct AsyncImageView: View {
    @StateObject private var loader = ImageLoader()
    let url: URL?

    var body: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                Image(.profileTest)
                    .resizable()
            }
        }
        .onAppear {
            if let url = url {
                loader.load(fromURL: url)
            }
        }
    }
}
