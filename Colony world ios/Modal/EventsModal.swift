//
//  EventsModal.swift
//  Colony world ios
//
//  Created by Futuretek on 27/01/23.
//

import Foundation

// MARK: - EventsModal
struct EventsModal: Codable {
    let events: [Event]
}

// MARK: - Event
struct Event: Codable {
    let id: Int
    let title, start, end,event_desc: String
}
