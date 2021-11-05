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
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet weak var eraseButton: UIButton!
    @IBOutlet weak var ACButton: UIButton!
    @IBOutlet var operatorButtons: [UIButton]!
    @IBOutlet weak var pointDecimalButton: UIButton!
    @IBOutlet weak var equalButton: UIButton!
    
    
    
    private let model = CountOnMeModel()
    
    var expressionHaveResult: Bool {
          return textView.text.firstIndex(of: "=") != nil
 }
    
    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    
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
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        if expressionHaveResult {
            textView.text = ""
        }
        textView.text.append(numberText)
        let numberComplete = textView.text!
        model.addElement(element: numberComplete)
        
    }
    
    // Add operaor, decimal, clear
    @IBAction func tappedButton(_ sender: UIButton) {
        let buttonTapped = sender.tag
        if model.operatorChecking() {
            switch buttonTapped {
            case 1:
                model.addOperator(element: "-")
                textView.text.append(" - ")
            case 2:
                model.addOperator(element: "+")
                textView.text.append(" + ")
            case 3:
                model.addOperator(element: "x")
                textView.text.append(" x ")
            case 4:
                model.addOperator(element: "/")
                textView.text.append(" / ")
            case 5:
                model.addDecimal()
                textView.text.append(".")

            case 6:
                textView.text = ""
                model.clearAllElements()
            default:
            alert(message: model.alertText)
            }
            
        } else {
            alert(message: model.alertText)
        }
    }
    
    @IBAction func erasedButton(_ sender: UIButton) {
        if !expressionHaveResult {
        model.elements.removeLast(1)
        let newEntrie = String(textView.text.dropLast(1))
        print ("\(newEntrie)")
        textView.text = ("\(newEntrie)")
        } else {
            return
        }
        
    }
    
    
    @IBAction func allClear(_ sender: UIButton) {
        model.clearAllElements()
        textView.text = ""
    }
    

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard model.expressionIsCorrect else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        guard model.expressionHaveEnoughElement else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
            }
        
        if expressionHaveResult{
            alert(message: model.alertText)
        }else{
    model.displayResult = (" = \(String(describing: model.makeCalcul()))")
     if let resultPrint = model.makeCalcul() {
         textView.text.append(" = \(resultPrint)")
        }
        }
    }
    
    func alert(message: String) {
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

}

