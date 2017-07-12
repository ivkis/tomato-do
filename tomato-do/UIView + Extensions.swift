//
//  UIView + Extensions.swift
//  tomato-do
//
//  Created by IvanLazarev on 11/07/2017.
//  Copyright © 2017 Иван Лазарев. All rights reserved.
//

import UIKit


extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
