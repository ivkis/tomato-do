//
//  Settings.swift
//  tomato-do
//
//  Created by IvanLazarev on 10/07/2017.
//  Copyright © 2017 Иван Лазарев. All rights reserved.
//

import Foundation


class Settings {
    enum SpeechRecognitionLocale: String {
        case english = "en_US"
        case russian = "ru_RU"
    }
    enum DefaultsKeys {
        static let pomodoroDuration = "pomodoroDuration"
        static let shortBreakDuration = "shortBreakDuration"
        static let longBreakDuration = "longBreakDuration"
        static let targetPomodorosPerDay = "targetPomodoros"
        static let tickStatusSound = "tickStatusSound"
        static let languageSpeechRecognition = "languageSpeechRecognition"
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

    var targetPomodoros: Int {
        didSet {
            defaults.set(targetPomodoros, forKey: DefaultsKeys.targetPomodorosPerDay)
        }
    }

    var speechRecognitionLocale: SpeechRecognitionLocale {
        didSet {
            defaults.set(speechRecognitionLocale.rawValue, forKey: DefaultsKeys.languageSpeechRecognition)
        }
    }

    var tickSoundStatus: Bool {
        didSet {
            defaults.set(tickSoundStatus, forKey: DefaultsKeys.tickStatusSound)
        }
    }

    init() {
        defaults.register(defaults: [
            DefaultsKeys.pomodoroDuration: 1500,
            DefaultsKeys.shortBreakDuration: 300,
            DefaultsKeys.longBreakDuration: 900,
            DefaultsKeys.targetPomodorosPerDay: 13
        ])
        self.pomodoroDuration = defaults.integer(forKey: DefaultsKeys.pomodoroDuration)
        self.shortBreakDuration = defaults.integer(forKey: DefaultsKeys.shortBreakDuration)
        self.longBreakDuration = defaults.integer(forKey: DefaultsKeys.longBreakDuration)
        self.targetPomodoros = defaults.integer(forKey: DefaultsKeys.targetPomodorosPerDay)
        let defaultSpeechRecognitionLocale = SpeechRecognitionLocale(rawValue: Locale.current.languageCode ?? "") ?? .english
        self.speechRecognitionLocale = SpeechRecognitionLocale(rawValue: defaults.string(forKey: DefaultsKeys.languageSpeechRecognition) ?? "") ?? defaultSpeechRecognitionLocale
        self.tickSoundStatus = defaults.bool(forKey: DefaultsKeys.tickStatusSound)
    }
}
