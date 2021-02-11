//
//  PlaceDetailView.swift
//  TripStory
//
//  Created by Gon on 2021/02/03.
//

import SwiftUI

struct PlaceDetailView: View {
    let place: Place

    init(name: String) {
        self.place = Place.places[name]!
    }
    var body: some View {
        ZStack {
            GeometryReader { geo in
                VStack {
                    ImageView(url: place.image, height: (geo.size.height / 3) + 40 )
                    Spacer()
                }
                VStack {
                    Spacer()
                        .frame(height: (geo.size.height / 3) - 30)
                    VStack {
                        titleView
                        Divider()
                        addressView
                        Divider()
                        contactView
                        Divider()
                        descriptionView
                    }
                    .padding(.top, 50)
                    .padding(.horizontal, .horizontalPadding)
                    .background(Color.white)
                    .cornerRadius(50, corners: [.topLeft, .topRight])
                }

            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    private var titleView: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(place.name)
                .font(.tableCellTitle)
            Spacer()
            NavigationLink(
                destination: VideoListView(),
                label: {
                    Image(systemName: "play.fill")
                        .resizable()
                        .foregroundColor(.major)
                        .frame(width: 24, height: 24)
                })
            Spacer()
                .frame(width: 20)
            Image(systemName: "headphones")
                .resizable()
                .foregroundColor(.major)
                .frame(width: 24, height: 24)
        }
    }

    private var addressView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Address")
                    .padding(.bottom, 2)
                Text(place.address)
            }
            Spacer()
            Image(systemName: "map.fill")
                .resizable()
                .foregroundColor(.major)
                .frame(width: 24, height: 24)
        }
    }

    private var contactView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Contact")
                    .padding(.bottom, 2)
                Text(place.contact)
            }
            Spacer()
            Image(systemName: "phone.fill")
                .resizable()
                .foregroundColor(.major)
                .frame(width: 24, height: 24)
        }
    }

    private var descriptionView: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Summary")
                    .padding(.bottom, 2)
                Text(place.summary)
                Divider()
                Text("Description")
                    .padding(.bottom, 2)
                Text(place.description)
            }
        }
    }
}

extension Substring: Identifiable {
    public var id: UUID {
        UUID()
    }
}

extension PlaceDetailView {
    struct Place {
        let name: String
        let image: String
        let address: String
        let contact: String
        let summary: String
        let description: String

        #if DEBUG
        static let description = """
        강원도 영월군 하동면 와석리 노루목에 조성된 난고 김병연(金炳淵)의 유적지. 별호인 김삿갓으로 불리는 난고 김병연(1807~1863)을 기념하는 유적지와 부대시설이 조성되어 있다. 김삿갓 연구자료를 전시하고 있는 난고문학관과 많은 돌탑이 조성되어 있는 묘, 작은 성황당, 마대산을 따라 김삿갓이 살던 집터 등이 있다.

        방랑시인이었던 김병연은 1863년 전남 화순군 동북면 구암리 정시룡 댁에서 생을 마감했는데 3년 뒤 아들 익균이 화순의 초분지를 찾아 지금의 강원도 영월군 하동면(현 김삿갓면) 와석리 노루목 기슭으로 이장했다. 김병연의 묘소는 116년이 지나 1982년 확인되었으며, 묘소 주변으로 시비공원을 지었다.

        유적지 중 집터의 주거지 건물 또한 1982년에 발견되었는데, 2002년에 새로 복원해 지었다. 매년 10월 중순 김삿갓 묘역이 있는 김삿갓면 노루목 마을에서는 추모제, 추모살풀이춤, 백일장 등의 문화행사와 관광객들이 참여하는 체험행사가 열린다. 와석리의 기타 관광지로는 조선민화박물관, 묵산미술관, 김삿갓 묘역이 알려지기 전에는 와석계곡이라고 불렸던 김삿갓 계곡이 있다.

        [네이버 지식백과] 김삿갓 유적지 (두산백과)
        """
        static let summary = "강원도 영월군 난고 김병연(金炳淵)의 유적지"

        static let places = [
            "영월역":
                Place(
                    name: "영월역",
                    image: "young-wall.jpg",
                    address: "영월군 김삿갓면 김삿갓로 216-22",
                    contact: "033-375-7900",
                    summary: Place.summary,
                    description: Place.description),
            "고씨동굴":
                Place(
                    name: "고씨동굴",
                    image: "go-see-cave.jpg",
                    address: "영월군 김삿갓면 김삿갓로 216-22",
                    contact: "033-375-7900",
                    summary: Place.summary,
                    description: Place.description),
            "김삿갓 유적지":
                Place(
                    name: "김삿갓 유적지",
                    image: "kim-sat-god.jpg",
                    address: "영월군 김삿갓면 김삿갓로 216-22",
                    contact: "033-375-7900",
                    summary: Place.summary,
                    description: Place.description),
            "법흥사":
                Place(
                    name: "법흥사",
                    image: "bub-hung.jpg",
                    address: "영월군 김삿갓면 김삿갓로 216-22",
                    contact: "033-375-7900",
                    summary: Place.summary,
                    description: Place.description),
            "젊은달 테마파크":
                Place(
                    name: "젊은달 테마파크",
                    image: "young-moon.jpg",
                    address: "영월군 김삿갓면 김삿갓로 216-22",
                    contact: "033-375-7900",
                    summary: Place.summary,
                    description: Place.description)

        ]
        #endif
    }
}

struct PlaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PlaceDetailView(name: "영월역")
        }
    }
}
