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
    func tableViewCell(_ cell: TableViewCell, didChangeCheckBox value: Bool)
    func tableViewCellDidTapPomodoroButton(_ cell: TableViewCell)
}

class TableViewCell: FMMoveTableViewCell {

    weak var delegate: TableViewCellDelegate?

    @IBOutlet weak var editTaskTextField: UITextField!
    @IBOutlet weak var checkBox: BEMCheckBox!
    @IBOutlet weak var goToTimerTap: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var taskNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        editTaskTextField.isHidden = true
        checkBox.delegate = self
    }

    func configure(with task: Task) {
        selectionStyle = UITableViewCellSelectionStyle.none
        taskNameLabel.text = task.taskToDo
        //textLabel?.text = task.taskToDo
        checkBox.lineWidth = 1.5
        checkBox.on = task.checkBoxValue
        if task.checkBoxValue == true {
            goToTimerTap.isEnabled = false
            editTaskTextField.isEnabled = false
            checkBox.onTintColor = .gray
            checkBox.onCheckColor = .gray
            containerView.alpha = 0.4
        } else {
            goToTimerTap.isEnabled = true
            editTaskTextField.isEnabled = true
            checkBox.onTintColor = .red
            checkBox.onCheckColor = .red
            containerView.alpha = 1
        }
    }

    @IBAction func pomodoroButtonTap(_ sender: Any) {
        delegate?.tableViewCellDidTapPomodoroButton(self)
    }

    func enterEditMode() {
        editTaskTextField.isHidden = false
        editTaskTextField.becomeFirstResponder()
        editTaskTextField.font = taskNameLabel.font
        taskNameLabel.isHidden = true
        editTaskTextField.text = taskNameLabel.text
    }

    func editAndSaveLabel() {
        taskNameLabel.text = editTaskTextField.text
        editTaskTextField.isHidden = true
        taskNameLabel.isHidden = false
        delegate?.tableViewCell(self, didChangeLabelText: editTaskTextField.text!)
    }
}


extension TableViewCell: BEMCheckBoxDelegate {
    func animationDidStop(for checkBox: BEMCheckBox) {
        delegate?.tableViewCell(self, didChangeCheckBox: checkBox.on)
    }
}


extension TableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        editTaskTextField.resignFirstResponder()
        editAndSaveLabel()

        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        editAndSaveLabel()
    }
}
