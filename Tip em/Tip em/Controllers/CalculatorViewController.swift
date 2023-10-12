//
//  ViewController.swift
//  Tip em
//
//  Created by Aaraiz Wasim on 12/10/2023.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var billTextField: UITextField!
    var numberOfPeople = 2
    var tip = 0.10
    var billTotal = 0.0
    var finalResult = "0.0"
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        let newValue = sender.value
                
        splitNumberLabel.text = String(format: "%.0f", sender.value)
                
                //Set the numberOfPeople property as the value of the stepper as a whole number.
                numberOfPeople = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        let bill = billTextField.text!
                if bill != "" {
                    billTotal = Double(bill)!
                    let result = billTotal * (1 + tip) / Double(numberOfPeople)
                    finalResult = String(format: "%.2f", result)
                }
        
        performSegue(withIdentifier: "nextScreen", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nextScreen" {
                    
                    //Get hold of the instance of the destination VC and type cast it to a ResultViewController.
                    let destinationVC = segue.destination as! ResultsViewController
                    
                    //Set the destination ResultsViewController's properties.
                    destinationVC.result = finalResult
                    destinationVC.tip = Int(tip * 100)
                    destinationVC.split = numberOfPeople
                }
    }
    
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        zeroPctButton.isSelected = false
                tenPctButton.isSelected = false
                twentyPctButton.isSelected = false
                sender.isSelected = true
                
                let buttonTitle = sender.currentTitle!
                let buttonTitleMinusPercentSign =  String(buttonTitle.dropLast())
                let buttonTitleAsANumber = Double(buttonTitleMinusPercentSign)!
                tip = buttonTitleAsANumber / 100

    }
}

