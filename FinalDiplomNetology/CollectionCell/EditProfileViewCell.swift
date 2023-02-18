//
//  EditProfileViewCell.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 02.02.2023.
//

import UIKit

class EditProfileViewCell: UITableViewCell {
    static var identifier = "EditProfileViewCell"
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker(frame: .zero)
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.preferredDatePickerStyle = .wheels
        //datePicker.addTarget(self, action: #selector(didChanged), for: .valueChanged)
        return datePicker
    }()
    private lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar(frame: .zero)
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: true)
        return toolBar
    }()
    
    public lazy var textField: CustomTextField = {
        let textField = CustomTextField(holder: "", colorText: ColorType.LabelTextColor.textBlackColor.rawValue, cornerRadius: 0)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: contentView.frame.height))
        textField.leftViewMode = .always
        textField.delegate = self
        textField.keyboardType = .namePhonePad
        textField.clipsToBounds = true
        textField.textAlignment = .left
        textField.inputView = datePicker
        textField.inputAccessoryView = toolBar
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    private func setupView() {
        contentView.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: contentView.topAnchor),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    private func getDateFromPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
         textField.text = formatter.string(from: datePicker.date)
    }
    
    @objc private func donedatePicker(){
        getDateFromPicker()
       self.contentView.endEditing(true)
    }
    
    @objc private func didChanged() {
        getDateFromPicker()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EditProfileViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        contentView.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if EditProfileViewController().tableView.contentOffset.y == 0 {
            let cell = textField.superview?.superview as? EditProfileViewCell
            if let cell = cell, let indexPath = EditProfileViewController().tableView.indexPath(for: cell) {
                EditProfileViewController().tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //print(#function)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}
