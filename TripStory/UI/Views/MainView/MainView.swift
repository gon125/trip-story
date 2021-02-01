//
//  MainView.swift
//  TripStory
//
//  Created by Gon on 2021/01/10.
//

import SwiftUI

struct MainView: View {
    @State private var selection: Tab = .home

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                TabView(selection: $selection) {
                    selection.body()
                }
                .onAppear { UITabBar.appearance().isHidden = true }

                Color.white
                    .frame(height: 30)

                ZStack {
                    Color.white
                        .frame(height: 70)
                        .cornerRadius(30, corners: [.topLeft, .topRight])

                    HStack(spacing: .horizontalPadding) {
                        ForEach(Tab.allCases) { tab in
                            tab.tabbarItem(selection: $selection)
                        }
                    }
                    .frame(height: 70)
                }
                .padding(.bottom, geo.safeAreaInsets.bottom + 5)

            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .accentColor(.white)

    }

}

extension MainView {

    struct TabbarItem: View {
        let id: Int
        let title: LocalizedStringKey
        let image: String
        @Binding var selectedTab: Tab
        var isSelected: Bool {
            selectedTab.rawValue == id
        }

        var body: some View {
            Button(
                action: { selectedTab = Tab(rawValue: id)! },
                label: {
                    VStack(alignment: .center, spacing: 3) {
                        if isSelected {
                            Image(systemName: image)
                                .font(.largeTitle)
                                .padding()
                                .background(Color.major)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 3))
                        } else {
                            Image(systemName: image)
                            Text(title)
                                .font(.tabbarText)
                        }
                    }
                    .foregroundColor(.major)
                    .offset(y: isSelected ? -15 : 0)
                }
            )
        }
    }

    enum Tab: Int, CaseIterable, Identifiable {
        var id: Int { self.rawValue }
        case home, schedule, map, message, settings

        @ViewBuilder
        func body() -> some View {
            switch self {
            case .home: HomeView()
            case .schedule: ScheduleView()
            case .map: MapView()
            case .message: MessageView()
            case .settings: SettingsView()
            }
        }

        @ViewBuilder
        func tabbarItem(selection: Binding<Tab>) -> some View {
            TabbarItem(id: id, title: title, image: image, selectedTab: selection)
        }

        var title: LocalizedStringKey {
            switch self {
            case .home: return "Home"
            case .schedule: return "Schedule"
            case .map: return "Map"
            case .message: return "Message"
            case .settings: return "Setting"
            }
        }

        var image: String {
            switch self {
            case .home: return "house"
            case .schedule: return "doc.text"
            case .map: return "map"
            case .message: return "ellipsis.bubble"
            case .settings: return "gearshape.fill"
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
