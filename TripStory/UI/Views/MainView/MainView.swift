//
//  MainView.swift
//  TripStory
//
//  Created by Gon on 2021/01/10.
//

import SwiftUI

struct MainView: View {
    @Environment(\.injected) private var injected: DIContainer
    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            ForEach(Tab.allCases) { tab in
                tab.body
                    .tabItem {
                        TabbarItem(
                            id: tab.id,
                            title: tab.title,
                            image: tab.image,
                            selectedTab: $viewModel.selectedTab
                        )
                    }
            }
        }
    }
}

extension MainView {
    struct TabbarItem: View {
        let id: Int
        let title: LocalizedStringKey
        let image: String
        @Binding var selectedTab: Int

        var body: some View {
            VStack {
                Image(systemName: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .imageScale(.large)
                if selectedTab != id {
                    Text(title)
                }
            }
        }
    }
}

extension MainView {
    class ViewModel: ObservableObject {
        @Published var selectedTab = 0
    }
}

private extension MainView {
    enum Tab: Int, CaseIterable, Identifiable {
        var id: Int { self.rawValue }
        case home, schedule, map, message, settings

        var body: some View {
            switch self {
            case .home: return AnyView(HomeView())
            case .schedule: return AnyView(ScheduleView())
            case .map: return AnyView(MapView())
            case .message: return AnyView(MessageView())
            case .settings: return AnyView(SettingsView())
            }
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
        MainView(viewModel: .init())
    }
}
