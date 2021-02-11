//
//  ImageView.swift
//  TripStory
//
//  Created by Gon on 2021/01/31.
//

import SwiftUI

struct ImageView: View {

    let url: String
    let width: CGFloat?
    let height: CGFloat?
    @Environment(\.injected) var injected: DIContainer
    @State private var image: Loadable<UIImage>

    init(url: String, image: Loadable<UIImage> = .notRequested, width: CGFloat? = nil, height: CGFloat? = nil) {
        self.url = url
        self._image = .init(initialValue: image)
        self.width = width
        self.height = height
    }

    var body: some View {
        switch image {
        case .notRequested: notRequestedView
        case .isLoading: loadingView
        case let .loaded(image): loadedView(image)
        case let .failed(error): failedView(error)
        }
    }
}

private extension ImageView {
    var notRequestedView: some View {
        Text("").onAppear {
            injected.interactors.imageInteractor.load(image: $image, url: url)
        }
    }
    var loadingView: some View {
        HStack(alignment: .top) {
            Spacer()
            ProgressView()
            Spacer()
        }
        .frame(width: width, height: height)

    }

    func loadedView(_ image: UIImage) -> some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
            .clipped()

    }

    func failedView(_ error: Error) -> some View {
        Image("placeholder-image")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
            .clipped()
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(url: "go-see-cave.jpg")
            .inject(DIContainer.preview)
    }
}
