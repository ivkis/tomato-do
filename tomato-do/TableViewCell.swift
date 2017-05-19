//
//  TableViewCell.swift
//  tomato-do
//
//  Created by IvanLazarev on 12/05/2017.
//  Copyright © 2017 Иван Лазарев. All rights reserved.
//

import UIKit
import BEMCheckBox
import FMMoveTableView

protocol TableViewCellDelegate: class {
    func tableViewCell(_ cell: TableViewCell, didChangeLabelText text: String)
}

class TableViewCell: FMMoveTableViewCell, UITextFieldDelegate {

    weak var delegate: TableViewCellDelegate?

    @IBOutlet weak var editTaskTextField: UITextField!
    @IBOutlet weak var checkBox: BEMCheckBox!

    override func awakeFromNib() {
        super.awakeFromNib()
        editTaskTextField.isHidden = true
        editTaskTextField.delegate = self
    }

    func enterEditMode() {
        editTaskTextField.isHidden = false
        editTaskTextField.becomeFirstResponder()
        editTaskTextField.font = textLabel?.font
        textLabel?.isHidden = true
        editTaskTextField.text = textLabel?.text
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        editTaskTextField.resignFirstResponder()
        editAndSaveLabel()

        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        editAndSaveLabel()
    }

    func editAndSaveLabel() {
        textLabel?.text = editTaskTextField.text
        delegate?.tableViewCell(self, didChangeLabelText: editTaskTextField.text!)
    }
}
