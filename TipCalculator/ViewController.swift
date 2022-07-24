//
//  ViewController.swift
//  TipCalculator
//
//  Created by Daniel Akinniranye on 7/24/22.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipPercentControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func calculateTipAmount(_ sender: UISegmentedControl) {
        // Get bill amount from text field input
        let billAmount = Double(billAmountTextField.text!) ?? 0
        
        // Get total tip by multiplying tip * the tipPercentage selected
        let percentages = [0.15, 0.18, 0.20]
        let tip = billAmount * percentages[tipPercentControl.selectedSegmentIndex]
        
        let total = billAmount + tip
        
        // Updating the labels
        tipAmountLabel.text = "$\(tip)"
        totalLabel.text = "$\(total)"
    }
    
}

