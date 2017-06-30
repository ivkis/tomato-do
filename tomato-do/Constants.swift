//
//  Constants.swift
//  tomato-do
//
//  Created by IvanLazarev on 30/06/2017.
//  Copyright © 2017 Иван Лазарев. All rights reserved.
//

import Foundation
import UIKit


enum Constants {
    static let pomodoroTime = 5
    static let restTime = 2
    static let longRestTime = 15
}


extension UIColor {
    enum Tomatodo {
        static let red = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        static let orange = #colorLiteral(red: 0.9354019761, green: 0.3499509096, blue: 0.1937675774, alpha: 1)
        static let blue = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        static let darkBlue = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
    }
}
