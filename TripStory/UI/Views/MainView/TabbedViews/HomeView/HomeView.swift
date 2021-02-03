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
    @State private var sortingOrder: SortingOrder = .latest

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(myTripPlaces.sorted(by: sortingFunction)) { tripPlace in
                        NavigationLink(
                            destination: ScheduleView()) {
                                TripPlaceCell(tripPlace: tripPlace)
                                    .padding(.horizontal, .homeViewHorizontalPadding)
                        }

                    }
                }
            }
            .onAppear { UINavigationBar.appearance().tintColor = .black
                injected.appState[\.routing.mainViewRouting] = .home
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("My Trip Places")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing:
                    Menu {
                        Button("Latest") { self.sortingOrder = .latest }
                        Button("Oldest") { self.sortingOrder = .oldest }
                    } label: {
                        Label("", systemImage: "line.horizontal.3.decrease.circle")
                    }
            )

        }
    }
}

extension HomeView {
    enum SortingOrder {
        case latest
        case oldest
    }

    var sortingFunction: (TripPlace, TripPlace) -> Bool {
        switch sortingOrder {
        case .latest: return { $0.visitDate > $1.visitDate }
        case .oldest: return { $0.visitDate < $1.visitDate }
        }
    }
}

extension HomeView {
    struct TripPlace: Identifiable {
        let id = UUID()
        let name: String
        let image: String
        let visitDate: Date

        static let tripPlaces = [
            TripPlace(name: "홍천", image: "hong-cheon.jpg", visitDate: Date(timeIntervalSince1970: 200)),
            TripPlace(name: "남이섬", image: "nam-e-sum.jpg", visitDate: Date(timeIntervalSince1970: 300)),
            TripPlace(name: "여수", image: "yeosu.jpg", visitDate: Date(timeIntervalSince1970: 100)),
            TripPlace(name: "홍천", image: "hong-cheon.jpg", visitDate: Date(timeIntervalSince1970: 250)),
            TripPlace(name: "남이섬", image: "nam-e-sum.jpg", visitDate: Date(timeIntervalSince1970: 310)),
            TripPlace(name: "여수", image: "yeosu.jpg", visitDate: Date(timeIntervalSince1970: 140))
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
                .foregroundColor(.black)
                ImageView(url: tripPlace.image, height: .homeViewImageHeight)
                    .cornerRadius(.buttonCornerRadius)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
