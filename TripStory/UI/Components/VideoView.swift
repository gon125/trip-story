//
//  VideoView.swift
//  TripStory
//
//  Created by Gon on 2021/02/03.
//

import SwiftUI

struct VideoListView: View {
    let videos: [Video] = Video.videos
    @State var progress: Double = 0.5
    @State private var selectedVideo: Video?
    private let thumnailWidth: CGFloat = 260

    var body: some View {
        ZStack {
            Color.white
            VStack {
                Color.major.frame(height: 130).cornerRadius(40, corners: [.bottomLeft, .bottomRight])
                Spacer()
                    .frame(maxHeight: 50)
                VStack {
                    ZStack {
                        thumnails
                        Image(systemName: "play.fill")
                            .resizable()
                            .frame(width: 88, height: 88)
                            .foregroundColor(.major)
                    }

                    Text(selectedVideo?.name ?? "고씨동굴2")
                        .font(.videoTitle)
                        .padding()
                    Text(selectedVideo?.name ?? "꽤 멋진 곳")
                        .font(.videoSubtitle)
                    Spacer()
                    VStack {
                        HStack {
                            Text("02:31")
                            Spacer()
                            Text("04:52")
                        }
                        Slider(value: $progress)
                            .accentColor(.major)
                    }
                    .padding(.horizontal, .horizontalPadding)

                }
                Spacer()
                VStack {

                }
                Color.major.frame(height: 130).cornerRadius(40, corners: [.topLeft, .topRight])
            }

        }.ignoresSafeArea()
        .navigationBarTitle("Related Videos")
        .navigationBarTitleDisplayMode(.inline)
        // .navigationBarTitleColor(titleColor: .white)
    }

    private var thumnails: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(videos) { video in
                    ImageView(url: video.image, width: thumnailWidth, height: thumnailWidth )
                        .cornerRadius(10)
//                        .rotation3DEffect(
//                            Angle(degrees: 10),
//                            axis: (x: 0, y: 10.0, z: 0),
//
//                            )
                }

            }
            .padding(.horizontal, (UIScreen.main.bounds.width - thumnailWidth) / 2)
        }
        .frame(width: UIScreen.main.bounds.width)
    }
}

extension VideoListView {
    private class ViewModel: ObservableObject {

    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VideoListView(progress: 0.5)
        }
        .environment(\.locale, .init(identifier: "ko"))
    }
}
