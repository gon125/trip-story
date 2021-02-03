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
        self.place = Place(name: name)
    }
    var body: some View {
        Text(place.name)
    }
}

extension PlaceDetailView {
    struct Place {
        let name: String
    }
}

struct PlaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetailView(name: "")
    }
}
