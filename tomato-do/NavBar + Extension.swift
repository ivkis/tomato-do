//
//  NavBar + Extension.swift
//  tomato-do
//
//  Created by IvanLazarev on 10/07/2017.
//  Copyright © 2017 Иван Лазарев. All rights reserved.
//

import UIKit


extension UINavigationController {
    func pomodoroUI() {
        self.navigationBar.barTintColor = UIColor.Tomatodo.orange
        self.navigationBar.barStyle = UIBarStyle.black
        self.navigationBar.tintColor = UIColor.white
    }

    func restUI() {
        self.navigationBar.barTintColor = UIColor.Tomatodo.darkBlue
        self.navigationBar.barStyle = UIBarStyle.black
        self.navigationBar.tintColor = UIColor.white
    }
}
