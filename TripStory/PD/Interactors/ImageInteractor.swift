//
//  ImageInteractor.swift
//  TripStory
//
//  Created by Gon on 2021/01/31.
//

import Foundation
import Combine
import SwiftUI

protocol ImageInteractor {
    func load(image: Binding<Loadable<UIImage>>, url: String)
}

struct DefaultImageInteractor: ImageInteractor {
    let imageRepository: ImageRepository

    func load(image: Binding<Loadable<UIImage>>, url: String) {
        guard let url = URL(string: url) else {
            image.wrappedValue = .notRequested
            return
        }
        let cancelBag = CancelBag()
        image.wrappedValue.setIsLoading(cancelBag: cancelBag)
        imageRepository.load(imageURL: url)
            .sink(receiveCompletion: { completion in
                switch completion {
                case let .failure(error): image.wrappedValue = .failed(error)
                case .finished: break
                }
            }, receiveValue: { value in
                image.wrappedValue = .loaded(value)
            })
            .store(in: cancelBag)
    }

}

#if DEBUG
struct StubImageInteractor: ImageInteractor {
    func load(image: Binding<Loadable<UIImage>>, url: String) {
        return
    }

}
#endif
