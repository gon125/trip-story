//
//  VideoView.swift
//  TripStory
//
//  Created by Gon on 2021/02/03.
//

import SwiftUI

struct VideoView: View {
    let videos: [Video] = Video.videos
    var body: some View {
        ZStack {
            Color.white
            VStack {
                Color.major.frame(height: 130).cornerRadius(40, corners: [.bottomLeft, .bottomRight])
                Spacer()
                VStack {
                    ZStack {
                        thumnails
                    }

                }
                Spacer()
                VStack {

                }
                Color.major.frame(height: 130).cornerRadius(40, corners: [.topLeft, .topRight])
            }

        }.ignoresSafeArea()
        .navigationTitle("Related Videos")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            UINavigationBar.appearance().tintColor = .white
        }
    }

    private var thumnails: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(videos) { video in
                    ImageView(url: video.image, width: 200, height: 200 )
//                        .rotation3DEffect(
//                            Angle(degrees: 10),
//                            axis: (x: 0, y: 10.0, z: 0),
//
//                            )
                }
            }
            .padding(.horizontal, (UIScreen.main.bounds.width - 200) / 2)
        }
        .frame(width: UIScreen.main.bounds.width)
    }
}

extension VideoView {
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
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VideoView()
        }
    }
}
