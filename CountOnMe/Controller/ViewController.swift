//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - outlets
    @IBOutlet weak var resultView: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet weak var eraseButton: UIButton!
    @IBOutlet weak var ACButton: UIButton!
    @IBOutlet var operatorButtons: [UIButton]!
    @IBOutlet weak var pointDecimalButton: UIButton!
    @IBOutlet weak var equalButton: UIButton!

    
    // Import the model
    private let model = CountOnMeModel()
    
    var expressionHaveResult: Bool {
          return textView.text.firstIndex(of: "=") != nil
 }
    
    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    
    
    // MARK: - style
    private func cornerRad(button: UIButton){
            button.layer.cornerRadius = 20
        }
    
    // Round angle style of buttons
    private func buttonStyle(){
        for button in numberButtons{
        cornerRad(button: button)
        }
        for button in operatorButtons{
        cornerRad(button: button)
        }
        cornerRad(button: eraseButton)
        cornerRad(button: ACButton)
        cornerRad(button: pointDecimalButton)
        cornerRad(button: equalButton)
    }
    
    
    // MARK: - viewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonStyle()
        textView.text = "1 + 2 = 3"
        
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - actions
    
    // Add numbers
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        model.calculText = textView.text
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        if expressionHaveResult {
            textView.text = ""
        }
        textView.text.append(numberText)
        
    }
    
    // Add operaor, decimal, clear
    @IBAction func tappedButton(_ sender: UIButton) {
        let buttonTapped = sender.tag
        model.calculText = textView.text
        
        if model.canAddOperator && model.expressionIsCorrect {
            // Continue operation with precedent result
            if model.expressionHaveResult {
                textView.text.removeAll()
                if let displayNewResult = model.elements.last {
                textView.text.append("\(displayNewResult)")
                }
            }
            
            switch buttonTapped {
            case 1:
                textView.text.append(" - ")
            case 2:
                textView.text.append(" + ")
            case 3:
                textView.text.append(" x ")
            case 4:
                textView.text.append(" / ")
            case 5:
                textView.text.append(".")
            case 6:
                textView.text = ""
            default:
            alert(message: model.alertText)
            }
            
        } else {
            alert(message: model.alertText)
        }
    }
    
    // Erase last entrie
    @IBAction func erasedButton(_ sender: UIButton) {
        if !expressionHaveResult {
            if textView.text.last == " " {
                textView.text.removeLast()
            }
        let newEntrie = String(textView.text.dropLast())
        textView.text = ("\(newEntrie)")
            print ("\(newEntrie)")// to check in console
            print ("\(model.calculText)")
        } else {
            model.alertText = AlertText.AlertCases.haveEnoughtElements.rawValue
            alert(message: model.alertText)
            return
        }
        
    }
    
    // Clear All
    @IBAction func allClear(_ sender: UIButton) {
        textView.text = ""
    }
    

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        model.calculText = textView.text
        
        if expressionHaveResult {
            model.alertText = AlertText.AlertCases.haveEnoughtElements.rawValue
            alert(message: model.alertText)
        } else if model.expressionIsCorrect && model.expressionHaveEnoughElement {
            if let resultPrint = model.makeCalcul() {
                let doubleToIntString = resultPrint.replacingOccurrences(of: ".0", with: "")
                self.resultView.text = "= \(doubleToIntString)"
            }
        } else {
            alert(message:model.alertText)
        }
    }
    
    func alert(message: String) {
        let alertVC = UIAlertController(title: "Erreur!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

}

