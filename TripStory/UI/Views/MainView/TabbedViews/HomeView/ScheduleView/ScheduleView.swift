//
//  ScheduleView.swift
//  TripStory
//
//  Created by Gon on 2021/01/21.
//

import SwiftUI

struct ScheduleView: View {
    @Environment(\.injected) private var injected: DIContainer
    let schedules: [Schedule] = Schedule.schedules
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(schedules) { schedule in
                    NavigationLink(destination: PlaceDetailView(name: schedule.name)) {
                        ScheduleCell(schedule: schedule)
                            .padding(.horizontal, .homeViewHorizontalPadding)
                            .foregroundColor(.black)
                    }

                }
            }
        }
        .onAppear { injected.appState[\.routing.mainViewRouting] = .schedule}
        .navigationTitle("Schedule Detail")
    }
}

extension ScheduleView {
    struct Schedule: Identifiable {
        let id = UUID()
        let name: String
        let image: String
        let visitDate: Date

        static let schedules = [
            Schedule(name: "영월역", image: "young-wall.jpg", visitDate: Date(timeIntervalSince1970: 123421)),
            Schedule(name: "고씨동굴", image: "go-see-cave.jpg", visitDate: Date(timeIntervalSince1970: 12323421)),
            Schedule(name: "김삿갓 유적지", image: "kim-sat-god.jpg", visitDate: Date(timeIntervalSince1970: 121273421)),
            Schedule(name: "법흥사", image: "bub-hung.jpg", visitDate: Date(timeIntervalSince1970: 67123421)),
            Schedule(name: "젊은달 테마파크", image: "young-moon.jpg", visitDate: Date(timeIntervalSince1970: 112443421))
        ]
    }

    struct ScheduleCell: View {
        let schedule: Schedule

        private static let formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "M/d - a hh:mm"
            return formatter
        }()

        var body: some View {
            VStack {
                HStack(alignment: .firstTextBaseline) {
                    Text(schedule.name)
                        .font(.tableCellTitle)
                    Text("\(schedule.visitDate, formatter: ScheduleCell.formatter)")
                        .font(.tableCellSubtitle)
                    Spacer()
                }
                HStack {
                    Image("schedule-cell-left-dots")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: .scheduleViewImageHeight - 10)
                    ImageView(url: schedule.image, height: .scheduleViewImageHeight)
                }
            }
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
