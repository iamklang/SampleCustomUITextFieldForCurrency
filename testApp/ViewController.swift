//
//  ViewController.swift
//  testApp
//
//  Created by cimbth on 4/8/2561 BE.
//  Copyright © 2561 Klang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var amountText: CustomUITextFieldForAmountFormat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAmountInput()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setupAmountInput () {
        amountText.keyboardType = .decimalPad
        amountText.numberOfDigit = 2
        
        self.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
