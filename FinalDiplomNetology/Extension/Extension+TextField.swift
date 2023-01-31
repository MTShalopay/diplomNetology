//
//  Extension+TextField.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 27.01.2023.
//

import UIKit
extension UITextFieldDelegate {
    func phoneMask(phoneTextField: UITextField, textField: UITextField, _ range: NSRange, _ string: String) -> (result: Bool, phoneNumber: String, maskPhoneNumber: String) {
        let oldString = textField.text!
        let newString = oldString.replacingCharacters(in: Range(range, in: oldString)!, with: string)
        //in numString only Numeric characters
        let components = newString.components(separatedBy: CharacterSet.decimalDigits.inverted)
        let numString = components.joined(separator: "")

        let length = numString.count
        let maxCharInPhone = 11

        if newString.count < oldString.count { //backspace to work
            if newString.count <= 2 { //if now "+7(" and push backspace
                phoneTextField.text = ""
                return (false, "", "")
            } else {
                return (true, numString, newString) //will not in the process backspace
            }
        }

        if length > maxCharInPhone { // input is complete, do not add characters
            return (false, numString, newString)
        }
        var indexStart, indexEnd: String.Index
        var maskString = "", template = ""
        var endOffset = 0

        if newString == "+" { // allow add "+" if first Char
            maskString += "+"
        }
        //format +X(XXX)XXX-XXXX
        if length > 0 {
            maskString += "+"
            indexStart = numString.index(numString.startIndex, offsetBy: 0)
            indexEnd = numString.index(numString.startIndex, offsetBy: 1)
            maskString += String(numString[indexStart..<indexEnd]) + "("
        }
        if length > 1 {
            endOffset = 4
            template = ")"
            if length < 4 {
                endOffset = length
                template = ""
            }
            indexStart = numString.index(numString.startIndex, offsetBy: 1)
            indexEnd = numString.index(numString.startIndex, offsetBy: endOffset)
            maskString += String(numString[indexStart..<indexEnd]) + template
        }
        if length > 4 {
            endOffset = 7
            template = "-"
            if length < 7 {
                endOffset = length
                template = ""
            }
            indexStart = numString.index(numString.startIndex, offsetBy: 4)
            indexEnd = numString.index(numString.startIndex, offsetBy: endOffset)
            maskString += String(numString[indexStart..<indexEnd]) + template
        }
        var nIndex: Int; nIndex = 7
            //format +X(XXX)XXX-XX-XX  -> if need uncoment
            nIndex = 9

            if length > 7 {
                endOffset = 9
                template = "-"
                if length < 9 {
                    endOffset = length
                    template = ""
                }
                indexStart = numString.index(numString.startIndex, offsetBy: 7)
                indexEnd = numString.index(numString.startIndex, offsetBy: endOffset)
                maskString += String(numString[indexStart..<indexEnd]) + template
            }
        if length > nIndex {
            indexStart = numString.index(numString.startIndex, offsetBy: nIndex)
            indexEnd = numString.index(numString.startIndex, offsetBy: length)
            maskString += String(numString[indexStart..<indexEnd])
        }
        phoneTextField.text = maskString
        if length == maxCharInPhone {
            //dimiss kayboard
            phoneTextField.endEditing(true)
            return (false, numString, newString)
        }
        return (false, numString, newString)
    }
}
