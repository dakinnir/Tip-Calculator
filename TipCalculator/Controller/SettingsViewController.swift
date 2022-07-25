//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Daniel Akinniranye on 7/24/22.
//

import Foundation
import UIKit

protocol SettingsViewControllerDelegate {
    func settingsViewController(
        controller: SettingsViewController,
        currentIndex: Int,
        backgroundColor: UIColor
    )
}

class SettingsViewController: UIViewController {
    

    // MARK: - Properties
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var currentAmountLabel: UILabel!
    
    
    var currencyList = ["$", "¥", "£", "€", "₦"]
    var currency: Int? = 0
    var backgroundColor: UIColor? = .white
    var currentAmount: Double? = 0.0
    
    var delegate: SettingsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        
        // Update UI when values are passed over
        if let currency = currency, let amount = currentAmount {
            currencyPicker.selectRow(currency, inComponent: 0, animated: true)
            currentAmountLabel.text = String(format: "\(currencyList[currency])%.2f", amount)
        }
        if backgroundColor == .black {
            darkModeSwitch.isOn = true
        } else {
            darkModeSwitch.isOn = false
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        print("hello")
        // Call delegate method
        currency = currencyPicker.selectedRow(inComponent: 0)
        if let currency = currency, let color = backgroundColor {
            delegate?.settingsViewController(controller: self, currentIndex: currency, backgroundColor: color)
        }
    }
    
    @IBAction func darkModeSwitch(_ sender: UISwitch) {
        // Toggle on
        if sender.isOn {
            overrideUserInterfaceStyle = .dark
            backgroundColor = .black
            view.backgroundColor = backgroundColor
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            
        } else {
            overrideUserInterfaceStyle = .light
            backgroundColor = .white
            view.backgroundColor = backgroundColor
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
//            
        }
    }
}

// MARK: - SettingsViewController UIPickerView Delegate & Data Source

extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // Currency Picker View Titles
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyList.count
    }
}
