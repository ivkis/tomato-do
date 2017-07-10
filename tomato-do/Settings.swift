//
//  Settings.swift
//  tomato-do
//
//  Created by IvanLazarev on 10/07/2017.
//  Copyright © 2017 Иван Лазарев. All rights reserved.
//

import Foundation


class Settings {
    enum DefaultsKeys {
        static let pomodoroDuration = "pomodoroDuration"
        static let shortBreakDuration = "shortBreakDuration"
        static let longBreakDuration = "longBreakDuration"
    }

    static let shared = Settings()
    let defaults = UserDefaults.standard

    var pomodoroDuration: Int {
        didSet {
            defaults.set(pomodoroDuration, forKey: DefaultsKeys.pomodoroDuration)
        }
    }

    var shortBreakDuration: Int {
        didSet {
            defaults.set(shortBreakDuration, forKey: DefaultsKeys.shortBreakDuration)
        }
    }

    var longBreakDuration: Int {
        didSet {
            defaults.set(longBreakDuration, forKey: DefaultsKeys.longBreakDuration)
        }
    }

    init() {
        defaults.register(defaults: [DefaultsKeys.pomodoroDuration: 1500, DefaultsKeys.shortBreakDuration: 300, DefaultsKeys.longBreakDuration: 900])
        self.pomodoroDuration = defaults.integer(forKey: DefaultsKeys.pomodoroDuration)
        self.shortBreakDuration = defaults.integer(forKey: DefaultsKeys.shortBreakDuration)
        self.longBreakDuration = defaults.integer(forKey: DefaultsKeys.longBreakDuration)
    }
}
