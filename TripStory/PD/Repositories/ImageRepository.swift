//
//  ImageRepository.swift
//  TripStory
//
//  Created by Gon on 2021/01/31.
//

import Foundation
import Combine
import SwiftUI
import FirebaseStorage

protocol ImageRepository {
    func load(imageURL: URL) -> AnyPublisher<UIImage, Error>
}
struct FirebaseImageRepository: ImageRepository {
    let baseURL = "images/"

    func load(imageURL: URL) -> AnyPublisher<UIImage, Error> {

        Future<UIImage, Error> { promise in
            let storage = Storage.storage()
            let ref = storage.reference().child(baseURL + imageURL.absoluteString)
            ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    print(error)
                    promise(.failure(error))
                    return
                }
                promise(.success(data.flatMap(UIImage.init)!))
            }
        }
        .eraseToAnyPublisher()
    }

}
