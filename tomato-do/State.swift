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
    let currentDate = Date()

    var counterTimer: Int {
        didSet {
            defaults.set(counterTimer, forKey: "counterTimer")
        }
    }

    var currentPomodoroIndex: Int {
        return counterTimer / 2
    }

    init() {
        let lastRunDate = defaults.object(forKey: "dateLastRun") as? Date
        if let lastRunDate = lastRunDate, Calendar.current.compare(lastRunDate, to: currentDate, toGranularity: .day) == .orderedSame {
            self.counterTimer = max(1, defaults.integer(forKey: "counterTimer"))
        } else {
            self.counterTimer = 1
        }
        defaults.set(currentDate, forKey: "dateLastRun")
    }
}
