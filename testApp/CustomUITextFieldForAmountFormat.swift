//
//  CustomUITextFieldForAmountFormat.swift
//  testApp
//
//  Created by cimbth on 4/8/2561 BE.
//  Copyright © 2561 Klang. All rights reserved.
//
import Foundation
import UIKit

class CustomUITextFieldForAmountFormat: UITextField {
    var amountText: UITextField!
    
    public var numberOfDigit: Int = 0
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        delegate = self
    }
}


extension CustomUITextFieldForAmountFormat: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (numberOfDigit == 0 && string == ".") {
            return false
        }
        
        if (string.count != 0 && string != "." && (Int(string) == nil)) {
            return false
        }
        
        guard let oldText = textField.text, let r = Range(range, in: oldText) else {
            return true
        }
        
        let newTextWithCurrencyFormat = oldText.replacingCharacters(in: r, with: string)
        var newText = newTextWithCurrencyFormat.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
        
        let isNumeric = newText.isEmpty || (Double(newText) != nil)
        let numberOfDots = newText.components(separatedBy: ".").count - 1
        let isFirstWithZero:Bool = newText != "00" ? true : false

        let dotIndex = newText.index(of: ".")
        let numberOfDecimalDigits = dotIndex != nil ? (newText.distance(from: dotIndex!, to: newText.endIndex)-1) : 0
        
        if (isNumeric && numberOfDots <= 1 && numberOfDecimalDigits <= numberOfDigit && isFirstWithZero) {
            if dotIndex == nil && newText != "" {
                let formatter = getCurrencyFormat(numberOfDot: 0)
                let double = (newText as NSString).doubleValue
                newText = formatter.string(from: NSNumber(value: double))!
            } else {
                newText = newTextWithCurrencyFormat
            }
            
            textField.text = newText
        }
        
        return false
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let formatter = getCurrencyFormat(numberOfDot: numberOfDigit)
        
        var amount:String = textField.text!
        amount = amount.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
        if (amount == "") {
            textField.text = amount
        } else {
            let double = (amount as NSString).doubleValue
            textField.text = formatter.string(from: NSNumber(value: double))
        }
    }
    
    private func getCurrencyFormat(numberOfDot : Int) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = ""
        formatter.maximumFractionDigits = numberOfDot
        formatter.minimumFractionDigits = numberOfDot
        
        return formatter
    }
}
