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
        form +++ Section("Period setup")
            <<< IntRow {
                $0.title = "Pomodoro Duration"
                $0.value = Settings.shared.pomodoroDuration / 60
            }.onChange {
                if let value = $0.value {
                    Settings.shared.pomodoroDuration = value * 60
                }
            }
            <<< IntRow {
                $0.title = "Short Break Duration"
                $0.value = Settings.shared.shortBreakDuration / 60
            }.onChange {
                if let value = $0.value {
                    Settings.shared.shortBreakDuration = value * 60
                }
            }
            <<< IntRow {
                $0.title = "Long Break Duration"
                $0.value = Settings.shared.longBreakDuration / 60
            }.onChange {
                if let value = $0.value {
                    Settings.shared.longBreakDuration = value * 60
                }
            }
            +++ Section("Sound setup")
            <<< SwitchRow { row in
                row.title = "Sound OFF"
            }.onChange { row in
                row.title = (row.value ?? false) ? "Sound ON" : "Sound OFF"
                row.updateCell()
        }
    }
}