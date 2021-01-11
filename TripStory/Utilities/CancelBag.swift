//
//  CancelBag.swift
//  TripStory
//
//  Created by Gon on 2021/01/10.
//

import Combine

final class CancelBag {
    fileprivate(set) var subsriptions = Set<AnyCancellable>()
    
    func cancel() {
        subsriptions.removeAll()
    }
}

extension AnyCancellable {
    func store(in cancelBag: CancelBag) {
        cancelBag.subsriptions.insert(self)
    }
}
