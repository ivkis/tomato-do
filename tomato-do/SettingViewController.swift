//
//  SettingViewController.swift
//  tomato-do
//
//  Created by IvanLazarev on 10/07/2017.
//  Copyright © 2017 Иван Лазарев. All rights reserved.
//

import Foundation
import Eureka


class SettingViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettingViewController()
    }

    func setupSettingViewController() {
        form +++ Section(NSLocalizedString("", comment: ""))
            <<< IntRow {
                $0.title = NSLocalizedString("Pomodoro Duration, min", comment: "Pomodoro Duration, min")
                $0.value = Settings.shared.pomodoroDuration / 60
            }.onChange {
                if let value = $0.value {
                    Settings.shared.pomodoroDuration = value * 60
                }
            }
            <<< IntRow {
                $0.title = NSLocalizedString("Short Break Duration, min", comment: "Short Break Duration, min")
                $0.value = Settings.shared.shortBreakDuration / 60
            }.onChange {
                if let value = $0.value {
                    Settings.shared.shortBreakDuration = value * 60
                }
            }
            <<< IntRow {
                $0.title = NSLocalizedString("Long Break Duration, min", comment: "Long Break Duration, min")
                $0.value = Settings.shared.longBreakDuration / 60
            }.onChange {
                if let value = $0.value {
                    Settings.shared.longBreakDuration = value * 60
                }
            }
            +++ Section(NSLocalizedString("", comment: ""))
            <<< IntRow {
                $0.title = NSLocalizedString("Target Pomodoros Per Day", comment: "Target Pomodoros Per Day")
                $0.value = Settings.shared.targetPomodoros
                }.onChange {
                    if let value = $0.value {
                        Settings.shared.targetPomodoros = value
                }
            }
            +++ SegmentedRow<Settings.SpeechRecognitionLocale> { row in
                row.title = NSLocalizedString("Speech recognition locale", comment: "Speech recognition locale")
                row.options = [.english, .russian]
                row.value = Settings.shared.speechRecognitionLocale
                row.cell.segmentedControl.tintColor = UIColor.Tomatodo.orange
            }.onChange { row in
                    Settings.shared.speechRecognitionLocale = row.value ?? .english
            }
            <<< SwitchRow { row in
                row.title = NSLocalizedString("Sound OFF", comment: "Sound OFF")
                row.value = Settings.shared.tickSoundStatus
                row.cell.switchControl.onTintColor = UIColor.Tomatodo.orange
            }.onChange { row in
                let value = row.value ?? false
                row.title = value ? NSLocalizedString("Sound ON", comment: "Sound ON") : NSLocalizedString("Sound OFF", comment: "Sound OFF")
                Settings.shared.tickSoundStatus = value
                row.updateCell()
            }

    }
}
