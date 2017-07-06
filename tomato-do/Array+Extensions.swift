//
//  Array+Extensions.swift
//  tomato-do
//
//  Created by IvanLazarev on 16/05/2017.
//  Copyright © 2017 Иван Лазарев. All rights reserved.
//


extension Array {
    mutating func rearrange(from: Int, to: Int) {
        insert(remove(at: from), at: to)
    }
}
