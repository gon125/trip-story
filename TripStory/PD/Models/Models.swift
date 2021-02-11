//
//  Models.swift
//  TripStory
//
//  Created by Geonhyeong LIm on 2021/02/05.
//

import Foundation

struct Video: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let description: String?

    init(name: String, image: String, description: String? = nil) {
        self.name = name
        self.image = image
        self.description = description
    }

    static let videos = [
        Video(name: "고씨동굴1", image: "go-see-cave.jpg", description: "고씨 동굴을 추억하며 ..."),
        Video(name: "고씨동굴2", image: "go-see-cave.jpg", description: "고씨 동굴을 추억하며 ..."),
        Video(name: "고씨동굴3", image: "go-see-cave.jpg", description: "고씨 동굴을 추억하며 ...")
    ]
}
