//
//  State.swift
//  tomato-do
//
//  Created by IvanLazarev on 01/07/2017.
//  Copyright © 2017 Иван Лазарев. All rights reserved.
//

import Foundation
import UIKit

class State {

    static let shared = State()

    let defaults = UserDefaults.standard

    var isRestTime: Bool {
        return counterTimer % 2 == 0
    }

    var timerEndDate: Date? {
        didSet {
            defaults.set(timerEndDate, forKey: "timerEndDate")
        }
    }

    var counterTimer: Int {
        didSet {
            defaults.set(counterTimer, forKey: "counterTimer")
        }
    }

    var currentPomodoroIndex: Int {
        return counterTimer / 2
    }

    init() {
        self.timerEndDate = defaults.object(forKey: "timerEndDate") as? Date

        let lastRunDate = defaults.object(forKey: "dateLastRun") as? Date
        if let lastRunDate = lastRunDate, Calendar.current.compare(lastRunDate, to: Date(), toGranularity: .day) == .orderedSame {
            self.counterTimer = max(1, defaults.integer(forKey: "counterTimer"))
        } else {
            self.counterTimer = 1
        }
        defaults.set(Date(), forKey: "dateLastRun")
    }

    func sheduleTimerEnd(in timeInterval: TimeInterval) {
        self.timerEndDate = Date(timeInterval: timeInterval, since: Date())
    }
}
