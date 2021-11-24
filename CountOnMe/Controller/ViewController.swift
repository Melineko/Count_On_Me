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
        textView.text = ""
        resultView.text = ""
        
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - actions
    
    // Add numbers
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        model.calculText = textView.text
        if let resultPrint = self.resultView.text {
        model.resultText = resultPrint
        }
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        if model.expressionHaveResult {
          textView.text = ""
          resultView.text = ""
          print("Tout est éffcé.")
        }
//        if expressionHaveResult {
//            textView.text = ""
//            resultView.text = ""
//            print("Tout est éffcé.")
//        }
        textView.text.append(numberText)
        print("\(numberText) a été ajouté")
        
    }
    
    // Add operaor, decimal, clear
    @IBAction func tappedButton(_ sender: UIButton) {
        let buttonTapped = sender.tag
        model.calculText = textView.text
        if let resultPrint = self.resultView.text {
        model.resultText = resultPrint
        }
        
        if model.canAddOperator && model.expressionIsCorrect {
            // Continue operation with precedent result
            if model.expressionHaveResult {
                textView.text.removeAll()
                resultView.text = ""
                if let displayNewResult = model.makeCalcul() {
                let doubleToIntString = displayNewResult.replacingOccurrences(of: ".0", with: "")
                textView.text.append("\(doubleToIntString)")
                print("le résultat : \(doubleToIntString) a été transposé dans la textView")
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
            case 6:
                textView.text = ""
            default:
            alert(message: model.alertText)
            }
            
        } else {
            alert(message: model.alertText)
        }
    }
    
    @IBAction func decimalButton(_ sender: UIButton) {
        model.calculText = textView.text
        if !model.isDecimal{
        textView.text.append(".")
        }
        return
    }
    
    
    
    // Erase last entrie
    @IBAction func erasedButton(_ sender: UIButton) {
        if let resultPrint = self.resultView.text {
        model.resultText = resultPrint
        }
        if !model.expressionHaveResult {
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
        resultView.text = ""
    }
    

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        model.calculText = textView.text
        if let resultPrint = self.resultView.text {
        model.resultText = resultPrint
        }
        
        
        if model.expressionHaveResult {
            model.alertText = AlertText.AlertCases.haveEnoughtElements.rawValue
            alert(message: model.alertText)
        } else if model.expressionIsCorrect && model.expressionHaveEnoughElement {
            if let resultPrint = model.makeCalcul() {
                //let doubleToIntString = String(format:"%g", resultPrint)
                self.resultView.text = "= \(resultPrint)"
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


