//
//  TableViewCell.swift
//  tomato-do
//
//  Created by IvanLazarev on 12/05/2017.
//  Copyright © 2017 Иван Лазарев. All rights reserved.
//

import UIKit
import BEMCheckBox


class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkBox: BEMCheckBox!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
