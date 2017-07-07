//
//  State.swift
//  tomato-do
//
//  Created by IvanLazarev on 01/07/2017.
//  Copyright © 2017 Иван Лазарев. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications


class State {

    static let shared = State()

    let defaults = UserDefaults.standard

    var isRestTime: Bool {
        return counterTimer % 2 == 0
    }

    var periodDuration: Int {
        if counterTimer % 8 == 0 {
            return Constants.longRestTime
        } else if counterTimer % 2 == 0 {
            return Constants.restTime
        } else {
            return Constants.pomodoroTime
        }
    }

    fileprivate(set) var timerEndDate: Date? {
        didSet {
            defaults.set(timerEndDate, forKey: "timerEndDate")
            if let timerEndDate = timerEndDate {
                sheduleNotification(date: timerEndDate)
            } else {
                removeNotifications(withIdentifiers: [Constants.localNotificationName])
            }
        }
    }

    fileprivate(set) var counterTimer: Int {
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

    // MARK: - User Notification

    func sheduleNotification(date: Date) {
        removeNotifications(withIdentifiers: [Constants.localNotificationName])

        let content = UNMutableNotificationContent()
        content.body = isRestTime ? "Rest has ended" : "Pomodoro has ended, rest time now."
        content.sound = UNNotificationSound.default()


        let components = Calendar.current.dateComponents([.month, .day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: Constants.localNotificationName, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

    func removeNotifications(withIdentifiers identifiers: [String]) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: identifiers)
    }

    func resetState() {
        timerEndDate = nil
        counterTimer = 1
    }

    func startPeriod(task: Task) {
        self.timerEndDate = Date(timeInterval: TimeInterval(periodDuration), since: Date())
    }

    func finishPeriod() {
        timerEndDate = nil
        counterTimer += 1
    }

    func cancelPeriod() {
        timerEndDate = nil
        if isRestTime {
            counterTimer += 1
        }
    }

    func checkIfPeriodEnded() {
        guard let timerEndDate = timerEndDate else {
            return
        }
        let remainingTime = timerEndDate.timeIntervalSinceNow
        if remainingTime < 0 {
            finishPeriod()

            if isRestTime {
                let remainingTimeNext = Double(periodDuration) - abs(TimeInterval(remainingTime))
                if remainingTimeNext > 0 {
                    self.timerEndDate = Date(timeInterval: TimeInterval(remainingTimeNext), since: Date())
                } else {
                    finishPeriod()
                }
            }
        }
    }
}
