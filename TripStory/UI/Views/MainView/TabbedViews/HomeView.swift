//
//  HomeView.swift
//  TripStory
//
//  Created by Gon on 2021/01/21.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.injected) private var injected: DIContainer
    let myTripPlaces: [TripPlace] = TripPlace.tripPlaces
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(myTripPlaces) { tripPlace in
                        TripPlaceCell(tripPlace: tripPlace)
                            .padding(.horizontal, .homeViewHorizontalPadding)
                    }
                }
            }
            .onAppear { UINavigationBar.appearance().tintColor = .black }
            .navigationBarTitle("My Trip Places")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(
                action: {},
                label: {
                    Image(systemName: "arrow.backward")
                }
            ), trailing: Button(
                action: {},
                label: {
                    Image(systemName: "line.horizontal.3.decrease.circle")
                }
            ))
        }
    }
}

extension HomeView {
    struct TripPlace: Identifiable {
        var id: UUID
        let name: String
        let image: String
        let visitDate: Date

        static let tripPlaces = [
            TripPlace(id: UUID(), name: "홍천", image: "hong-cheon.jpg", visitDate: Date()),
            TripPlace(id: UUID(), name: "남이섬", image: "nam-e-sum.jpg", visitDate: Date()),
            TripPlace(id: UUID(), name: "여수", image: "yeosu.jpg", visitDate: Date(timeIntervalSince1970: 100)),
            TripPlace(id: UUID(), name: "홍천", image: "hong-cheon.jpg", visitDate: Date()),
            TripPlace(id: UUID(), name: "남이섬", image: "nam-e-sum.jpg", visitDate: Date()),
            TripPlace(id: UUID(), name: "여수", image: "yeosu.jpg", visitDate: Date(timeIntervalSince1970: 100)),
            TripPlace(id: UUID(), name: "홍천", image: "hong-cheon.jpg", visitDate: Date()),
            TripPlace(id: UUID(), name: "남이섬", image: "nam-e-sum.jpg", visitDate: Date()),
            TripPlace(id: UUID(), name: "여수", image: "yeosu.jpg", visitDate: Date(timeIntervalSince1970: 100))
        ]

    }

    struct TripPlaceCell: View {

        let tripPlace: TripPlace
        private static let formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "M/d - a hh:mm"
            return formatter
        }()

        var body: some View {
            VStack {
                HStack(alignment: .firstTextBaseline) {
                    Text(tripPlace.name)
                        .font(.tableCellTitle)
                    Spacer()
                    Text("\(tripPlace.visitDate, formatter: TripPlaceCell.formatter)")
                        .font(.tableCellSubtitle)

                }
                ImageView(url: tripPlace.image, height: .homeViewImageHeight)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
