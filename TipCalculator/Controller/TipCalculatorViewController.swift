//
//  ViewController.swift
//  TipCalculator
//
//  Created by Daniel Akinniranye on 7/24/22.
//

import UIKit

class TipCalculatorViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipPercentControl: UISegmentedControl!
    @IBOutlet weak var numberOfPeopleStepper: UIStepper!
    @IBOutlet weak var numberOfPeopleLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalBillLabel: UILabel!
    @IBOutlet weak var amountPerPersonLabel: UILabel!
    
    
    var tip: Double = 0.0
    var total: Double = 0.0
    var numberOfPeople: Int = 1
    var amountPerPerson: Double = 0.0
    var currencyIndex: Int = 1
    var currencyList = ["$", "¥", "£", "€", "₦"]
    var backgroundColor: UIColor = .white

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tip Calculator"
        navigationItem.largeTitleDisplayMode = .never
        
        // Use for updating the labels whenever textfield input changes
        billAmountTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        // Begin on the textfield for easy use.
        billAmountTextField.becomeFirstResponder()
        billAmountTextField.placeholder = "\(currencyList[currencyIndex])"

        updateLabels()
    }

    @IBAction func calculateTipAmount(_ sender: UISegmentedControl) {
        performCalculation()
        updateLabels()
    }
    
    @IBAction func numberOfPeopleChanged(_ sender: Any) {
        numberOfPeople = Int(numberOfPeopleStepper.value)
        numberOfPeopleLabel.text = "\(numberOfPeople)"
        updateLabels()
    }
    
    func performCalculation() {
        // Get bill amount from text field input
        let billAmount = Double(billAmountTextField.text!) ?? 0
        
        // Get total tip by multiplying tip * the tipPercentage selected
        let percentages = [0.15, 0.18, 0.20]
        
        tip = billAmount * percentages[tipPercentControl.selectedSegmentIndex]
        total = billAmount + tip
        amountPerPerson = total / Double(numberOfPeople)
    }
    @IBAction func settingsButtonClicked(_ sender: Any) {
        let viewController = SettingsViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func updateLabels() {
        // Updating the labels
        performCalculation()
        tipAmountLabel.text = String(format: "\(currencyList[currencyIndex])%.2f", tip)// "$\(tip.formatted())"
        totalBillLabel.text = String(format: "\(currencyList[currencyIndex])%.2f", total)
        amountPerPersonLabel.text = String(format: "\(currencyList[currencyIndex])%.2f per person", amountPerPerson)
    }
    
    // Update the user interface as value in textfield changes
    @objc func textFieldDidChange() {
        // New calculation is performed.
        updateLabels()
    }
    
}




// MARK: - TipCalculatorViewController Prepare for Segue
extension TipCalculatorViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Settings" {
            if let viewController = segue.destination as? SettingsViewController  {
                // Set view controller's delegate
                viewController.delegate = self
                viewController.currency = currencyIndex
                viewController.currentAmount = total
                if backgroundColor == .black {
                    viewController.overrideUserInterfaceStyle = .dark
                    viewController.backgroundColor = .black
                } else {
                    viewController.overrideUserInterfaceStyle = .light
                    view.backgroundColor = .white
                }
            }
        }
    }
}



extension TipCalculatorViewController: SettingsViewControllerDelegate {
    
    func settingsViewController(controller: SettingsViewController, currentIndex: Int, backgroundColor: UIColor) {
        // Update properties & update the UI
        self.backgroundColor = backgroundColor
        currencyIndex = currentIndex
        updateLabels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Adapt UI to reflect the newly set properties
        billAmountTextField.placeholder = "\(currencyList[currencyIndex])"

        view.backgroundColor = backgroundColor
        if backgroundColor == .black {
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
        }
        updateLabels()
    }
}

